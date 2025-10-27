import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'print_log.dart';

class NetworkHelper {
  static NetworkHelper? _instance;
  static NetworkHelper get instance {
    _instance ??= NetworkHelper._();
    return _instance!;
  }

  NetworkHelper._();

  /// Safely execute network operations with proper error handling
  static Future<T?> safeNetworkCall<T>(
    Future<T> Function() networkCall, {
    String? operationName,
    T? fallbackValue,
  }) async {
    try {
      printLog('🌐 Starting network operation: ${operationName ?? 'Unknown'}');
      
      final result = await networkCall();
      
      printLog('✅ Network operation completed: ${operationName ?? 'Unknown'}');
      return result;
    } on SocketException catch (e) {
      printLog('🚫 Socket error in ${operationName ?? 'network operation'}: $e');
      return fallbackValue;
    } on TimeoutException catch (e) {
      printLog('⏰ Timeout error in ${operationName ?? 'network operation'}: $e');
      return fallbackValue;
    } on HttpException catch (e) {
      printLog('🌐 HTTP error in ${operationName ?? 'network operation'}: $e');
      return fallbackValue;
    } catch (e) {
      printLog('❌ Unexpected error in ${operationName ?? 'network operation'}: $e');
      
      // Check if it's the specific network profiling error
      if (e.toString().contains('network_profiling.dart') || 
          e.toString().contains('_idToSocketStatistic')) {
        printLog('🔧 Network profiling error detected - this is a known Flutter issue');
        // Don't rethrow this specific error, just log it
        return fallbackValue;
      }
      
      return fallbackValue;
    }
  }

  /// Execute network operation with retry mechanism
  static Future<T?> safeNetworkCallWithRetry<T>(
    Future<T> Function() networkCall, {
    String? operationName,
    T? fallbackValue,
    int maxRetries = 3,
    Duration retryDelay = const Duration(seconds: 1),
  }) async {
    for (int attempt = 1; attempt <= maxRetries; attempt++) {
      try {
        return await safeNetworkCall(
          networkCall,
          operationName: '${operationName ?? 'Unknown'} (attempt $attempt)',
          fallbackValue: fallbackValue,
        );
      } catch (e) {
        if (attempt == maxRetries) {
          printLog('🚨 All retry attempts failed for ${operationName ?? 'network operation'}');
          return fallbackValue;
        }
        
        printLog('🔄 Retrying ${operationName ?? 'network operation'} in ${retryDelay.inSeconds}s...');
        await Future.delayed(retryDelay);
      }
    }
    return fallbackValue;
  }

  /// Check if error is related to network profiling issue
  static bool isNetworkProfilingError(dynamic error) {
    final errorString = error.toString().toLowerCase();
    return errorString.contains('network_profiling.dart') ||
           errorString.contains('_idtosocketstatistic') ||
           errorString.contains('collectstatistic') ||
           errorString.contains('_rawsocket.close');
  }

  /// Handle network profiling errors gracefully
  static void handleNetworkProfilingError(dynamic error, String context) {
    if (isNetworkProfilingError(error)) {
      printLog('🔧 Network profiling error in $context - ignoring (known Flutter issue)');
      if (kDebugMode) {
        printLog('📋 Error details: $error');
      }
    } else {
      printLog('❌ Unexpected error in $context: $error');
      if (kDebugMode) {
        throw error; // Re-throw in debug mode for proper debugging
      }
    }
  }
}
