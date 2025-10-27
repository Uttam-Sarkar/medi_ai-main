import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:medi/app/core/custom_widgets/global_appbar.dart';
import 'package:medi/app/core/style/app_colors.dart';
import 'package:medi/app/data/remote/model/notification/notifications_response.dart';

import '../controllers/notification_controller.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: globalAppBar(context, 'Notifications'.tr),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Obx(() {
            // Get all pending requests from all notifications
            final pendingRequests = _getPendingRequests();
            
            if (pendingRequests.isEmpty) {
              return _buildEmptyState();
            }

            return RefreshIndicator(
              onRefresh: controller.getNotificationList,
              color: AppColors.primaryAccentColor,
              child: ListView.separated(
                itemCount: pendingRequests.length,
                separatorBuilder: (context, index) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final request = pendingRequests[index];
                  return _buildNotificationCard(request, index);
                },
              ),
            );
          }),
        ),
      ),
    );
  }

  List<RequestDetail> _getPendingRequests() {
    List<RequestDetail> pendingRequests = [];
    
    for (var notification in controller.notificationList) {
      if (notification.data != null) {
        for (var datum in notification.data!) {
          if (datum.requestDetails != null) {
            for (var request in datum.requestDetails!) {
              if (request.status?.toLowerCase() == 'pending') {
                pendingRequests.add(request);
              }
            }
          }
        }
      }
    }
    
    return pendingRequests;
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.primaryAccentColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(50),
            ),
            child: const Icon(
              Icons.notifications_none_outlined,
              size: 64,
              color: AppColors.primaryAccentColor,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'No Pending Notifications'.tr,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryAccentColor,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'All caught up! No pending requests at the moment.'.tr,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.textColor,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: controller.getNotificationList,
            icon: const Icon(Icons.refresh, color: Colors.white),
            label: Text('Refresh'.tr, style: const TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryAccentColor,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationCard(RequestDetail request, int index) {
    final hospitalName = request.details?.generalInfo?.name ?? request.role;
    final hospitalEmail = request.email ?? 'No email provided';
    final hospitalPhone = request.details?.generalInfo?.phoneNumber ?? 'No phone provided';
    final hospitalAddress = request.details?.generalInfo?.address ?? 'No address provided';
    final hospitalType = request.details?.generalInfo?.type ?? 'Medical Facility';
    final specialties = request.details?.generalInfo?.speciality ?? [];
    
    return ClayContainer(
      depth: 12,
      spread: 2,
      color: Colors.white,
      borderRadius: 20,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with hospital info and status
            Row(
              children: [
                // Hospital Avatar
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primaryAccentColor.withOpacity(0.8),
                        AppColors.primaryAccentColor,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryAccentColor.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),

                  child: request.role == 'hospital'?  Icon(
                     Icons.local_hospital,
                    color: Colors.white,
                    size: 28,
                  ) : Center(
                    child: FaIcon( FontAwesomeIcons.truckMedical,    color: Colors.white,
                      size: 20,),
                  ),
                ),
                const SizedBox(width: 16),
                
                // Hospital Basic Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        hospitalName.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black87,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        hospitalType,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Status Badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.orange.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Colors.orange,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Pending'.tr,
                        style: const TextStyle(
                          color: Colors.orange,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 20),
            
            // Hospital Details
            _buildDetailRow(Icons.email_outlined, 'Email', hospitalEmail),
            Visibility(
                visible: request.role == 'hospital',
                child: const SizedBox(height: 12)),
            Visibility(
                visible: request.role == 'hospital',
                child: _buildDetailRow(Icons.phone_outlined, 'Phone', hospitalPhone)),
            Visibility(
                visible: request.role == 'hospital',
                child: const SizedBox(height: 12)),
            Visibility(
                visible: request.role == 'hospital',
                child: _buildDetailRow(Icons.location_on_outlined, 'Address', hospitalAddress)),
            
            // Specialties if available
            if (specialties.isNotEmpty) ...[
              const SizedBox(height: 16),
              Text(
                'Specialties'.tr,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: AppColors.primaryAccentColor,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: specialties.take(3).map((specialty) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.primaryAccentColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      specialty,
                      style: const TextStyle(
                        color: AppColors.primaryAccentColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
            
            const SizedBox(height: 24),
            
            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _handleDecline(request),
                    icon: const Icon(Icons.close, size: 18),
                    label: Text('Decline'.tr),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade50,
                      foregroundColor: Colors.red.shade700,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: Colors.red.shade200),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _handleAccept(request),
                    icon: const Icon(Icons.check, size: 18),
                    label: Text('Accept'.tr),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.buttonColor,
                      foregroundColor: Colors.white,
                      elevation: 2,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            size: 16,
            color: AppColors.primaryAccentColor,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label.tr,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _handleAccept(RequestDetail request) {
    // Show confirmation dialog
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.buttonColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.check_circle_outline,
                color: AppColors.buttonColor,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            Text('Accept Request'.tr),
          ],
        ),
        content: Text(
          'Are you sure you want to accept this hospital registration request?'.tr,
          style: const TextStyle(fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel'.tr),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              controller.acceptRequest(request);

            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.buttonColor,
              foregroundColor: Colors.white,
            ),
            child: Text('Accept'.tr),
          ),
        ],
      ),
    );
  }

  void _handleDecline(RequestDetail request) {
    // Show confirmation dialog
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.cancel_outlined,
                color: Colors.red,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            Text('Decline Request'.tr),
          ],
        ),
        content: Text(
          'Are you sure you want to decline this hospital registration request?'.tr,
          style: const TextStyle(fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel'.tr),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              controller.declineRequest(request);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: Text('Decline'.tr),
          ),
        ],
      ),
    );
  }
}
