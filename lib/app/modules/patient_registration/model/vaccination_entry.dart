import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VaccinationEntry {
  RxString vaccineType = ''.obs;
  TextEditingController vaccineNameController = TextEditingController();
  Rx<DateTime?> date = Rx<DateTime?>(null);
}
