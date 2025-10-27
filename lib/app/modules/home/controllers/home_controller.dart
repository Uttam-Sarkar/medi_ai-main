import 'dart:ui';

import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:medi/app/core/helper/app_widgets.dart';
import 'package:medi/app/core/helper/print_log.dart';
import 'package:medi/app/core/helper/shared_value_helper.dart';
import 'package:medi/app/data/remote/repository/user/user_repository.dart';
import 'package:medi/app/network_service/socket_io_client.dart';
import '../../../core/base/base_controller.dart';
import '../../../core/service/location_service.dart';
import '../../../core/style/app_colors.dart';
import '../../../data/remote/model/hospital/hospitals_response.dart';
import '../../../data/remote/model/user/user_data_response.dart';
import '../../../routes/app_pages.dart';
import '../model/home_items.dart';

class HomeController extends BaseController {
  double? radius;
  Offset? center;

  final userData = <UserFilteredData>[].obs;
  final patientNearbyHospital = <PatientNearbyHospital>[].obs;

  final lat = ''.obs;
  final lon = ''.obs;

  @override
  void onInit() async {
    super.onInit();
    await getUserLocation(); // Wait for location before getting hospital data
    getUserData();
    getHospitalData('');
  }


  Future<void> getUserLocation() async {
    var location = await getLocation();
    lat.value = location['lat'] ?? '';
    lon.value = location['lon'] ?? '';
    printLog('🏠 HomeController - Location set: lat=${lat.value}, lon=${lon.value}');
  }

  void calculateCircle(Size size) {
    if (radius == null || center == null) {
      radius = size.width * 0.35;
      center = Offset(size.width / 2, size.height / 2);
    }
  }

  Future<void> getUserData() async {
    var response = await UserRepository().getUserData();
    if (response.success == true) {
      userData.addAll(response.data ?? []);
    } else {
      AppWidgets().getSnackBar(
        title: 'Error',
        message:
            response.message ??
            'So'
                'mething went '
                'wrong',
      );
    }
  }

  Future<void> getHospitalData(speciality) async {
    printLog('Latitude: ${lat.value}, Longitude: ${lon.value}');
      var response = await UserRepository().getHospitalData(
        lat.value,
        lon.value,
        speciality
      );

      patientNearbyHospital.clear();
      patientNearbyHospital.addAll(response.data ?? []);

  }

  void showTranslatorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 24,
          ),
          child: ClayContainer(
            color: Colors.white,
            borderRadius: 20,
            depth: 3,
            spread: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Medical folder icon
                  SizedBox(
                    width: 70,
                    height: 70,
                    child: Image.asset(
                      'assets/image/hospital.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Title
                  Text(
                    'Allow Access',
                    style: TextStyle(
                      color: AppColors.primaryAccentColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(height: 8), const SizedBox(height: 12),
                  // Question
                  Text(
                    'Do you want to allow document translation?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.primaryAccentColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 28),
                  // Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextButton(
                            onPressed: () {
                              translateDocs.$ = false;
                              translateDocs.save();
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Deny',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.primaryAccentColor.withOpacity(
                              0.6,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextButton(
                            onPressed: () {
                              translateDocs.$ = true;
                              translateDocs.save();
                              Navigator.of(context).pop();
                              // Add allow logic here if needed
                            },
                            child: Text(
                              'Allow',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static const List<HomeItem> items = [
    HomeItem('Global', FontAwesomeIcons.globe, Routes.LOGIN),
    HomeItem(
      'Register',
      FontAwesomeIcons.userPlus,
      Routes.PATIENT_REGISTRATION,
    ),
    HomeItem('Login', FontAwesomeIcons.rightToBracket, Routes.LOGIN),
    HomeItem('Hospital', FontAwesomeIcons.hospital, Routes.HOSPITAL),
    HomeItem('Doctor', FontAwesomeIcons.userDoctor, Routes.DOCTOR),
    HomeItem('Ambulance', FontAwesomeIcons.truckMedical, Routes.AMBULANCE),
    HomeItem('Patient', FontAwesomeIcons.addressCard, Routes.LOGIN),
  ];
}
