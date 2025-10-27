import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medi/app/core/helper/app_widgets.dart';
import 'package:medi/app/core/helper/print_log.dart';
import 'package:medi/app/core/style/app_colors.dart';
import 'package:medi/app/data/remote/repository/notification/notification_repository.dart';

import '../../../data/remote/model/notification/notifications_response.dart';

class NotificationController extends GetxController {
  final notificationList = <NotificationsResponse>[].obs;

  @override
  void onInit() {
    super.onInit();
    getNotificationList();
  }

  Future<void> getNotificationList() async {
    var response = await NotificationRepository().getUserData();
    if (response.success == true) {
      notificationList.clear();
      notificationList.add(response);
      printLog(notificationList.length);
      update();
    }
  }

  void acceptRequest(RequestDetail request) async {
    try {
      String invitationId = request.id.toString(); // This should be dynamic

      var response = await NotificationRepository().acceptRequest(
        invitationId: invitationId,
      );

      printLog('Accept request response: $response');

      if (response.status == 200 ||
          response.message?.toLowerCase().contains('success') == true) {
        // Show success message
        AppWidgets().getSnackBar(
          title: 'Success'.tr,
          message: response.message,
        );

        // Refresh the notification list to update the UI
        await getNotificationList();
      } else {
        // Show error message
        Get.snackbar(
          'Error'.tr,
          response.message ?? 'Failed to accept request'.tr,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      printLog('Error accepting request: $e');
      Get.snackbar(
        'Error'.tr,
        'An error occurred while accepting the request'.tr,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  void declineRequest(RequestDetail request) async {
    try {
      String invitationId = request.id.toString(); // This should be dynamic

      var response = await NotificationRepository().declineRequest(
        invitationId: invitationId,
      );

      printLog('Decline request response: $response');

      if (response.status == 200 ||
          response.message?.toLowerCase().contains('success') == true) {
        // Show success message
        AppWidgets().getSnackBar(
          title: 'Declined'.tr,
          message: response.message,
        );

        // Refresh the notification list to update the UI
        await getNotificationList();
      } else {
        // Show error message
        Get.snackbar(
          'Error'.tr,
          response.message ?? 'Failed to decline request'.tr,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      printLog('Error declining request: $e');
      Get.snackbar(
        'Error'.tr,
        'An error occurred while declining the request'.tr,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    }
  }
}
