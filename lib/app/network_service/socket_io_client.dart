import 'package:medi/app/core/helper/print_log.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../core/config/app_config.dart';

class SocketIOClient {
  static SocketIOClient? _instance;
  IO.Socket? _socket;

  SocketIOClient._();

  static SocketIOClient get instance {
    _instance ??= SocketIOClient._();
    return _instance!;
  }

  IO.Socket? get socket => _socket;

  void connect() {
    try {
      printLog('🔌 Attempting to connect to: ${AppConfig.socketUrl}');

      _socket = IO.io(
        AppConfig.socketUrl,
        IO.OptionBuilder()
            // .setTransports(['websocket', 'polling'])
            .setTransports(['websocket'])
            .enableAutoConnect()
            .enableReconnection()
            .setReconnectionAttempts(5)
            .setReconnectionDelay(1000)
            .setTimeout(5000)
            .build(),
      );

      // Log all outgoing events

      // Connection event handlers
      _socket!.onConnect((_) {
        printLog('✅ Connected to Socket.IO server successfully!');
        printLog('🌐 Server URL: ${_socket?.io.uri}');
        printLog('🆔 Socket ID: ${_socket?.id}');

        // Send a test ping to verify connection
        _socket!.emit('ping', {
          'timestamp': DateTime.now().millisecondsSinceEpoch,
        });
      });

      _socket!.onAny((event, data) {
        printLog('📤 Outgoing event: $event -> $data');
      });

      // Log all incoming events properly - use our custom method
      onAnyIncoming((event, data) {
        printLog('📥 Incoming event: $event -> $data');
      });

      _socket!.onDisconnect((reason) {
        printLog('❌ Disconnected from Socket.IO server. Reason: $reason');
      });

      _socket!.onConnectError((error) {
        printLog('🚫 Connection error: $error');
        // Try to reconnect with different transport
        if (error.toString().contains('Invalid namespace')) {
          printLog('🔧 Namespace error detected, attempting to reconnect...');
          Future.delayed(Duration(seconds: 2), () {
            disconnect();
            connectWithFallback();
          });
        }
      });

      _socket!.onError((error) {
        printLog('⚠️ Socket error: $error');
      });

      _socket!.onReconnect((attemptNumber) {
        printLog('🔄 Reconnected to server (attempt: $attemptNumber)');
      });

      _socket!.onReconnectError((error) {
        printLog('❌ Reconnection failed: $error');
      });

      _socket!.onReconnectAttempt((attemptNumber) {
        printLog('🔄 Attempting to reconnect... (attempt: $attemptNumber)');
      });
    } catch (e) {
      printLog('💥 Failed to connect to socket: $e');
    }
  }

  void connectWithFallback() {
    try {
      printLog('🔄 Attempting fallback connection with polling transport...');

      _socket = IO.io(
        '${AppConfig.socketUrl}/',
        IO.OptionBuilder()
            .setTransports(['polling', 'websocket'])
            .enableAutoConnect()
            .enableReconnection()
            .setReconnectionAttempts(3)
            .setReconnectionDelay(2000)
            .setTimeout(10000)
            .setPath('/socket.io/')
            .build(),
      );

      // Re-attach event handlers
      _attachEventHandlers();
    } catch (e) {
      printLog('💥 Fallback connection also failed: $e');
    }
  }

  void _attachEventHandlers() {
    // Log all outgoing events
    _socket!.onAny((event, data) {
      printLog('📤 Outgoing event: $event -> $data');
    });

    // Log all incoming events properly - use our custom method
    onAnyIncoming((event, data) {
      printLog('📥 Incoming event: $event -> $data');
    });

    // Connection event handlers
    _socket!.onConnect((_) {
      printLog('✅ Fallback connection successful!');
      printLog('🌐 Server URL: ${_socket?.io.uri}');
      printLog('🆔 Socket ID: ${_socket?.id}');
    });

    _socket!.onDisconnect((reason) {
      printLog('❌ Disconnected from Socket.IO server. Reason: $reason');
    });

    _socket!.onConnectError((error) {
      printLog('🚫 Connection error: $error');
    });

    _socket!.onError((error) {
      printLog('⚠️ Socket error: $error');
    });
  }

  void disconnect() {
    _socket?.disconnect();
    _socket?.dispose();
    _socket = null;
    printLog('🔌 Socket disconnected and disposed');
  }

  void emit(String event, [dynamic data]) {
    if (_socket != null && _socket!.connected) {
      _socket!.emit(event, data);
      printLog('📤 Emitted event: $event  $data');
    } else {
      printLog('⚠️ Socket not connected. Cannot emit event: $event');
    }
  }

  void on(String event, Function(dynamic) callback) {
    _socket?.on(event, callback);
  }

  void off(String event) {
    _socket?.off(event);
  }

  void onAny(Function(String, dynamic) callback) {
    _socket?.onAny(callback);
  }

  void onAnyIncoming(Function(String, dynamic) callback) {
    // Store the callback for use in onAny
    _incomingCallback = callback;

    // Simple approach like React - capture ALL events without filtering
    if (_socket != null) {
      _socket!.onAny((event, data) {
        printLog('📥 INCOMING EVENT DETECTED: $event -> $data');
        callback(event, data);
      });
    }
  }

  // Store the incoming callback
  Function(String, dynamic)? _incomingCallback;

  // Universal event listener that captures ALL events
  void onUniversalEvent(Function(String, dynamic) callback) {
    if (_socket != null) {
      _socket!.onAny((event, data) {
        printLog('🌐 UNIVERSAL EVENT: $event -> $data');
        callback(event, data);
      });
    }
  }

  bool get isConnected => _socket?.connected ?? false;

  String get connectionStatus {
    if (_socket == null) return 'Not initialized';
    if (_socket!.connected) return 'Connected';
    if (_socket!.disconnected) return 'Disconnected';
    return 'Connecting...';
  }

  String? get socketId => _socket?.id;

  String? get serverUrl => _socket?.io.uri.toString();

  // Method to get detailed connection info
  Map<String, dynamic> getConnectionInfo() {
    return {
      'isConnected': isConnected,
      'status': connectionStatus,
      'socketId': socketId,
      'serverUrl': serverUrl,
      'hasSocket': _socket != null,
    };
  }
}
