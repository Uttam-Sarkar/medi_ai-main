import 'package:get/get.dart';
import 'package:medi/app/core/helper/print_log.dart';
import 'package:medi/app/data/remote/model/doctor/doctor_list_response.dart';
import 'package:medi/app/data/remote/repository/doctor/doctor_repository.dart';

class DoctorController extends GetxController {
  // Observable list to store doctors
  final doctorList = <Datum>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getDoctorsList();
  }

  Future<void> getDoctorsList() async {
    try {
      isLoading.value = true;
      doctorList.clear();

      var response = await DoctorRepository().getDoctorList();

      if (response.success == true && response.data != null) {
        doctorList.addAll(response.data!);
        printLog('=== DOCTORS LIST LOADED ===');
        printLog('Total Doctors: ${doctorList.length}');

        for (int i = 0; i < doctorList.length; i++) {
          final doctor = doctorList[i];
          printLog('=== Doctor ${i + 1} ===');
          printLog('Name: ${doctor.details?.fullName ?? 'Unknown'}');
          printLog('Email: ${doctor.email ?? 'No email'}');
          printLog(
            'Specialization: ${doctor.details?.specialization ?? 'Not specified'}',
          );
          printLog(
            'Hospital: ${doctor.details?.hospitalName ?? 'Not specified'}',
          );
          printLog('Phone: ${doctor.phoneNumber ?? 'No phone'}');
        }
      } else {
        printLog('Failed to load doctors: ${response.message}');
      }
    } catch (e) {
      printLog('Error loading doctors: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Refresh doctors list
  Future<void> refreshDoctors() async {
    await getDoctorsList();
  }

  // Get doctor's display name
  String getDoctorName(Datum doctor) {
    return doctor.details?.fullName ?? 'Unknown Doctor';
  }

  // Get doctor's specialization
  String getDoctorSpecialization(Datum doctor) {
    if (doctor.details?.specialization != null) {
      return doctor.details!.specialization.toString();
    }
    return 'General Practice';
  }

  // Get doctor's email
  String getDoctorEmail(Datum doctor) {
    return doctor.email ?? 'No email provided';
  }

  // Get doctor's hospital
  String getDoctorHospital(Datum doctor) {
    return doctor.details?.hospitalName ?? 'Not specified';
  }

  // Get doctor's phone
  String getDoctorPhone(Datum doctor) {
    return doctor.phoneNumber ?? 'No phone provided';
  }
}
