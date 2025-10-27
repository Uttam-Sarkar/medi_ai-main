import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmergencyContactEntry {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final RxString relationship = ''.obs;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mediAiIdController = TextEditingController();
}
