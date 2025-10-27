import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StaffEntry {
  final RxString category = ''.obs;
  final TextEditingController nameController = TextEditingController();
  final RxString selectedDepartment = ''.obs;
  final RxMap<String, bool> subSpecialtyStates = <String, bool>{}.obs;

  StaffEntry();
}
