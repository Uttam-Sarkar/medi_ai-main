import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medi/app/core/helper/print_log.dart';
import 'package:medi/app/core/helper/shared_value_helper.dart';
import 'package:medi/app/data/remote/repository/chat/chat_repository.dart';

class ChatboxController extends GetxController {
  final TextEditingController messageController = TextEditingController();
  final RxList<Map<String, dynamic>> messages = <Map<String, dynamic>>[].obs;
  final RxBool isTyping = false.obs;
  final threadId = ''.obs;

  @override
  void onInit() {
    super.onInit();
    messages.addAll([
      {
        'text': 'chatbox.greeting'.trParams({'userName': userName.$}),
        'isUser': false,
        'time': DateTime.now(),
      },
    ]);
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

      // Show typing indicator
      isTyping.value = true;

      var response = await ChatRepository().sendChatMessage(
        message,
        threadId.value,
      );
      threadId.value = response.data!.threadId ?? '';

      // Hide typing indicator
      isTyping.value = false;

      if (response.success!) {
        String extractMessage(String jsonString) {
          final Map<String, dynamic> data = json.decode(jsonString);
          printLog(data);
          return data['answer'] ?? '';
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
