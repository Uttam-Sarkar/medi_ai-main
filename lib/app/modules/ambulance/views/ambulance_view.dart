import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medi/app/core/custom_widgets/global_appbar.dart';
import 'package:medi/app/core/helper/print_log.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/style/app_colors.dart';
import '../../../core/style/app_style.dart';
import '../controllers/ambulance_controller.dart';

class AmbulanceView extends GetView<AmbulanceController> {
  const AmbulanceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: globalAppBar(context, 'Find an Ambulance'.tr),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                              'Do you need an ambulance?'.tr,
                              style: textHeaderStyle(
                                color: AppColors.primaryAccentColor,
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
                            Icons.local_shipping,
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
                      labelText: 'Search ambulances...'.tr,
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.search,
                          color: AppColors.primaryAccentColor,
                        ),
                        onPressed: controller.searchAmbulances,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Select Ambulance Types'.tr,
                style: textHeaderStyle(
                  color: AppColors.primaryAccentColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Obx(
                () => Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: controller.selectedTypes
                      .map(
                        (type) => Chip(
                          backgroundColor: AppColors.primaryAccentColor
                              .withValues(alpha: 0.2),
                          labelStyle: TextStyle(
                            color: AppColors.primaryAccentColor,
                          ),
                          label: Text(type.tr),
                          deleteIcon: Icon(
                            Icons.close,
                            size: 16,
                            color: AppColors.primaryAccentColor,
                          ),
                          onDeleted: () {
                            controller.selectedTypes.remove(type);
                            controller.searchAmbulances();
                          },
                        ),
                      )
                      .toList(),
                ),
              ),
              const SizedBox(height: 24),
              Obx(() {
                if (controller.isLoading.value) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: CircularProgressIndicator(
                        color: AppColors.primaryAccentColor,
                      ),
                    ),
                  );
                } else if (controller.noResultsFound.value) {
                  return ClayContainer(
                    depth: 16,
                    spread: 2,
                    color: AppColors.primaryColor,
                    borderRadius: 8,
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        children: [
                          Text(
                            'No Results Found'.tr,
                            style: textHeaderStyle(
                              color: AppColors.textColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.gray,
                                  foregroundColor: AppColors.textColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text('Previous'.tr),
                              ),
                              const SizedBox(width: 16),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryAccentColor,
                                  foregroundColor: AppColors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text('Next'.tr),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return ClayContainer(
                    depth: 16,
                    spread: 2,
                    color: AppColors.primaryColor,
                    borderRadius: 12,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.filteredAmbulanceData.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          return ClayContainer(
                            depth: 12,
                            spread: 2,
                            color: AppColors.primaryColor,
                            borderRadius: 10,
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: AppColors.primaryAccentColor
                                    .withValues(alpha: 0.15),
                                child: Icon(
                                  Icons.local_shipping,
                                  color: AppColors.primaryAccentColor,
                                ),
                              ),
                              title: Text(
                                controller.filteredAmbulanceData[index].email!
                                    .split('@')
                                    .first
                                    .toString(),
                                style: TextStyle(
                                  color: AppColors.textColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              subtitle: Text(
                                '${controller.filteredAmbulanceData[index].email}\n ${controller.filteredAmbulanceData[index].phoneNumber}',
                                style: TextStyle(
                                  color: AppColors.textColor
                                      .withValues(alpha: 0.7),
                                  fontSize: 13,
                                ),
                              ),
                              trailing: IconButton(
                                icon: Icon(
                                  Icons.call,
                                  color: AppColors.primaryAccentColor,
                                ),
                                onPressed: () async {
                                  final phone = controller
                                      .filteredAmbulanceData[index].phoneNumber;
                                  final uri = Uri(scheme: 'tel', path: phone);
                                  if (await canLaunchUrl(uri)) {
                                    await launchUrl(uri);
                                  } else {
                                    printLog('Could not launch $uri');
                                  }
                                },
                                tooltip: 'Call Ambulance'.tr,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
