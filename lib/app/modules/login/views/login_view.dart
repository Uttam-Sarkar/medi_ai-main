import 'package:clay_containers/widgets/clay_container.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../../core/style/app_colors.dart';
import '../../../routes/app_pages.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: Get.width / 1.10,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Obx(
              () => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClayContainer(
                    color: AppColors.primaryColor,
                    borderRadius: 60,
                    depth: 30,
                    spread: 6,
                    child: SizedBox(
                      width: 100,
                      height: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FaIcon(
                            FontAwesomeIcons.userDoctor,
                            size: 32,
                            color: AppColors.primaryAccentColor,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Medi AI'.tr,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryAccentColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  ClayContainer(
                    color: AppColors.primaryColor,
                    borderRadius: 8,
                    depth: 12,
                    spread: 2,
                    child: ToggleButtons(
                      isSelected: [
                        controller.tabIndex.value == 0,
                        controller.tabIndex.value == 1,
                      ],
                      onPressed: (i) => controller.tabIndex.value = i,
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.primaryAccentColor,
                      selectedColor: Colors.white,
                      fillColor: AppColors.primaryAccentColor,
                      borderColor: AppColors.primaryColor,
                      selectedBorderColor: AppColors.primaryAccentColor,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text('Email'.tr),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text('Phone'.tr),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  if (controller.tabIndex.value == 0) ...[
                    ClayContainer(
                      color: AppColors.primaryColor,
                      borderRadius: 8,
                      depth: 12,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: TextField(
                          controller: controller.emailController,
                          decoration: InputDecoration(
                            labelText: 'Email'.tr,
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: 12),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Obx(
                      () => ClayContainer(
                        color: AppColors.primaryColor,
                        borderRadius: 8,
                        depth: 12,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: TextField(
                            controller: controller.passwordController,
                            obscureText: !controller.isPasswordVisible.value,
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
                  ] else ...[
                    Row(
                      children: [
                        ClayContainer(
                          color: AppColors.primaryColor,
                          borderRadius: 8,
                          depth: 12,
                          child: CountryCodePicker(
                            onChanged: (country) => controller.countryCode.value =
                                country.dialCode ?? '',
                            initialSelection:
                                controller.countryCode.value.isNotEmpty
                                    ? controller.countryCode.value
                                    : '+1',
                            favorite: const ['+1', '+91'],
                            showCountryOnly: false,
                            showOnlyCountryWhenClosed: false,
                            alignLeft: false,
                            textStyle: const TextStyle(color: Colors.black),
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ClayContainer(
                            color: AppColors.primaryColor,
                            borderRadius: 8,
                            depth: 12,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 2),
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
                      color: AppColors.primaryColor,
                      borderRadius: 8,
                      depth: 12,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: TextField(
                          controller: controller.passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password'.tr,
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: 12),
                          ),
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton.icon(
                      onPressed: () {},
                      icon: Icon(
                        Icons.lock_reset,
                        color: AppColors.primaryAccentColor,
                        size: 18,
                      ),
                      label: Text(
                        'Forgot Password?'.tr,
                        style: TextStyle(
                          color: AppColors.primaryAccentColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.primaryAccentColor,
                        padding: EdgeInsets.zero,
                        minimumSize: Size(0, 0),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: controller.login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryAccentColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                      child: Text('login'.tr),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Are you new here?".tr),
                      TextButton(
                        onPressed: () => Get.toNamed(Routes.REGISTER),
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.primaryAccentColor,
                        ),
                        child: Text(
                          'Register Now!'.tr,
                          style: TextStyle(
                            color: AppColors.primaryAccentColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
