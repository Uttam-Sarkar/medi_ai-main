import 'package:flutter/material.dart';
import 'package:clay_containers/clay_containers.dart';

import 'package:get/get.dart';
import 'package:medi/app/core/custom_widgets/global_appbar.dart';
import '../../../core/style/app_colors.dart';

import '../../../data/remote/model/ambulance/patient_list_response.dart';
import '../controllers/add_patient_controller.dart';

class AddPatientView extends GetView<AddPatientController> {
  const AddPatientView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: globalAppBar(context, 'Add Patient'.tr),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            controller.patientList.clear();
            await controller.getPatientList();
          },
          color: AppColors.primaryAccentColor,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 24.0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Add Patient Form
                  ClayContainer(
                    color: Colors.white,
                    borderRadius: 24,
                    depth: 30,
                    spread: 3,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 32.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: AppColors.primaryAccentColor
                                    .withOpacity(0.1),
                                radius: 24,
                                child: Icon(
                                  Icons.person_add_alt_1,
                                  color: AppColors.primaryAccentColor,
                                  size: 28,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  'Add Patient'.tr,
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryAccentColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          Text(
                            'Unique Identification Number'.tr,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryAccentColor,
                            ),
                          ),
                          const SizedBox(height: 8),
                          ClayContainer(
                            color: Colors.white,
                            borderRadius: 8,
                            depth: 12,
                            spread: 2,
                            child: TextField(
                              controller: controller.idController,
                              keyboardType: TextInputType.number,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.vpn_key,
                                  color: AppColors.primaryAccentColor.withOpacity(
                                    0.7,
                                  ),
                                ),
                                hintText: 'Enter unique ID'.tr,
                                hintStyle: TextStyle(
                                  color: AppColors.primaryAccentColor.withOpacity(
                                    0.5,
                                  ),
                                  fontWeight: FontWeight.w400,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    color: AppColors.primaryAccentColor
                                        .withOpacity(0.2),
                                    width: 1.5,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    color: AppColors.primaryAccentColor,
                                    width: 2,
                                  ),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 18,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Divider(
                            color: AppColors.primaryAccentColor.withOpacity(0.15),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'You will receive a unique member number that includes a country code and a 6-digit unique number.'
                                .tr,
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.primaryAccentColor.withOpacity(
                                0.7,
                              ),
                            ),
                          ),
                          const SizedBox(height: 32),
                          SizedBox(height: 8),
                          SizedBox(
                            width: double.infinity,
                            child: Row(
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    height: 45,
                                    child: OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                        side: BorderSide(
                                          color: AppColors.primaryAccentColor,
                                          width: 2,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                      ),
                                      onPressed: () => Get.back(),
                                      child: Text(
                                        'Cancel'.tr,
                                        style: TextStyle(
                                          color: AppColors.primaryAccentColor,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: SizedBox(
                                    height: 45,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            AppColors.primaryAccentColor,
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        elevation: 0,
                                      ),
                                      onPressed: () {
                                        controller.addPatient(
                                          controller.idController.text.trim(),
                                        );
                                      },
                                      child: Text(
                                        'Connect'.tr,
                                        style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Patient List Section
                  _buildPatientListSection(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPatientListSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.people, color: AppColors.primaryAccentColor, size: 24),
            const SizedBox(width: 8),
            Text(
              'Connected Patients'.tr,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryAccentColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Obx(() {
          if (controller.patientList.isEmpty) {
            return Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Column(
                children: [
                  Icon(Icons.people_outline, size: 48, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    'No patients connected yet'.tr,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Add patients using their unique ID above'.tr,
                    style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                  ),
                ],
              ),
            );
          }

          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.patientList.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final patient = controller.patientList[index];
              return _buildPatientCard(patient, index);
            },
          );
        }),
      ],
    );
  }

  Widget _buildPatientCard(PatientListData patient, int index) {
    // Get patient name from personal details
    String patientName = 'Unknown';
    if (patient.details?.personalDetails?.firstName != null &&
        patient.details?.personalDetails?.lastName != null) {
      patientName =
          '${patient.details!.personalDetails!.firstName} ${patient.details!.personalDetails!.lastName}';
    } else if (patient.details?.personalDetails?.firstName != null) {
      patientName = patient.details!.personalDetails!.firstName!;
    }

    // Get other details
    String patientEmail = patient.email ?? 'No email';
    String patientPhone = patient.phoneNumber ?? 'No phone';
    String patientAge = patient.details?.personalDetails?.age ?? 'Unknown age';
    String patientGender =
        patient.details?.personalDetails?.gender ?? 'Unknown gender';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: AppColors.primaryColor.withOpacity(0.1),
                  child: Text(
                    patientName.isNotEmpty ? patientName[0].toUpperCase() : 'P',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        patientName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '$patientAge • $patientGender',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                // Show status or disconnect button based on status
                if (patient.requestDetails!.first.status == 'accepted')
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.buttonColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: AppColors.buttonColor.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: AppColors.buttonColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Connected'.tr,
                          style: const TextStyle(
                            color: AppColors.buttonColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.orange.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Colors.orange,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          patient.requestDetails!.first.status?.toString().toUpperCase() ?? 'PENDING',
                          style: const TextStyle(
                            color: Colors.orange,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.email_outlined, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    patientEmail,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.phone_outlined, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    patientPhone,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Show disconnect button only if status is accepted
            if (patient.requestDetails!.first.status == 'accepted')
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        _disconnectPatient(patient, index);
                      },
                      icon: const Icon(Icons.link_off, size: 18),
                      label: Text('Disconnect'.tr),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade50,
                        foregroundColor: Colors.red.shade700,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(color: Colors.red.shade200),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            else
              // Show a message or different action for non-accepted patients
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Text(
                  'Waiting for connection approval'.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }


  void _disconnectPatient(PatientListData patient, int index) {
    // Get patient name for the dialog
    String patientName = 'this patient';
    if (patient.details?.personalDetails?.firstName != null &&
        patient.details?.personalDetails?.lastName != null) {
      patientName =
          '${patient.details!.personalDetails!.firstName} ${patient.details!.personalDetails!.lastName}';
    } else if (patient.details?.personalDetails?.firstName != null) {
      patientName = patient.details!.personalDetails!.firstName!;
    }

    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.link_off,
                color: Colors.red,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            Text('Disconnect Patient'.tr),
          ],
        ),
        content: Text(
          'Are you sure you want to disconnect $patientName? This action cannot be undone.'.tr,
          style: const TextStyle(fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel'.tr),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: Implement disconnect functionality with API call
              controller.patientList.removeAt(index);
              Get.back();
              Get.snackbar(
                'Success'.tr,
                'Patient disconnected successfully'.tr,
                snackPosition: SnackPosition.TOP,
                backgroundColor: AppColors.buttonColor,
                colorText: Colors.white,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: Text('Disconnect'.tr),
          ),
        ],
      ),
    );
  }
}
