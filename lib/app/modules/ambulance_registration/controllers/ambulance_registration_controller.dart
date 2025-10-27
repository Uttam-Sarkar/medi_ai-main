import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/remote/repository/auth/auth_repository.dart';

class AmbulanceRegistrationController extends GetxController {
  // Registration fields
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var isPasswordVisible = false.obs;
  var countryCode = '+1'.obs;
  final pageController = PageController();
  // Registration logic
  Future<void> registerUser() async {
    var response = await AuthRepository().getRegister(
      phoneController.text,
      emailController.text,
      passwordController.text,
      "ambulance"
    );
    if (response.success == true) {
      // Handle success (e.g., show a message or navigate)
      Get.back();
      Get.snackbar('Success'.tr, 'Registration successful!'.tr);
    } else {
      // Handle error
      Get.snackbar(
        'Error'.tr,
        response.message?.tr ?? 'Registration failed'.tr,
      );
    }
  }
}
