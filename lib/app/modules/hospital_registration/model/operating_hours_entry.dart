import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OperatingHoursEntry {
  final String day;
  final RxBool isOpen = true.obs;
  final Rx<TimeOfDay?> openTime = Rx<TimeOfDay?>(
    const TimeOfDay(hour: 9, minute: 0),
  );
  final Rx<TimeOfDay?> closeTime = Rx<TimeOfDay?>(
    const TimeOfDay(hour: 17, minute: 0),
  );

  OperatingHoursEntry(this.day);
}
