import 'package:clay_containers/widgets/clay_container.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../core/helper/app_widgets.dart';
import '../../../core/style/app_colors.dart';
import '../controllers/ambulance_registration_controller.dart';

class AmbulanceRegistrationView
    extends GetView<AmbulanceRegistrationController> {
  const AmbulanceRegistrationView({super.key});
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: PageView(
                  controller: controller.pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    // Page 1: Phone, Email, Password
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          AppWidgets().gapH24(),
                          ClayContainer(
                            color: AppColors.primaryColor,
                            borderRadius: 60,
                            depth: 12,
                            spread: 6,
                            child: SizedBox(
                              width: 100,
                              height: 100,
                              child: Icon(
                                Icons.person_add_alt_1,
                                size: 48,
                                color: AppColors.primaryAccentColor,
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          Row(
                            children: [
                              ClayContainer(
                                depth: 16,
                                spread: 2,
                                color: AppColors.primaryColor,
                                borderRadius: 8,
                                child: CountryCodePicker(
                                  onChanged: (country) => controller.countryCode
                                      .value = country.dialCode ?? '',
                                  initialSelection:
                                      controller.countryCode.value.isNotEmpty
                                          ? controller.countryCode.value
                                          : '+1',
                                  favorite: const ['+1', '+88'],
                                  showCountryOnly: false,
                                  showOnlyCountryWhenClosed: false,
                                  alignLeft: false,
                                  textStyle: const TextStyle(
                                    color: Colors.black,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: ClayContainer(
                                  depth: 16,
                                  spread: 2,
                                  color: AppColors.primaryColor,
                                  borderRadius: 8,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 2,
                                    ),
                                    child: TextField(
                                      controller: controller.phoneController,
                                      keyboardType: TextInputType.phone,
                                      decoration: InputDecoration(
                                        labelText: 'Phone'.tr,
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.symmetric(
                                          horizontal: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          ClayContainer(
                            depth: 16,
                            spread: 2,
                            color: AppColors.primaryColor,
                            borderRadius: 8,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 2),
                              child: TextField(
                                controller: controller.emailController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  labelText: 'Email'.tr,
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 12,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Obx(
                            () => ClayContainer(
                              depth: 16,
                              spread: 2,
                              color: AppColors.primaryColor,
                              borderRadius: 8,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 2,
                                ),
                                child: TextField(
                                  controller: controller.passwordController,
                                  obscureText:
                                      !controller.isPasswordVisible.value,
                                  decoration: InputDecoration(
                                    labelText: 'Password'.tr,
                                    border: InputBorder.none,
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        controller.isPasswordVisible.value
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: AppColors.primaryAccentColor,
                                      ),
                                      onPressed: () {
                                        controller.isPasswordVisible.value =
                                            !controller.isPasswordVisible.value;
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 32),
                          SizedBox(
                            width: double.infinity,
                            height: 45,
                            child: ElevatedButton(
                              onPressed: controller.registerUser,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryAccentColor,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                elevation: 0,
                              ),
                              child: Text('Continue'.tr),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
