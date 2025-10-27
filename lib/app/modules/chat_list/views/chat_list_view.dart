import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:medi/app/core/custom_widgets/global_appbar.dart';
import 'package:medi/app/core/helper/app_widgets.dart';
import 'package:medi/app/core/helper/shared_value_helper.dart';
import 'package:medi/app/routes/app_pages.dart';

import '../controllers/chat_list_controller.dart';
import '../../../core/style/app_colors.dart';
import '../../../data/remote/model/user/user_data_response.dart';

class ChatListView extends GetView<ChatListController> {
  const ChatListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: globalAppBar(context, 'Chats'),
      backgroundColor: AppColors.primaryColor,
      body: Obx(() {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 16.0, vertical: 8.0),
            child: RefreshIndicator(
                onRefresh: () async {
                  controller.getChatList();
                },
                color: AppColors.buttonColor,
                child: ListView(
                  children: [
                    ClayContainer(
                      depth: 4,
                      spread: 1,
                      color: Colors.white,
                      borderRadius: 16,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            Get.toNamed(Routes.CHATBOX);
                          },
                          borderRadius: BorderRadius.circular(16),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Avatar - similar to the image
                                Container(
                                  width: 45,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryAccentColor
                                        .withOpacity(0.15),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.smart_toy,
                                    color: AppColors.primaryAccentColor,
                                    size: 22,
                                  ),
                                ),

                                AppWidgets().gapW8(),
                                // Chat content - compact like the image
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      // Title - like "মইব এআই রবট" in the image
                                      Text(
                                        'Medi AI Bot',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.black,
                                          height: 1.2,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 4),

                                      // Preview message - like "হযল আম কভব সহযয করত পর" in the image
                                      Text(
                                        'Start a new conversation',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: AppColors.textColor,
                                          height: 1.3,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),

                                // Time and language info
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 6,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.buttonColor
                                            .withOpacity(
                                          0.1,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        selectedLanguage.$ ?? 'EN',
                                        style: const TextStyle(
                                          fontSize: 9,
                                          color: AppColors.buttonColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Add check for empty list
                    if (controller.chatList.isNotEmpty)
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.chatList.length,
                        separatorBuilder: (context, index) =>
                        const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final chat = controller.chatList[index];
                          return _buildChatItem(chat, context);
                        },
                      ),
                  ],
                ),
              )

          ),
        );
      }),
    );
  }

  Widget _buildChatItem(RequestDetail chat, BuildContext context) {
    // Add null safety check for chat object
    if (chat == null) {
      return const SizedBox.shrink();
    }

    return ClayContainer(
      depth: 4,
      spread: 1,
      color: Colors.white,
      borderRadius: 16,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Get.toNamed(Routes.CHATBOX_SOCKET, arguments: chat);
          },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Avatar - role-based icon
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    color: AppColors.primaryAccentColor.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _getRoleIcon(chat.role),
                    color: AppColors.primaryAccentColor,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),

                // Chat content - compact like the image
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title - show organization name or email username
                      Text(
                        chat.details?.generalInfo?.name ??
                            chat.email?.split('@')[0] ??
                            'Unknown Organization',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.black,
                          height: 1.2,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),

                      // Preview message - show role and location
                      Text(
                        _getPreviewMessage(chat),
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.textColor,
                          height: 1.3,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),

                // Status indicator - show actual status or language
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(chat.status).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    chat.status?.toUpperCase() ?? selectedLanguage.$ ?? 'EN',
                    style: TextStyle(
                      fontSize: 9,
                      color: _getStatusColor(chat.status),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  IconData _getRoleIcon(String? role) {
    switch (role?.toLowerCase()) {
      case 'hospital':
        return Icons.local_hospital_rounded;
      case 'doctor':
        return Icons.medical_services;
      case 'ambulance':
        return Icons.emergency;
      case 'pharmacy':
        return Icons.medication;
      default:
        return Icons.person_3;
    }
  }

  Color _getStatusColor(String? status) {
    if (status == null) return AppColors.buttonColor;

    switch (status.toLowerCase()) {
      case 'approved':
      case 'active':
      case 'completed':
        return Colors.green;
      case 'pending':
      case 'waiting':
        return AppColors.buttonColor;
      case 'rejected':
      case 'cancelled':
        return Colors.red;
      default:
        return AppColors.buttonColor;
    }
  }

  String _getPreviewMessage(RequestDetail chat) {
    // Add comprehensive null safety checks
    if (chat == null) {
      return 'Start a new conversation';
    }

    // Build a rich preview message
    List<String> parts = [];

    if (chat.role != null && chat.role!.isNotEmpty) {
      parts.add(chat.role!.toUpperCase());
    }

    if (chat.details?.generalInfo?.location != null &&
        chat.details!.generalInfo!.location!.isNotEmpty) {
      parts.add(chat.details!.generalInfo!.location!);
    } else if (chat.details?.generalInfo?.city != null &&
        chat.details!.generalInfo!.city!.isNotEmpty) {
      parts.add(chat.details!.generalInfo!.city!);
    }

    if (parts.isEmpty) {
      if (chat.email != null && chat.email!.isNotEmpty) {
        return chat.email!;
      } else {
        return 'Start a new conversation';
      }
    }

    return parts.join(' • ');
  }
}
