import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:clay_containers/clay_containers.dart';
import '../../../core/style/app_colors.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  OnboardingView({super.key});

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: Center(
          child: Container(
            width: Get.width / 1.10,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Column(
                children: [
                  // Skip button at the top right
                  Obx(() {
                    final showSkip = controller.currentPage.value > 0 &&
                        controller.currentPage.value < controller.pages.length;
                    return Row(
                      children: [
                        const Spacer(),
                        if (showSkip)
                          TextButton(
                            onPressed: controller.finishOnboarding,
                            child: Text(
                              'Skip'.tr,
                              style: TextStyle(
                                color: AppColors.primaryAccentColor,
                                fontSize: 14,
                              ),
                            ),
                          ),
                      ],
                    );
                  }),
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      physics: const BouncingScrollPhysics(),
                      onPageChanged: (index) =>
                          controller.currentPage.value = index,
                      itemCount: controller.pages.length + 1,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          // Language selection page
                          return Center(
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 40),
                                  Text(
                                    'Welcome!'.tr,
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.primaryAccentColor,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    'Choose your language to get started.'.tr,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black87,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 32),
                                  ClayContainer(
                                    color: AppColors.primaryColor,
                                    borderRadius: 16,
                                    depth: 20,
                                    spread: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 24,
                                        vertical: 16,
                                      ),
                                      child: DropdownButtonHideUnderline(
                                        child: Obx(
                                          () => DropdownButton<String>(
                                            value:
                                                controller.selectedLang.value,
                                            items: controller.languages
                                                .map(
                                                  (lang) => DropdownMenuItem(
                                                    value: lang['value'],
                                                    child: Text(lang['text']!),
                                                  ),
                                                )
                                                .toList(),
                                            onChanged: (val) {
                                              if (val != null) {
                                                controller.setLanguage(val);
                                                // Force rebuild to ensure UI updates
                                                Get.forceAppUpdate();
                                              }
                                            },
                                            isExpanded: true,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 32),
                                  Obx(
                                    () => Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: List.generate(
                                        controller.pages.length + 1,
                                        (i) => Container(
                                          margin: const EdgeInsets.symmetric(
                                            horizontal: 4,
                                          ),
                                          width: 10,
                                          height: 10,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: controller
                                                        .currentPage.value ==
                                                    i
                                                ? AppColors.primaryAccentColor
                                                : Colors.grey[300],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else {
                          final page = controller.pages[index - 1];
                          return Center(
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 24),
                                  // Title above the image
                                  Text(
                                    page['title']!.tr,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.primaryAccentColor,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 16),
                                  ClayContainer(
                                    color: AppColors.primaryColor,
                                    borderRadius: 24,
                                    depth: 40,
                                    spread: 8,
                                    child: Padding(
                                      padding: const EdgeInsets.all(24.0),
                                      child: Image.asset(
                                        page['image']!,
                                        height: 160,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  Text(
                                    page['subtitle']!.tr,
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black87,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 16),
                                  Obx(
                                    () => Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: List.generate(
                                        controller.pages.length + 1,
                                        (i) => Container(
                                          margin: const EdgeInsets.symmetric(
                                            horizontal: 4,
                                          ),
                                          width: 10,
                                          height: 10,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: controller
                                                        .currentPage.value ==
                                                    i
                                                ? AppColors.primaryAccentColor
                                                : Colors.grey[300],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                ],
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),

                  SizedBox(
                    width: Get.width / 1.5,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () {
                        if (controller.currentPage.value <
                            controller.pages.length) {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.ease,
                          );
                        } else {
                          controller.finishOnboarding();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryAccentColor,
                        foregroundColor: Colors.white,
                        elevation: 6,
                        shadowColor:
                            AppColors.primaryAccentColor.withValues(alpha: 0.3),
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
                      child: Text(
                        'Next'.tr,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.1,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
