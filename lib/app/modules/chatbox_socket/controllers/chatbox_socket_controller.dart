import 'dart:async';
import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medi/app/core/helper/print_log.dart';
import 'package:medi/app/core/helper/shared_value_helper.dart';
import 'package:medi/app/data/remote/repository/chat/chat_repository.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:medi/app/core/config/app_config.dart';

import '../../../core/service/location_service.dart';
import '../../../core/service/translation_service.dart';
import '../../../data/remote/model/user/user_data_response.dart';

class ChatboxSocketController extends GetxController {
  final TextEditingController messageController = TextEditingController();
  final RxList<Map<String, dynamic>> messages = <Map<String, dynamic>>[].obs;
  final RxBool isSocketConnected = false.obs;
  final threadId = ''.obs;

  var requestDetail = Get.arguments ?? RequestDetail();

  // Socket.IO implementation matching React exactly
  late IO.Socket socket;


  final lat = ''.obs;
  final lon = ''.obs;
  final countryCode = ''.obs;

  @override
  void onInit() {
    super.onInit();

    // Initialize connection status to false initially
    isSocketConnected.value = false;
    printLog(
      '🔧 Initializing ChatboxSocketController - UI status set to: ${isSocketConnected.value}',
    );

    initializeSocket();
    getUserLocationBasedLanguage();
    getChatMessage();
  }
  Future<void> getUserLocationBasedLanguage() async {
    try {
      var location = await getLocation();
      lat.value = location['lat'] ?? '';
      lon.value = location['lon'] ?? '';
      List<Placemark> placemarks = await placemarkFromCoordinates(
        double.parse(lat.toString()),
        double.parse(lon.toString()),
      );
      Placemark place = placemarks.first;
      countryCode.value = place.isoCountryCode?.toString() ?? 'US';
      printLog('Country Code: ${countryCode.value}');


    } catch (e) {
      printLog('Error getting location: $e');
      countryCode.value = 'US'; // Default to US
    }
  }


  void initializeSocket() {
    printLog('🚀 Starting Socket.IO initialization (React-style)...');

    try {
      // Create socket exactly like React
      socket = IO.io(
        AppConfig.socketUrl,
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .enableAutoConnect()
            .enableReconnection()
            .setReconnectionAttempts(5)
            .setReconnectionDelay(1000)
            .setTimeout(5000)
            .build(),
      );

      // Set up listeners exactly like React
      setupSocketListeners();

      printLog('✅ Socket.IO initialization complete');
    } catch (e) {
      printLog('💥 Failed to initialize Socket.IO: $e');
      isSocketConnected.value = false;
    }
  }

  void setupSocketListeners() {
    printLog('🎧 Setting up Socket.IO listeners (React-style)...');

    // Debug listeners exactly like React
    socket.onAny((event, data) {
      printLog('🔄 OUTGOING EVENT: $event, data: $data');
    });

    // Log all incoming messages exactly like React
    socket.onAny((event, data) {
      printLog('📥 INCOMING EVENT: $event, data: $data');
    });

    // Connection events
    socket.onConnect((_) {
      printLog('🎯 Socket.IO connected!');
      isSocketConnected.value = true;

      // Send join message like React
      socket.emit('join', userId.$);
      printLog('🚀 Emitted join event for userId: ${userId.$}');
    });

    socket.onDisconnect((_) {
      printLog('🎯 Socket.IO disconnected!');
      isSocketConnected.value = false;
    });

    // Message listener exactly like React
    socket.on('message', (data) {
      printLog('📨 ===== SOCKET.IO MESSAGE RECEIVED =====');
      printLog('📨 Message data: $data');
      _handleIncomingMessage(data, 'message');
    });

    // Error handling
    socket.onConnectError((error) {
      printLog('❌ Socket.IO connection error: $error');
      isSocketConnected.value = false;
    });

    socket.onError((error) {
      printLog('❌ Socket.IO error: $error');
    });
  }

  Future<void> getChatMessage() async {
      var response = await ChatRepository().getChatData(
        userId.$,
        requestDetail.id.toString(),
      );

      if (response.success!) {
        threadId.value = response.data!.isNotEmpty
            ? response.data!.last.id.toString()
            : '';
        for (var chat in response.data!) {
          final translatedMessage = await TranslationService.translateText(
            chat.message.toString(),
            countryCode.value,
          );
          messages.add({
            'text': translatedMessage,
            'isUser': chat.sender == userId.$,
            'time': DateTime.now(),
          });
        }
      }

  }

  void sendMessage() async {
    final message = messageController.text.trim();
    if (message.isEmpty) return;


    final translatedMessage = await TranslationService.translateText(
      message.toString(),
      countryCode.value,
    );

    messages.add({
      'text': translatedMessage,
      'isUser': true,
      'time': DateTime.now(),
      'status': 'sending',
    });
    messageController.clear();

    try {
      if (socket.connected) {
        // Send message via Socket.IO exactly like React
        socket.emit('message', {
          'user': 'Me',
          'text': translatedMessage,
          'message': translatedMessage,
          'sender': userId.$,
          'receiver': requestDetail.id.toString(),
        });

        printLog('📤 Message sent via Socket.IO');
      } else {
        // Fallback to HTTP request if socket not connected
        printLog('🔄 Socket not connected, using HTTP fallback');

        var response = await ChatRepository().sendChatMessage(
          translatedMessage,
          threadId.value,
        );

        // Update thread ID if received
        if (response.data?.threadId != null) {
          threadId.value = response.data!.threadId!;
        }

        if (response.success!) {
          String extractMessage(String jsonString) {
            try {
              final Map<String, dynamic> data = json.decode(jsonString);
              return data['answer'] ?? data['message'] ?? 'No response';
            } catch (e) {
              return jsonString; // Return as-is if not valid JSON
            }
          }

          messages.add({
            'text': extractMessage(response.data!.message.toString()),
            'isUser': false,
            'time': DateTime.now(),
          });
        } else {
          _showErrorMessage(
            'Sorry, I couldn\'t process your message. Please try again.',
          );
        }
      }
    } catch (e) {
      printLog('Error sending message: $e');
      _showErrorMessage(
        'Sorry, there was an error sending your message. Please check your connection.',
      );
    }
  }

  void _showErrorMessage(String errorMessage) {
    messages.add({
      'text': errorMessage,
      'isUser': false,
      'time': DateTime.now(),
      'isError': true,
    });
  }

  void _handleIncomingMessage(dynamic data, String eventType)async {
    printLog('🔍 Processing incoming message from event: $eventType');
    printLog('🔍 Raw data: $data');
    printLog('🔍 Data type: ${data.runtimeType}');

    if (data != null) {
      String messageText = '';
      String? senderId;
      String? messageId;

      // Process data exactly like React
      if (data is Map<String, dynamic>) {
        // Try different field names like React
        messageText =
            data['text'] ??
            data['message'] ??
            data['answer'] ??
            data['content'] ??
            data['response'] ??
            'No message content';

        senderId = data['sender'] ?? data['senderId'] ?? data['userId'];
        messageId = data['messageId'] ?? data['id'];

        printLog(
          '📋 Extracted - Text: $messageText, Sender: $senderId, ID: $messageId',
        );
      } else if (data is String) {
        messageText = data;
      } else {
        messageText = data.toString();
      }

      // Add message to UI exactly like React
      if (messageText.isNotEmpty && messageText != 'No message content') {


        final translatedMessage = await TranslationService.translateText(
          messageText.toString(),
          countryCode.value,
        );

        messages.add({
          'text': translatedMessage,
          'isUser': false, // This is a received message
          'time': DateTime.now(),
          'messageId': messageId,
          'status': 'received',
          'eventType': eventType,
        });

        printLog('✅ Message successfully added to chat UI: $messageText');
        printLog('📊 Total messages in chat: ${messages.length}');
      } else {
        printLog('⚠️ Empty or invalid message content, not adding to UI');
      }
    } else {
      printLog('⚠️ Received null message data from event: $eventType');
    }
  }

  // Test method for debugging
  void testSocketConnection() {
    printLog('🧪 ===== TESTING SOCKET.IO CONNECTION =====');
    printLog('🔍 Socket connected: ${socket.connected}');
    printLog('🔍 Socket ID: ${socket.id}');

    if (socket.connected) {
      // Send a test message exactly like React
      socket.emit('message', {
        'user': 'Me',
        'text': 'Test message from Flutter Socket.IO',
        'message': 'Test message from Flutter Socket.IO',
        'sender': userId.$,
        'receiver': requestDetail.id.toString(),
      });
      printLog('📤 Test message sent via Socket.IO');
    } else {
      printLog('❌ Socket not connected - cannot test');
    }
  }

  @override
  void onClose() {
    // Close Socket.IO connection
    socket.disconnect();
    socket.dispose();

    messageController.dispose();
    super.onClose();
  }
}
