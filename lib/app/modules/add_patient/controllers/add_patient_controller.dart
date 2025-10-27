import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medi/app/data/remote/repository/ambulance/ambulance_repository.dart';

import '../../../core/helper/app_widgets.dart';
import '../../../data/remote/model/ambulance/patient_list_response.dart';

class AddPatientController extends GetxController {
  final TextEditingController idController = TextEditingController();
  final patientList = <PatientListData>[].obs;
  @override
  void onInit() {
    super.onInit();
    getPatientList();
  }

  Future<void> getPatientList() async {

    var response = await AmbulanceRepository().getPatientList();
    if (response.success == true && response.data != null) {
      patientList.addAll(response.data!);
    }
  }




  Future<void> addPatient(String id) async {
    if (id.isEmpty) {
      AppWidgets().getSnackBar(message: 'Please enter a valid ID'.tr);
      return;
    }
    if (id.length < 6) {
      AppWidgets().getSnackBar(
        message: 'ID must be at least 6 characters long'.tr,
      );
      return;
    }
    var response = await AmbulanceRepository().addPatient(id);
    if (response.success == true) {
      AppWidgets().getSnackBar(message: response.message?.tr ?? 'Success'.tr);
      idController.clear();
      patientList.clear();
      getPatientList();
    } else {
      AppWidgets().getSnackBar(message: response.message?.tr ?? 'Error'.tr);
    }
  }
}
