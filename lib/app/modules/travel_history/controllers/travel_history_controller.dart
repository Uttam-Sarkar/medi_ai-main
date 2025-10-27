import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medi/app/core/helper/app_helper.dart';
import 'package:medi/app/core/helper/app_widgets.dart';
import '../../../core/helper/shared_value_helper.dart';

class TravelHistoryController extends GetxController {
  // Form controllers
  final daysAgoController = TextEditingController();
  final stayDurationController = TextEditingController();
  final countriesVisitedController = TextEditingController();
  final symptomsStartController = TextEditingController();
  final travelStartDateController = TextEditingController();

  // Observable variables
  final medicationTaken = RxString('');
  final hasMedicalInsurance = RxString('');
  final paymentMethod = RxString('');
  final travelReason = RxString('');
  final isPregnant = RxString('');
  final isNursing = RxString('');

  // Options for dropdowns
  final medicationOptions = ['Yes', 'No'].obs;
  final insuranceOptions = ['Yes', 'No'].obs;
  final paymentOptions = ['CREDIT', 'CASH'].obs;
  final travelReasonOptions = ['Holiday', 'Work'].obs;
  final yesNoOptions = ['Yes', 'No'].obs;

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
    travelStartDateController.dispose();
    super.onClose();
  }

  void setMedicationTaken(String value) {
    medicationTaken.value = value;
  }

  void setMedicalInsurance(String value) {
    hasMedicalInsurance.value = value;
  }

  void setPaymentMethod(String value) {
    paymentMethod.value = value;
  }

  void setTravelReason(String value) {
    travelReason.value = value;
  }

  void setPregnant(String value) {
    isPregnant.value = value;
  }

  void setNursing(String value) {
    isNursing.value = value;
  }

  void submitTravelHistory() {
    // Validate form
    if (medicationTaken.isEmpty) {
      Get.snackbar(
          'Error', 'Please select if you have taken any medication today');
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

    if (paymentMethod.isEmpty) {
      Get.snackbar('Error', 'Please select your payment method');
      return;
    }

    if (travelReason.isEmpty) {
      Get.snackbar('Error', 'Please select your travel reason');
      return;
    }

    if (travelStartDateController.text.isEmpty) {
      Get.snackbar('Error', 'Please select your travel start date');
      return;
    }

    // Validate pregnancy and nursing fields if gender is female
    if (gender.$ == 'female') {
      if (isPregnant.isEmpty) {
        Get.snackbar('Error', 'Please select if you are pregnant');
        return;
      }
      if (isNursing.isEmpty) {
        Get.snackbar('Error', 'Please select if you are nursing');
        return;
      }
    }

    // Process form data
    Map<String, dynamic> travelData = {
      'medicationTaken': medicationTaken.value,
      'daysArrived': daysAgoController.text,
      'stayDuration': stayDurationController.text,
      'countriesVisited': countriesVisitedController.text,
      'symptomsStart': symptomsStartController.text,
      'medicalInsurance': hasMedicalInsurance.value,
      'paymentMethod': paymentMethod.value,
      'travelReason': travelReason.value,
      'travelStartDate': travelStartDateController.text,
    };

    // Add pregnancy and nursing data if gender is female
    if (gender.$ == 'female') {
      travelData['isPregnant'] = isPregnant.value;
      travelData['isNursing'] = isNursing.value;
    }
    AppHelper().showLoader();


    Future.delayed(const Duration(seconds: 2), () {
      AppHelper().hideLoader();
      Get.back();
      AppWidgets().getSnackBar(
        message:
        'Travel history submitted successfully',
      );
    });
  }
}
