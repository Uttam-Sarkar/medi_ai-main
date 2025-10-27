import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:medi/app/core/helper/app_widgets.dart';
import 'package:medi/app/core/service/location_service.dart';
import 'package:medi/app/data/remote/repository/user/user_repository.dart';
import '../../../data/remote/model/hospital/hospitals_response.dart';
import '../../home/controllers/home_controller.dart';

class HospitalController extends GetxController {
  final count = 0.obs;
  final searchController = TextEditingController();
  final selectedSpecialties = <String>[].obs;
  final specialties = <String>[
    'Pediatric Dentistry'.tr,
    'Dermatology'.tr,
    'Cardiology'.tr,
    'Neurology'.tr,
    'Orthopedics'.tr,
    'Gynecology'.tr,
    'Ophthalmology'.tr,
    'Oncology'.tr,
    'Urology'.tr,
    'Psychiatry'.tr,
    'Radiology'.tr,
    'General Surgery'.tr,
  ];

  final isLoading = false.obs;
  final noResultsFound = false.obs;

  // Add hospital data from home controller
  final patientNearbyHospital = <PatientNearbyHospital>[].obs;
  final filteredHospitals = <PatientNearbyHospital>[].obs;
  final lat = ''.obs;
  final lon = ''.obs;

  @override
  void onInit() async {
    super.onInit();
    var location = await getLocation();
    lat.value = location['lat'] ?? '';
    lon.value = location['lon'] ?? '';
    getHospitalData();

    // Add listener to search controller
    searchController.addListener(() {
      searchHospitals();
    });
  }

  Future<void> getHospitalData() async {
    isLoading.value = true;
    await Get.find<HomeController>().getHospitalData( []).then(
      (value) {
        patientNearbyHospital.clear();
        patientNearbyHospital.addAll(Get.find<HomeController>().patientNearbyHospital);

        // Initialize filtered list with all hospitals
        filteredHospitals.clear();
        filteredHospitals.addAll(patientNearbyHospital);

        isLoading.value = false;
        noResultsFound.value = patientNearbyHospital.isEmpty;      },
    ).catchError((error) {
      AppWidgets().getSnackBar(
        title: 'Error',
        message: 'Failed to fetch hospital data: $error',
      );
    }
    );

  }

  void searchHospitals() {
    final query = searchController.text.toLowerCase().trim();

    if (query.isEmpty) {
      // If search is empty, show all hospitals
      filteredHospitals.clear();
      filteredHospitals.addAll(patientNearbyHospital);
    } else {
      // Filter hospitals by name
      final filtered = patientNearbyHospital.where((hospital) {
        final hospitalName =
            hospital.details?.generalInfo?.name?.toLowerCase() ?? '';
        return hospitalName.contains(query);
      }).toList();

      filteredHospitals.clear();
      filteredHospitals.addAll(filtered);
    }

    noResultsFound.value = filteredHospitals.isEmpty;
  }

  Future<void> refreshHospitals() async {
    await getHospitalData();
  }

  void increment() => count.value++;

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
