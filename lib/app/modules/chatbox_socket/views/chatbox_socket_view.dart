import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:medi/app/core/custom_widgets/global_appbar.dart';
import 'package:medi/app/core/helper/app_widgets.dart';
import 'package:medi/app/modules/chatbox_socket/controllers/chatbox_socket_controller.dart';
import '../../../core/style/app_colors.dart';

class ChatboxSocketView extends GetView<ChatboxSocketController> {
  const ChatboxSocketView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: _buildAppBarWithStatus(context),
      body: SafeArea(
        child: Column(
          children: [
            // Connection status indicator
            _buildConnectionStatus(),

            // Messages list
            Expanded(
              child: Obx(
                () => ListView.builder(
                  reverse: true,
                  padding: const EdgeInsets.all(16),
                  itemCount: controller.messages.length,
                  itemBuilder: (context, index) {
                    final reversedIndex =
                        controller.messages.length - 1 - index;
                    final message = controller.messages[reversedIndex];
                    final isUser = message['isUser'] as bool;
                    final isError = message['isError'] == true;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (!isUser) ...[
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isError
                                    ? Colors.red.withOpacity(0.1)
                                    : AppColors.primaryAccentColor.withOpacity(
                                        0.1,
                                      ),
                              ),
                              child: Icon(
                                isError
                                    ? Icons.error_outline
                                    : FontAwesomeIcons.robot,
                                color: isError
                                    ? Colors.red
                                    : AppColors.primaryAccentColor,
                                size: 14,
                              ),
                            ),
                            const SizedBox(width: 12),
                          ],
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: isUser
                                    ? AppColors.primaryAccentColor
                                    : isError
                                    ? Colors.red.withOpacity(0.1)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: isError
                                    ? Border.all(
                                        color: Colors.red.withOpacity(0.3),
                                      )
                                    : null,
                              ),
                              child: Text(
                                message['text'] as String,
                                style: TextStyle(
                                  color: isUser
                                      ? Colors.white
                                      : isError
                                      ? Colors.red.shade700
                                      : AppColors.primaryAccentColor,
                                  fontSize: 14,
                                  height: 1.4,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          if (isUser) ...[
                            const SizedBox(width: 12),
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.primaryAccentColor.withOpacity(
                                  0.1,
                                ),
                              ),
                              child: const Icon(
                                Icons.person,
                                color: AppColors.primaryAccentColor,
                                size: 16,
                              ),
                            ),
                          ],
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),

            // Message input area
            _buildMessageInput(),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBarWithStatus(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primaryAccentColor,
      elevation: 0,
      titleSpacing: -10,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () => Get.back(),
      ),
      title: Row(
        children: [
          Expanded(
            child: Text(
              controller.requestDetail.email.toString().split('@')[0],
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Obx(
            () => Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: controller.isSocketConnected.value
                    ? Colors.green.withOpacity(0.2)
                    : Colors.orange.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: controller.isSocketConnected.value
                          ? Colors.green
                          : Colors.orange,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    controller.isSocketConnected.value ? 'Online' : 'Offline',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          AppWidgets().gapW24()
        ],
      ),
    );
  }

  Widget _buildConnectionStatus() {
    return Obx(() {
      if (controller.isSocketConnected.value) {
        return const SizedBox.shrink(); // Hide entire banner when connected
      }

      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        color: Colors.orange.withOpacity(0.1),
        child: Row(
          children: [
            Icon(Icons.wifi_off, color: Colors.orange, size: 16),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Connection lost. Messages will be sent when reconnected.',
                style: TextStyle(
                  color: Colors.orange.shade700,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            // GestureDetector(
            //   onTap: controller.reconnectSocket,
            //   child: Container(
            //     padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            //     decoration: BoxDecoration(
            //       color: Colors.orange,
            //       borderRadius: BorderRadius.circular(4),
            //     ),
            //     child: const Text(
            //       'Retry',
            //       style: TextStyle(
            //         color: Colors.white,
            //         fontSize: 10,
            //         fontWeight: FontWeight.w600,
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      );
    });
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(color: AppColors.primaryColor),
      child: Row(
        children: [
          Expanded(
            child: ClayContainer(
              color: AppColors.primaryColor,
              borderRadius: 8,
              depth: 12,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: TextField(
                  controller: controller.messageController,
                  decoration: InputDecoration(
                    hintText: 'Type your message',
                    hintStyle: const TextStyle(
                      color: AppColors.textColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                  ),
                  style: const TextStyle(
                    color: AppColors.primaryAccentColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: null,
                  onSubmitted: (_) => controller.sendMessage(),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Obx(
            () => GestureDetector(
              onTap: controller.sendMessage,
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: controller.isSocketConnected.value
                      ? AppColors.primaryAccentColor
                      : AppColors.primaryAccentColor.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  controller.isSocketConnected.value
                      ? Icons.send_rounded
                      : Icons.send_outlined,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
