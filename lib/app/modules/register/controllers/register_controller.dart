import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../generated/assets.dart';
import '../../../core/helper/print_log.dart';

enum UserType { patient, hospital, ambulance }

class RegisterController extends GetxController {
  final pageController = PageController();
  int currentPage = 0;

  bool showAgreement = false;
  bool showUserTypeSelection = false;
  bool agreeTerms = false;
  bool agreePrivacy = false;

  UserType? selectedUserType;

  final titles = [
    'register.title1'.tr,
    'register.title2'.tr,
    'register.title3'.tr,
  ];

  final subtitles = [
    'register.subtitle1'.tr,
    'register.subtitle2'.tr,
    'register.subtitle3'.tr,
  ];

  final images = [Assets.register1, Assets.register2, Assets.register3];

  void onPageChanged(int index) {
    currentPage = index;
    update();
  }

  void showAgreementSection() {
    showAgreement = true;
    update();
  }

  void setAgreeTerms(bool value) {
    agreeTerms = value;
    update();
  }

  void setAgreePrivacy(bool value) {
    agreePrivacy = value;
    update();
  }

  void showUserTypeSelectionSection() {
    showUserTypeSelection = true;
    update();
  }

  void selectUserType(UserType type) {
    selectedUserType = type;
    update();
    // Handle further navigation or logic here if needed
    printLog('Selected user type: $type');
  }
}
