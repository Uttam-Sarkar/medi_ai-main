import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:medi/app/core/helper/print_log.dart';
import 'package:medi/app/core/helper/shared_value_helper.dart';
import 'package:medi/app/data/remote/model/hospital/hospitals_response.dart';
import 'package:medi/app/data/remote/model/user/user_data_response.dart';
import 'package:medi/app/data/remote/repository/chat/chat_repository.dart';
import 'package:medi/app/data/remote/repository/user/user_repository.dart';

class ChatboxController extends GetxController {
  final TextEditingController messageController = TextEditingController();
  final RxList<Map<String, dynamic>> messages = <Map<String, dynamic>>[].obs;
  final RxBool isTyping = false.obs;
  final threadId = ''.obs;
  final Rx<UserFilteredData?> currentUser = Rx<UserFilteredData?>(null);
  final RxInt messageCount = 0.obs;
  final RxList<PatientNearbyHospital> recommendedHospitals = <PatientNearbyHospital>[].obs;
  final RxBool showHospitals = false.obs;
  Position? currentPosition;

  @override
  void onInit() {
    super.onInit();
    _loadUserData();
    messages.addAll([
      {
        'text': 'chatbox.greeting'.trParams({'userName': userName.$}),
        'isUser': false,
        'time': DateTime.now(),
      },
    ]);
  }

  Future<void> _loadUserData() async {
    try {
      final response = await UserRepository().getUserData();
      if (response.success == true && response.data != null && response.data!.isNotEmpty) {
        currentUser.value = response.data!.first;
      }
    } catch (e) {
      printLog('Error loading user data: $e');
    }
  }

  @override
  void onClose() {
    messageController.dispose();
    super.onClose();
  }

  void sendMessage() async {
    final message = messageController.text.trim();
    if (message.isNotEmpty) {
      messages.add({'text': message, 'isUser': true, 'time': DateTime.now()});
      messageController.clear();

      // Increment message count
      messageCount.value++;

      // Show typing indicator
      isTyping.value = true;

      // Determine if this is the first user message
      final isFirstMessage = messageCount.value == 1;

      var response = await ChatRepository().sendChatMessage(
        message,
        threadId.value,
        userData: currentUser.value,
        isFirstMessage: isFirstMessage,
      );
      threadId.value = response.data!.threadId ?? '';

      // Hide typing indicator
      isTyping.value = false;

      if (response.success!) {
        String extractMessage(String jsonString) {
          try {
            final Map<String, dynamic> data = json.decode(jsonString);
            printLog(data);
            return data['answer'] ?? jsonString;
          } catch (e) {
            return jsonString;
          }
        }

        messages.add({
          'text': extractMessage(response.data!.message.toString()),
          'isUser': false,
          'time': DateTime.now(),
        });
      }
    }
  }
}
