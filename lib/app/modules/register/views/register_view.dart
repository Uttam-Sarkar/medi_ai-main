import 'package:any_image_view/any_image_view.dart';
import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medi/app/routes/app_pages.dart';
import '../../../core/helper/print_log.dart';
import '../../../core/style/app_colors.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Container(
          width: Get.width / 1.10,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: GetBuilder<RegisterController>(
            builder: (controller) {
              // Onboarding section
              if (!controller.showAgreement) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: Get.height / 2,
                      child: PageView.builder(
                        controller: controller.pageController,
                        onPageChanged: controller.onPageChanged,
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClayContainer(
                                color: AppColors.primaryColor,
                                borderRadius: 24,
                                depth: 40,
                                spread: 8,
                                child: Padding(
                                  padding: const EdgeInsets.all(24.0),
                                  child: AnyImageView(
                                    imagePath: controller.images[index],
                                    height: 160,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24),
                              Text(
                                controller.titles[index],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryAccentColor,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                controller.subtitles[index],
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: AppColors.primaryAccentColor,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        3,
                            (index) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: controller.currentPage == index
                                ? AppColors.primaryAccentColor
                                : Colors.white24,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: Get.width / 1.5,
                      height: 52,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryAccentColor,
                          foregroundColor: Colors.white,
                          elevation: 6,
                          shadowColor: AppColors.primaryAccentColor.withOpacity(
                            0.3,
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 24,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          if (controller.currentPage < 2) {
                            controller.pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          } else {
                            controller.showAgreementSection();
                          }
                        },
                        child: Text(
                          controller.currentPage < 2
                              ? 'Next'.tr
                              : 'Continue'.tr,
                        ),
                      ),
                    ),
                  ],
                );
              }
              // Agreement section
              else if (!controller.showUserTypeSelection) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.verified_user,
                      size: 48,
                      color: AppColors.primaryAccentColor,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Agreement'.tr,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryAccentColor,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Please read our privacy policy and confirm the following declarations. consents can be withdrawn in settings at any time.'
                          .tr,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    CheckboxListTile(
                      value: controller.agreePrivacy,
                      onChanged: (val) => controller.setAgreePrivacy(val!),
                      title: Text(
                        'I agree to MediAi term and conditions and confirm that I\'m at least 16 years old.'
                            .tr,
                        style: TextStyle(
                          color: controller.agreePrivacy
                              ? AppColors.primaryAccentColor
                              : Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      controlAffinity: ListTileControlAffinity.leading,
                      activeColor: AppColors.primaryAccentColor,
                    ),
                    CheckboxListTile(
                      value: controller.agreeTerms,
                      onChanged: (val) => controller.setAgreeTerms(val!),
                      title: Text(
                        'I hereby consent to MediAi using any personal health data I voluntarily share here for the purpose of assisting in health assessments and providing guidance.'
                            .tr,
                        style: TextStyle(
                          color: controller.agreeTerms
                              ? AppColors.primaryAccentColor
                              : Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      controlAffinity: ListTileControlAffinity.leading,
                      activeColor: AppColors.primaryAccentColor,
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: Get.width / 1.5,
                      height: 52,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryAccentColor,
                          foregroundColor: Colors.white,
                          elevation: 6,
                          shadowColor: AppColors.primaryAccentColor.withOpacity(
                            0.3,
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 24,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed:
                        (controller.agreeTerms && controller.agreePrivacy)
                            ? () {
                          controller.showUserTypeSelectionSection();
                        }
                            : null,
                        child: Text(
                          'Continue'.tr,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
              // User type selection section
              else {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Select User Type'.tr,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryAccentColor,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 24),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: UserType.values.map((type) {
                          final label = type == UserType.patient
                              ? 'Patient'.tr
                              : type == UserType.hospital
                              ? 'Hospital'.tr
                              : 'Ambulance'.tr;
                          final icon = type == UserType.patient
                              ? FontAwesomeIcons.user
                              : type == UserType.hospital
                              ? FontAwesomeIcons.hospital
                              : FontAwesomeIcons.ambulance;
                          final isSelected = controller.selectedUserType == type;
                          return GestureDetector(
                            onTap: () => controller.selectUserType(type),
                            child: Card(
                              color: isSelected
                                  ? AppColors.primaryAccentColor
                                  : Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                                side: BorderSide(
                                  color: isSelected
                                      ? AppColors.primaryAccentColor
                                      : Colors.transparent,
                                  width: 2,
                                ),
                              ),
                              elevation: isSelected ? 8 : 2,
                              child: Container(
                                width: 100.h,
                                height: 100.h,
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FaIcon(
                                      icon,
                                      size: 40,
                                      color: isSelected
                                          ? Colors.white
                                          : AppColors.primaryAccentColor,
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      label,
                                      style: TextStyle(
                                        color: isSelected
                                            ? Colors.white
                                            : AppColors.primaryAccentColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: Get.width / 1.5,
                      height: 52,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryAccentColor,
                          foregroundColor: Colors.white,
                          elevation: 6,
                          shadowColor: AppColors.primaryAccentColor.withOpacity(
                            0.3,
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 24,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: controller.selectedUserType != null
                            ? () {
                          // Handle registration continue with selected user type
                          printLog(
                            'Continue with user type: ${controller.selectedUserType}',
                          );

                          if (controller.selectedUserType ==
                              UserType.patient) {
                            Get.toNamed(Routes.PATIENT_REGISTRATION);
                          } else if (controller.selectedUserType ==
                              UserType.hospital) {
                            Get.toNamed(Routes.HOSPITAL_REGISTRATION);
                          } else if (controller.selectedUserType ==
                              UserType.ambulance) {
                            Get.toNamed(Routes.AMBULANCE);
                          }
                        }
                            : null,
                        child: Text(
                          'Continue'.tr,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}