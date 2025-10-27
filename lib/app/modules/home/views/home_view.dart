import 'package:any_image_view/any_image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:medi/app/core/base/base_view.dart';
import 'package:medi/app/core/helper/app_helper.dart';
import 'package:medi/app/core/helper/app_widgets.dart';
import '../../../core/helper/shared_value_helper.dart';
import '../../../core/style/app_colors.dart';
import '../controllers/home_controller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../../data/remote/model/hospital/hospitals_response.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../routes/app_pages.dart';

class HomeView extends BaseView<HomeController> {
  HomeView({super.key});

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return null;
  }

  @override
  Widget body(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Medi AI'.tr,
          style: const TextStyle(
            color: AppColors.primaryAccentColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.primaryAccentColor),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              Get.toNamed(Routes.NOTIFICATION);
            },
            tooltip: 'Notifications'.tr,
          ),
        ],
      ),
      drawer: _buildDrawerByRole(),
      backgroundColor: AppColors.primaryColor,
      body: _buildDashboardByRole(context),

    );
  }

  Widget _buildDrawerByRole() {
    switch (userRole.$) {
      case 'ambulance':
        return _buildAmbulanceDrawer();
      case 'hospital':
        return _buildHospitalDrawer();
      default:
        return _buildPatientDrawer();
    }
  }

  Widget _buildDashboardByRole(BuildContext context) {
    switch (userRole.$) {
      case 'ambulance':
        return _buildAmbulanceDashboard(context);
      case 'hospital':
        return _buildHospitalDashboard(context);
      default:
        return _buildDashboard(context);
    }
  }

  Widget _buildAmbulanceDrawer() {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            _buildDrawerHeader(),
            Expanded(
              child: ListView(
                children: [
                  _buildDrawerItem(
                    icon: FontAwesomeIcons.userInjured,
                    title: 'Add Patient'.tr,
                    onTap: () {},
                  ),
                  _buildDrawerItem(
                    icon: FontAwesomeIcons.userNurse,
                    title: 'Driver'.tr,
                    onTap: () {},
                  ),
                  _buildDrawerItem(
                    icon: FontAwesomeIcons.commentMedical,
                    title: 'AI Chat'.tr,
                    onTap: () => Get.toNamed(Routes.CHAT_LIST),
                  ),
                ],
              ),
            ),
            _buildLogoutButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildAmbulanceDashboard(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [const SizedBox(height: 16), _buildAmDashboard()],
      ),
    );
  }

  Widget _buildHospitalDrawer() {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            _buildDrawerHeader(),
            Expanded(
              child: ListView(
                children: [
                  _buildDrawerItem(
                    icon: FontAwesomeIcons.commentMedical,
                    title: 'AI Chat'.tr,
                    onTap: () => Get.toNamed(Routes.CHAT_LIST),
                  ),
                  _buildDrawerItem(
                    icon: FontAwesomeIcons.newspaper,
                    title: 'News'.tr,
                    onTap: () => Get.toNamed(Routes.NEWS),
                    badge: 'New'.tr, // Shows new content, now translated
                  ),
                  _buildDrawerItem(
                    icon: FontAwesomeIcons.gear,
                    title: 'Settings'.tr,
                    onTap: () => Get.toNamed(Routes.SETTINGS),
                  ),
                ],
              ),
            ),
            _buildLogoutButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildHospitalDashboard(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [const SizedBox(height: 16), _buildHospitalGridDashboard()],
      ),
    );
  }

  Widget _buildPatientDrawer() {
    return Drawer(
      elevation: 0, // Reduce shadow for cleaner look
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white, // Lighter background for better readability
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: SafeArea(
          // Ensures content doesn't overlap with system UI
          child: Column(
            children: [
              _buildDrawerHeader(),
              Expanded(
                child: SingleChildScrollView(
                  // Better scrolling experience
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 12.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDrawerItem(
                        icon: FontAwesomeIcons.hospital,
                        title: 'Hospitals'.tr,
                        onTap: () => Get.toNamed(Routes.HOSPITAL),
                        badge: controller.patientNearbyHospital.length
                            .toString(),
                      ),
                      _buildDrawerItem(
                        icon: FontAwesomeIcons.truckMedical,
                        title: 'Ambulance'.tr,
                        onTap: () => Get.toNamed(Routes.AMBULANCE),
                        isUrgent: true, // Highlights emergency services
                      ),
                      _buildDrawerItem(
                        icon: FontAwesomeIcons.commentMedical,
                        title: 'AI Chat'.tr,
                        onTap: () => Get.toNamed(Routes.CHAT_LIST),
                        subtitle: 'Talk to medical assistant'.tr,
                        isNew: true, // Highlights new features
                      ),
                      _buildDrawerItem(
                        icon: FontAwesomeIcons.newspaper,
                        title: 'News'.tr,
                        onTap: () => Get.toNamed(Routes.NEWS),
                        badge: 'New', // Shows new content
                      ),
                      _buildDrawerItem(
                        icon: FontAwesomeIcons.gear,
                        title: 'Settings'.tr,
                        onTap: () => Get.toNamed(Routes.SETTINGS),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              _buildLogoutButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerHeader() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(128, 128, 128, 0.1),
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          ClayContainer(
            color: AppColors.primaryColor,
            borderRadius: 50,
            depth: 15,
            spread: 3,
            curveType: CurveType.convex,
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: const Center(
                child: Icon(
                  Icons.person,
                  size: 30,
                  color: AppColors.primaryAccentColor,
                ),
              ),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Medi Ai'.tr,
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 8),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.primaryAccentColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Pro',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                if (!userName.$.contains('null'))
                  Text(
                    userName.$,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),

                GestureDetector(
                  onTap: () => _copyToClipboard(mediId.$, 'Medi ID'),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          mediId.$,
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(
                        Icons.copy,
                        size: 16,
                        color: AppColors.primaryAccentColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isActive = false,
    bool isUrgent = false,
    bool isNew = false,
    String? subtitle,
    String? badge,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        splashColor: Color.fromRGBO(24, 90, 157, 0.1),
        highlightColor: Color.fromRGBO(24, 90, 157, 0.05),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 4),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: isActive
                ? Color.fromRGBO(24, 90, 157, 0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: isActive
                ? Border.all(color: Color.fromRGBO(24, 90, 157, 0.3), width: 1)
                : null,
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isUrgent
                      ? Color.fromRGBO(255, 82, 82, 0.1)
                      : (isActive
                            ? Color.fromRGBO(24, 90, 157, 0.2)
                            : Color.fromRGBO(240, 244, 248, 0.7)),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: FaIcon(
                  icon,
                  color: isUrgent
                      ? Colors.redAccent
                      : AppColors.primaryAccentColor,
                  size: 18,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          title.tr,
                          style: TextStyle(
                            color: isActive
                                ? AppColors.primaryAccentColor
                                : Colors.black87,
                            fontWeight: isActive
                                ? FontWeight.w600
                                : FontWeight.w500,
                            fontSize: 15,
                          ),
                        ),
                        if (isNew) ...[
                          SizedBox(width: 8),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              'NEW'.tr,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 8,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    if (subtitle != null) ...[
                      SizedBox(height: 2),
                      Text(
                        subtitle.tr,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (badge != null) ...[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: badge == 'New'.tr
                        ? Colors.amber
                        : AppColors.primaryAccentColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    badge.tr,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
              if (isActive) ...[
                SizedBox(width: 8),
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primaryAccentColor,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogoutButton() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(128, 128, 128, 0.1),
            blurRadius: 10,
            offset: Offset(0, -3),
          ),
        ],
      ),
      child: ElevatedButton.icon(
        onPressed: () {
          AppHelper().logout();
        },
        icon: FaIcon(FontAwesomeIcons.rightFromBracket, size: 16),
        label: Text('Logout'.tr),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red.shade50,
          foregroundColor: Colors.red.shade700,
          elevation: 0,
          padding: EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Widget _buildDashboard(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          _buildGridDashboard(context),
          const SizedBox(height: 24),
          _buildNearbyHospitalsList(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildGridDashboard(BuildContext context) {
    final List<Map<String, dynamic>> services = [
      {
        'title': 'My Medical History'.tr,
        'icon': Icons.history,
        'color': Colors.blue,
        'onTap': () => Get.toNamed(Routes.MEDICAL_HISTORY, arguments: false),
      },
      {
        'title': 'My Symptoms'.tr,
        'icon': Icons.healing,
        'color': Colors.green,
        'onTap': () => Get.toNamed(Routes.MY_SYMPTOMS),
      },
      {
        'title': 'Translator'.tr,
        'icon': Icons.translate,
        'color': Colors.orange,
        'onTap': () {
          controller.showTranslatorDialog(context);
        },
      },
      {
        'title': 'Translated Documents'.tr,
        'icon': Icons.description,
        'color': Colors.purple,
        'onTap': () => Get.toNamed(Routes.MEDICAL_HISTORY, arguments: true),
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.1,
      ),
      itemCount: services.length,
      itemBuilder: (context, index) {
        final service = services[index];
        return GestureDetector(
          onTap: service['onTap'],
          child: ClayContainer(
            depth: 20,
            spread: 5,
            color: AppColors.primaryColor,
            borderRadius: 12,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(service['icon'], size: 40, color: service['color']),
                const SizedBox(height: 12),
                Text(
                  service['title'],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryAccentColor,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAmDashboard() {
    final List<Map<String, dynamic>> services = [
      {
        'title': 'Add Patient'.tr,
        'icon': FontAwesomeIcons.userInjured,
        'color': AppColors.primaryAccentColor,
        'onTap': () => Get.toNamed(Routes.ADD_PATIENT),
      },
      {
        'title': 'Driver'.tr,
        'icon': FontAwesomeIcons.userNurse,
        'color': AppColors.primaryAccentColor,
        'onTap': () => AppWidgets().getSnackBar(
          title: 'Info'.tr,
          message: 'Coming soon!'.tr,
        ),
      },
      {
        'title': 'AI Chat'.tr,
        'icon': FontAwesomeIcons.commentMedical,
        'color': AppColors.primaryAccentColor,
        'onTap': () => Get.toNamed(Routes.CHAT_LIST),
      },
      {
        'title': 'Logout'.tr,
        'icon': FontAwesomeIcons.rightFromBracket,
        'color': AppColors.primaryAccentColor,
        'onTap': () => AppHelper().logout(),
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.1,
      ),
      itemCount: services.length,
      itemBuilder: (context, index) {
        final service = services[index];
        return GestureDetector(
          onTap: service['onTap'],
          child: ClayContainer(
            depth: 20,
            spread: 5,
            color: AppColors.primaryColor,
            borderRadius: 12,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(service['icon'], size: 40, color: service['color']),
                const SizedBox(height: 12),
                Text(
                  service['title'],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryAccentColor,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHospitalGridDashboard() {
    final List<Map<String, dynamic>> services = [
      {
        'title': 'Add Patient'.tr,
        'icon': FontAwesomeIcons.userInjured,
        'color': AppColors.primaryAccentColor,
        'onTap': () => Get.toNamed(Routes.ADD_PATIENT),
      },
      {
        'title': 'Add Doctor'.tr,
        'icon': FontAwesomeIcons.userDoctor,
        'color': AppColors.primaryAccentColor,
        'onTap': () => Get.toNamed(Routes.DOCTOR),
      },
      {
        'title': 'Add Form'.tr,
        'icon': FontAwesomeIcons.fileCirclePlus,
        'color': AppColors.primaryAccentColor,
        'onTap': () => Get.toNamed(Routes.FORM),
      },
      {
        'title': 'Invoices'.tr,
        'icon': FontAwesomeIcons.fileInvoiceDollar,
        'color': AppColors.primaryAccentColor,
        'onTap': () => Get.toNamed(Routes.INVOICES),
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.1,
      ),
      itemCount: services.length,
      itemBuilder: (context, index) {
        final service = services[index];
        return GestureDetector(
          onTap: service['onTap'],
          child: ClayContainer(
            depth: 20,
            spread: 5,
            color: AppColors.primaryColor,
            borderRadius: 12,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(service['icon'], size: 40, color: service['color']),
                const SizedBox(height: 12),
                Text(
                  service['title'],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryAccentColor,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
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
        Obx(() {
          if (controller.patientNearbyHospital.isEmpty) {
            return Center(
              child: Text(
                'No nearby hospitals found'.tr,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }

          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.patientNearbyHospital.length,
            itemBuilder: (context, index) {
              final hospital = controller.patientNearbyHospital[index];
              return _buildHospitalCard(hospital);
            },
          );
        }),
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
          '${todaySecondHours.openTime ?? '09:00'} ${todaySecondHours.closeTime ?? '17:00'}';
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
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.primaryAccentColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: IconButton(
                        onPressed: () => _openGoogleMaps(
                          double.parse(lat.toString()),
                          double.parse(lng.toString()),
                        ),
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

  void _copyToClipboard(String text, String label) {
    Clipboard.setData(ClipboardData(text: text)).then((_) {
      Get.snackbar(
        'Copied'.tr,
        '$label ${'copied to clipboard'.tr}',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
        backgroundColor: AppColors.primaryAccentColor.withOpacity(0.8),
        colorText: Colors.white,
        margin: EdgeInsets.all(16),
        borderRadius: 8,
        icon: Icon(Icons.check_circle, color: Colors.white),
      );
    });
  }
}
