import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:medi/app/core/style/app_colors.dart';
import '../../../core/helper/app_helper.dart';
import '../../../core/helper/app_widgets.dart';
import '../../../core/helper/language_helper.dart';
import '../../../core/helper/shared_value_helper.dart';

class SettingsController extends GetxController {
  // Available languages with their display names and codes
  final List<Map<String, String>> availableLanguages = [
    {'code': 'en', 'name': 'English', 'locale': 'en_US'},
    {'code': 'ar', 'name': 'Arabic', 'locale': 'ar_SA'},
    {'code': 'am', 'name': 'Amharic', 'locale': 'am_ET'},
    {'code': 'bg', 'name': 'Bulgarian', 'locale': 'bg_BG'},
    {'code': 'bn', 'name': 'Bengali', 'locale': 'bn_BD'},
    {'code': 'ca', 'name': 'Catalan', 'locale': 'ca_ES'},
    {'code': 'cs', 'name': 'Czech', 'locale': 'cs_CZ'},
    {'code': 'da', 'name': 'Danish', 'locale': 'da_DK'},
    {'code': 'de', 'name': 'German', 'locale': 'de_DE'},
    {'code': 'es', 'name': 'Spanish', 'locale': 'es_ES'},
    {'code': 'eu', 'name': 'Basque', 'locale': 'eu_ES'},
    {'code': 'fi', 'name': 'Finnish', 'locale': 'fi_FI'},
    {'code': 'fr', 'name': 'French', 'locale': 'fr_FR'},
    {'code': 'hi', 'name': 'Hindi', 'locale': 'hi_IN'},
    {'code': 'hr', 'name': 'Croatian', 'locale': 'hr_HR'},
    {'code': 'hy', 'name': 'Armenian', 'locale': 'hy_AM'},
    {'code': 'it', 'name': 'Italian', 'locale': 'it_IT'},
    {'code': 'ja', 'name': 'Japanese', 'locale': 'ja_JP'},
    {'code': 'ko', 'name': 'Korean', 'locale': 'ko_KR'},
    {'code': 'my', 'name': 'Burmese', 'locale': 'my_MM'},
    {'code': 'nl', 'name': 'Dutch', 'locale': 'nl_NL'},
    {'code': 'pt', 'name': 'Portuguese', 'locale': 'pt_PT'},
    {'code': 'ru', 'name': 'Russian', 'locale': 'ru_RU'},
    {'code': 'th', 'name': 'Thai', 'locale': 'th_TH'},
    {'code': 'vi', 'name': 'Vietnamese', 'locale': 'vi_VN'},
    {'code': 'zh', 'name': 'Chinese (Simplified)', 'locale': 'zh_CN'},
  ];

  final currentLanguage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Load current language
    selectedLanguage.load();
    currentLanguage.value = selectedLanguage.$ ?? 'en';
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // Account Settings Actions
  void openAccountLogin() {
    AppWidgets().getSnackBar(
      title: 'Account Login'.tr,
      message: 'Redirecting to login settings...'.tr,
    );
    // Navigate to login settings
  }

  void openPrivacyNotifications() {
    AppWidgets().getSnackBar(
      title: 'Privacy & Notifications'.tr,
      message: 'Opening privacy settings...'.tr,
    );
    // Navigate to privacy settings
  }

  void openLanguageSettings() {
    _showLanguageSelectionDialog();
  }

  void _showLanguageSelectionDialog() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          constraints: BoxConstraints(
            maxHeight: Get.height * 0.7,
            maxWidth: Get.width * 0.9,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.primaryAccentColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(Icons.language, color: Colors.white, size: 24),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Select Language'.tr,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(Icons.close, color: Colors.white),
                    ),
                  ],
                ),
              ),

              // Language list
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: availableLanguages.length,
                  itemBuilder: (context, index) {
                    final language = availableLanguages[index];

                    return Obx(() {
                      final isSelected =
                          currentLanguage.value == language['code'];

                      return ListTile(
                        leading: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFF0D47A1).withOpacity(0.1)
                                : Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              language['code']!.toUpperCase(),
                              style: TextStyle(
                                color: isSelected
                                    ? const Color(0xFF0D47A1)
                                    : Colors.grey.shade600,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                        title: Text(
                          language['name']!,
                          style: TextStyle(
                            color: isSelected
                                ? const Color(0xFF0D47A1)
                                : Colors.black87,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.normal,
                          ),
                        ),
                        trailing: isSelected
                            ? const Icon(
                                Icons.check_circle,
                                color: Color(0xFF0D47A1),
                              )
                            : null,
                        onTap: () => _changeLanguage(language['code']!),
                      );
                    });
                  },
                ),
              ),

              // Footer
              Container(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Select your preferred language for the app'.tr,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _changeLanguage(String languageCode) {
    currentLanguage.value = languageCode;

    // Save to shared preferences
    selectedLanguage.$ = languageCode;
    selectedLanguage.save();

    // Change app locale immediately
    LocalizationService.changeLocale(languageCode);

    // Close dialog first
    Get.back();

    // Small delay to ensure locale change is processed
    Future.delayed(const Duration(milliseconds: 100), () {
      // Show success message in the new language
      AppWidgets().getSnackBar(
        title: 'Language Changed'.tr,
        message: 'App language has been updated successfully'.tr,
      );
    });
  }

  void openUnitsSettings() {
    AppWidgets().getSnackBar(
      title: 'Units'.tr,
      message: 'Opening measurement units...'.tr,
    );
    // Navigate to units settings
  }

  void openUpdateProfile() {
    AppWidgets().getSnackBar(
      title: 'Update Profile'.tr,
      message: 'Opening profile editor...'.tr,
    );
    // Navigate to profile update
  }

  // Support Actions
  void openFeedback() {
    AppWidgets().getSnackBar(
      title: 'Feedback'.tr,
      message: 'Opening feedback form...'.tr,
    );
    // Navigate to feedback
  }

  void openAboutMediAi() {
    AppWidgets().getSnackBar(
      title: 'About MediAi'.tr,
      message: 'Opening app information...'.tr,
    );
    // Navigate to about page
  }

  void openSafelyInformation() {
    AppWidgets().getSnackBar(
      title: 'Safety Information'.tr,
      message: 'Opening safety guidelines...'.tr,
    );
    // Navigate to safety info
  }

  void openRate() {
    AppWidgets().getSnackBar(
      title: 'Rate App'.tr,
      message: 'Thank you for rating MediAi!'.tr,
    );
    // Open app store rating
  }

  void logout() {
    Get.dialog(
      AlertDialog(
        title: Text('Logout'.tr),
        content: Text('Are you sure you want to logout?'.tr),
        actions: [
          TextButton(onPressed: () => Get.back(), child: Text('Cancel'.tr)),
          ElevatedButton(
            onPressed: () {
              Get.back();
              AppHelper().logout();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text(
              'Logout'.tr,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
