import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TravelHistoryController extends GetxController {
  // Form controllers
  final daysAgoController = TextEditingController();
  final stayDurationController = TextEditingController();
  final countriesVisitedController = TextEditingController();
  final symptomsStartController = TextEditingController();

  // Observable variables
  final medicationTaken = RxString('');
  final hasMedicalInsurance = RxString('');

  // Medication options
  final medicationOptions = ['Yes', 'No'].obs;
  final insuranceOptions = ['Yes', 'No'].obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    // Dispose controllers
    daysAgoController.dispose();
    stayDurationController.dispose();
    countriesVisitedController.dispose();
    symptomsStartController.dispose();
    super.onClose();
  }

  void setMedicationTaken(String value) {
    medicationTaken.value = value;
  }

  void setMedicalInsurance(String value) {
    hasMedicalInsurance.value = value;
  }

  void submitTravelHistory() {
    // Validate form
    if (medicationTaken.isEmpty) {
      Get.snackbar(
        'Error',
        'Please select if you have taken any medication today',
      );
      return;
    }

    if (daysAgoController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter how many days ago you arrived');
      return;
    }

    if (stayDurationController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter how long you are staying');
      return;
    }

    if (countriesVisitedController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter the countries you visited');
      return;
    }

    if (symptomsStartController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter when your symptoms started');
      return;
    }

    if (hasMedicalInsurance.isEmpty) {
      Get.snackbar('Error', 'Please select if you have medical insurance');
      return;
    }

    // Process form data
    Map<String, dynamic> travelData = {
      'medicationTaken': medicationTaken.value,
      'daysArrived': daysAgoController.text,
      'stayDuration': stayDurationController.text,
      'countriesVisited': countriesVisitedController.text,
      'symptomsStart': symptomsStartController.text,
      'medicalInsurance': hasMedicalInsurance.value,
    };

    // TODO: Send data to API
    print('Travel History Data: $travelData');

    Get.snackbar(
      'Success',
      'Travel history submitted successfully',
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }
}
