import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  Widget _buildSettingsSection({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              title.tr,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0D47A1),
              ),
            ),
          ),
          ...children,
        ],
      ),
    );
  }

  Widget _buildSettingsItem({
    required String title,
    required VoidCallback onTap,
    IconData? icon,
    bool isLast = false,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          border: isLast
              ? null
              : Border(
                  bottom: BorderSide(color: Colors.grey.shade200, width: 1),
                ),
        ),
        child: Row(
          children: [
            if (icon != null) ...[
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: Colors.blue[600], size: 20),
              ),
              const SizedBox(width: 16),
            ],
            Expanded(
              child: Text(
                title.tr,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.grey[400], size: 16),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFE),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        shadowColor: Colors.grey.shade300,
        surfaceTintColor: Colors.transparent,
        leading: InkWell(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF0D47A1)),
        ),
        title: Row(
          children: [
            Text(
              'Settings'.tr,
              style: const TextStyle(
                color: Color(0xFF0D47A1),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Account Settings Section
            _buildSettingsSection(
              title: 'Account Setting'.tr,
              children: [
                _buildSettingsItem(
                  title: 'Account Login'.tr,
                  icon: Icons.login,
                  onTap: controller.openAccountLogin,
                ),
                _buildSettingsItem(
                  title: 'Privacy and Notifications'.tr,
                  icon: Icons.privacy_tip_outlined,
                  onTap: controller.openPrivacyNotifications,
                ),
                _buildSettingsItem(
                  title: 'Language'.tr,
                  icon: Icons.language,
                  onTap: controller.openLanguageSettings,
                ),
                _buildSettingsItem(
                  title: 'Units'.tr,
                  icon: Icons.straighten,
                  onTap: controller.openUnitsSettings,
                ),
                _buildSettingsItem(
                  title: 'Update Profile'.tr,
                  icon: Icons.person_outline,
                  onTap: controller.openUpdateProfile,
                  isLast: true,
                ),
              ],
            ),

            // Support Section
            _buildSettingsSection(
              title: 'Support'.tr,
              children: [
                _buildSettingsItem(
                  title: 'Feedback'.tr,
                  icon: Icons.feedback_outlined,
                  onTap: controller.openFeedback,
                ),
                _buildSettingsItem(
                  title: 'About MediAi'.tr,
                  icon: Icons.info_outline,
                  onTap: controller.openAboutMediAi,
                ),
                _buildSettingsItem(
                  title: 'Safety Information'.tr,
                  icon: Icons.security,
                  onTap: controller.openSafelyInformation,
                ),
                _buildSettingsItem(
                  title: 'Rate'.tr,
                  icon: Icons.star_outline,
                  onTap: controller.openRate,
                  isLast: true,
                ),
              ],
            ),

            const SizedBox(height: 40),

            // App Version Info
            Center(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Icon(
                      Icons.medical_services,
                      color: Colors.blue[600],
                      size: 32,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'MediAi'.tr,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0D47A1),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Version 1.0.0',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Your healthcare companion'.tr,
                    style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
