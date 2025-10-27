import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:medi/app/core/helper/app_widgets.dart';
import 'package:medi/app/modules/home/controllers/home_controller.dart';
import '../../../core/style/app_colors.dart';
import '../../../routes/app_pages.dart';
import '../controllers/my_symptoms_controller.dart';

class MySymptomsView extends GetView<MySymptomsController> {
  const MySymptomsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: AppColors.primaryColor,
        leading: InkWell(
          onTap: () => Get.back(),
          child: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.primaryAccentColor,
          ),
        ),
        title: InkWell(
          onTap: () => Get.back(),
          child: Text(
            'My Symptoms'.tr,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryAccentColor,
            ),
          ),
        ),
        centerTitle: false,
        titleSpacing: -10,
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(Routes.TRAVEL_HISTORY);
            },
            icon: const Icon(
              FontAwesomeIcons.planeArrival,
              color: AppColors.primaryAccentColor,
              size: 20,
            ),
            tooltip: 'Travel Details'.tr,
          ),
        ],
      ),

      body: SafeArea(
        child: Column(
          children: [
            // Messages list
            Expanded(
              child: Obx(
                () => ListView.builder(
                  reverse: true,
                  padding: const EdgeInsets.all(16),
                  itemCount:
                      controller.messages.length +
                      (controller.isTyping.value ? 1 : 0),
                  itemBuilder: (context, index) {
                    // Show typing indicator as the first item (newest message)
                    if (index == 0 && controller.isTyping.value) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                                FontAwesomeIcons.robot,
                                color: AppColors.primaryAccentColor,
                                size: 14,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: _buildTypingIndicator(),
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    // Adjust index for actual messages
                    final messageIndex = controller.isTyping.value
                        ? index - 1
                        : index;
                    final reversedIndex =
                        controller.messages.length - 1 - messageIndex;
                    final message = controller.messages[reversedIndex];
                    final isUser = message['isUser'] as bool;

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
                                color: AppColors.primaryAccentColor.withOpacity(
                                  0.1,
                                ),
                              ),
                              child: const Icon(
                                FontAwesomeIcons.robot,
                                color: AppColors.primaryAccentColor,
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
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                message['text'] as String,
                                style: TextStyle(
                                  color: isUser
                                      ? Colors.white
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
            Container(
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
                            hintText: 'Ask me anything about health...'.tr,
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
                          onSubmitted: (_) => controller.sendMessage(context),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: () => controller.sendMessage(context),
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppColors.primaryAccentColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.send_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildAnimatedDot(0),
        const SizedBox(width: 4),
        _buildAnimatedDot(300),
        const SizedBox(width: 4),
        _buildAnimatedDot(600),
      ],
    );
  }

  Widget _buildAnimatedDot(int delay) {
    return TweenAnimationBuilder<double>(
      key: ValueKey('typing_dot_$delay'),
      tween: Tween(begin: 0.3, end: 1.0),
      duration: const Duration(milliseconds: 800),
      builder: (context, value, child) {
        return AnimatedContainer(
          duration: Duration(milliseconds: delay),
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primaryAccentColor.withOpacity(value),
          ),
        );
      },
      onEnd: () {
        // Restart animation if still typing
        Future.delayed(Duration(milliseconds: delay), () {
          // This will cause a rebuild and restart the animation
        });
      },
    );
  }
}
