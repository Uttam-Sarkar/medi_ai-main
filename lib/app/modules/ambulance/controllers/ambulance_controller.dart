import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medi/app/core/helper/app_widgets.dart';
import 'package:medi/app/core/helper/print_log.dart';
import 'package:medi/app/data/remote/repository/user/user_repository.dart';

import '../../../data/remote/model/user/ambulance_data_response.dart';

class AmbulanceController extends GetxController {
  final searchController = TextEditingController();
  final selectedTypes = <String>[].obs;
  final isLoading = false.obs;
  final noResultsFound = false.obs;
  final ambulanceData = <AmbulanceData>[].obs;
  final filteredAmbulanceData = <AmbulanceData>[].obs;

  @override
  void onInit() {
    super.onInit();
    getAmbulanceData();
    searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    filterAmbulanceData(searchController.text);
  } 

  void filterAmbulanceData(String query) {
    if (query.isEmpty) {
      filteredAmbulanceData.assignAll(ambulanceData);
      noResultsFound.value = false;
      return;
    }
    final lowerQuery = query.toLowerCase();
    final filtered = ambulanceData.where((item) {
      return item.email!.toLowerCase().contains(lowerQuery) ||
          item.phoneNumber!.toLowerCase().contains(lowerQuery);
    }).toList();
    filteredAmbulanceData.assignAll(filtered);
    noResultsFound.value = filtered.isEmpty;
  }

  final ambulanceTypes = [
    'Basic Life Support'.tr,
    'Advanced Life Support'.tr,
    'Patient Transport'.tr,
    'Neonatal Ambulance'.tr,
  ];

  void searchAmbulances() {
    isLoading.value = true;
    noResultsFound.value = false;
    Future.delayed(const Duration(seconds: 1), () {
      isLoading.value = false;
      if (searchController.text.trim().toLowerCase() == 'none') {
        noResultsFound.value = true;
      } else {
        noResultsFound.value = false;
      }
    });
  }

  Future<void> getAmbulanceData() async {
    var response = await UserRepository().getAmbulanceData();
    if (response.success == true) {
      ambulanceData.clear();
      ambulanceData.addAll(response.data ?? []);
      filteredAmbulanceData.assignAll(ambulanceData);
      printLog(ambulanceData.length);
    } else {
      AppWidgets().getSnackBar(message: response.message?.tr ?? 'Error'.tr);
    }
  }

  @override
  void onClose() {
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    super.onClose();
  }
}
