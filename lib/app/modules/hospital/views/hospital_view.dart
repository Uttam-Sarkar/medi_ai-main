import 'package:any_image_view/any_image_view.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medi/app/core/custom_widgets/global_appbar.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/style/app_colors.dart';
import '../../../core/style/app_style.dart';
import '../../../data/remote/model/hospital/hospitals_response.dart';
import '../controllers/hospital_controller.dart';

class HospitalView extends GetView<HospitalController> {
  const HospitalView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: AppColors.primaryColor,
        appBar: globalAppBar(context, 'Find a Hospital'.tr),
        body: RefreshIndicator(
          onRefresh: controller.refreshHospitals,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header section with question
                  ClayContainer(
                    depth: 16,
                    spread: 2,
                    color: AppColors.primaryColor,
                    borderRadius: 12,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      width: double.infinity,
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Do you need to go to a hospital?'.tr,
                                  style: textHeaderStyle(
                                    color: const Color.fromARGB(255, 51, 74, 96),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ClayContainer(
                            depth: 12,
                            spread: 6,
                            color: AppColors.primaryColor,
                            borderRadius: 60,
                            child: SizedBox(
                              height: 60,
                              width: 60,
                              child: Icon(
                                Icons.local_hospital,
                                color: AppColors.primaryAccentColor,
                                size: 30,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Search section
                  ClayContainer(
                    depth: 16,
                    spread: 2,
                    color: AppColors.primaryColor,
                    borderRadius: 8,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: TextField(
                        controller: controller.searchController,
                        decoration: InputDecoration(
                          labelText: 'Search hospitals by name...'.tr,
                          hintText: 'Type hospital name to search'.tr,
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                          ),
                          suffixIcon: Icon(
                            Icons.search,
                            color: AppColors.primaryAccentColor,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Selected specialties chips
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: controller.selectedSpecialties
                        .map(
                          (specialty) => Chip(
                            backgroundColor: AppColors.primaryAccentColor.withOpacity(0.2),
                            labelStyle: TextStyle(
                              color: AppColors.primaryAccentColor,
                            ),
                            label: Text(
                              specialty,
                            ),
                            // specialty already localized in controller
                            deleteIcon: Icon(
                              Icons.close,
                              size: 16,
                              color: AppColors.primaryAccentColor,
                            ),
                            onDeleted: () {
                              controller.selectedSpecialties.remove(specialty);
                              controller.searchHospitals();
                            },
                          ),
                        )
                        .toList(),
                  ),

                  const SizedBox(height: 24),

                  // Results section - Replace with actual hospital list
                  _buildNearbyHospitalsList(),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildNearbyHospitalsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nearby Hospitals'.tr,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryAccentColor,
          ),
        ),
        const SizedBox(height: 16),
        // Remove Obx here
        controller.isLoading.value
            ? SizedBox()
            : controller.filteredHospitals.isEmpty
                ? Center(
                    child: Text(
                      controller.searchController.text.isNotEmpty
                          ? 'No hospitals found matching "${controller.searchController.text}"'.tr
                          : 'No nearby hospitals found'.tr,
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.filteredHospitals.length,
                    itemBuilder: (context, index) {
                      final hospital = controller.filteredHospitals[index];
                      return _buildHospitalCard(hospital);
                    },
                  ),
      ],
    );
  }

  Widget _buildHospitalCard(PatientNearbyHospital hospital) {
    final hospitalName =
        hospital.details?.generalInfo?.name ?? 'Unknown Hospital'.tr;
    final hospitalId = hospital.mediid ?? '0000';
    final location =
        hospital.details?.generalInfo?.address ?? 'Unknown Location'.tr;
    final phoneNumber = hospital.details?.generalInfo?.phoneNumber ?? '';
    final nightPhone = hospital.details?.generalInfo?.nightPhone ?? '';
    final distance = hospital.distance != null
        ? '${hospital.distance!.toStringAsFixed(2)} KM'
        : '';
    final role = hospital.role ?? 'Hospital';
    final lat = hospital.lat ?? hospital.details?.lat ?? 0.0;
    final lng = hospital.lng ?? hospital.details?.long ?? 0.0;

    // Get working hours
    String workingHours = '';
    String secondHours = '';

    if (hospital.details?.workingHours != null &&
        hospital.details!.workingHours!.isNotEmpty) {
      final todayHours = hospital.details!.workingHours!.first;
      workingHours =
      '${todayHours.openTime ?? '09:00'} ${todayHours.closeTime ?? '17:00'}';
    }

    if (hospital.details?.secondHours != null &&
        hospital.details!.secondHours!.isNotEmpty) {
      final todaySecondHours = hospital.details!.secondHours!.first;
      secondHours =
      '${todaySecondHours.openTime ?? '09:00'} ${todaySecondHours.closeTime ??
          '17:00'}';
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: ClayContainer(
        depth: 20,
        spread: 5,
        color: AppColors.primaryColor,
        borderRadius: 12,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top - Hospital logo/image
            Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Stack(
                children: [
                  AnyImageView(
                    imagePath: hospital.details?.uploadLogo,
                    fit: BoxFit.fill,
                    width: double.infinity,
                    errorPlaceHolder: 'assets/image/hospital.png',
                  ),
                  // Location button in top right
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.primaryAccentColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: IconButton(
                        onPressed: () =>
                            _openGoogleMaps(double.parse(lat
                                .toString()), double.parse(lng.toString())),
                        icon: const Icon(
                          Icons.location_on,
                          color: AppColors.primaryAccentColor,
                          size: 24,
                        ),
                        tooltip: 'Open in Google Maps'.tr,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Bottom - Hospital details
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Hospital name and ID
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          hospitalName.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.medical_services,
                        color: AppColors.primaryAccentColor,
                        size: 24,
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    hospitalId,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Location and Distance row
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 16,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          location,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (distance.isNotEmpty) ...[
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.directions_walk,
                          size: 16,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          distance,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Emergency type
                  Text(
                    'Emergency Service'.tr,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 12),

                  // Phone numbers
                  if (phoneNumber.isNotEmpty || nightPhone.isNotEmpty) ...[
                    Row(
                      children: [
                        const Icon(Icons.phone, size: 16, color: Colors.blue),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (phoneNumber.isNotEmpty)
                                GestureDetector(
                                  onTap: () => _makePhoneCall(phoneNumber),
                                  child: Text(
                                    '$phoneNumber ${'Day Phone'.tr}',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              if (nightPhone.isNotEmpty)
                                GestureDetector(
                                  onTap: () => _makePhoneCall(nightPhone),
                                  child: Text(
                                    '$nightPhone ${'Night Phone'.tr}',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                  ],

                  // Role
                  Text(
                    '${'Role'.tr} : $role',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Working hours
                  if (workingHours.isNotEmpty || secondHours.isNotEmpty) ...[
                    if (workingHours.isNotEmpty)
                      Text(
                        '${'Working Hours'.tr} $workingHours',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black87,
                        ),
                      ),
                    if (secondHours.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text(
                        '${'Second Working Hours'.tr} $secondHours',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                    const SizedBox(height: 8),
                  ],

                  // Additional accessibility info
                  Wrap(
                    spacing: 16,
                    runSpacing: 4,
                    children: [
                      Text(
                        '${'Parking'.tr} -',
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.black54,
                        ),
                      ),
                      Text(
                        '${'Wheelchair Entry'.tr} -',
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.black54,
                        ),
                      ),
                      Text(
                        '${'Wheelchair Toilet'.tr} -',
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.black54,
                        ),
                      ),
                      Text(
                        '${'Visually Impaired Support'.tr} -',
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.black54,
                        ),
                      ),
                      Text(
                        '${'Hearing Impairments Support'.tr} -',
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openGoogleMaps(double lat, double lng) async {
    final String googleMapsUrl =
        'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
    final String googleMapsAppUrl = 'comgooglemaps://?q=$lat,$lng';

    try {
      // Try to open in Google Maps app first
      if (await canLaunchUrl(Uri.parse(googleMapsAppUrl))) {
        await launchUrl(Uri.parse(googleMapsAppUrl));
      } else {
        // Fall back to web version
        await launchUrl(
          Uri.parse(googleMapsUrl),
          mode: LaunchMode.externalApplication,
        );
      }
    } catch (e) {
      // If both fail, show a snackbar
      Get.snackbar(
        'Error'.tr,
        'Could not open Google Maps'.tr,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void _makePhoneCall(String phoneNumber) async {
    final String telUrl = 'tel:$phoneNumber';

    try {
      if (await canLaunchUrl(Uri.parse(telUrl))) {
        await launchUrl(Uri.parse(telUrl));
      } else {
        Get.snackbar(
          'Error'.tr,
          'Could not open dialer'.tr,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error'.tr,
        'Could not make phone call'.tr,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
