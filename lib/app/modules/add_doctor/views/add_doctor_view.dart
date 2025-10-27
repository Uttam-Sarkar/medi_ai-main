import 'package:clay_containers/clay_containers.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medi/app/core/custom_widgets/global_appbar.dart';
import 'package:medi/app/core/helper/app_widgets.dart';
import 'package:medi/app/core/style/app_colors.dart';
import '../controllers/add_doctor_controller.dart';

class AddDoctorView extends GetView<AddDoctorController> {
  const AddDoctorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: globalAppBar(context, 'Add Doctor'.tr),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            _buildHeaderSection(),
            const SizedBox(height: 24),

            // Basic Information Section
            _buildBasicInformationSection(),
            const SizedBox(height: 24),

            // Specialization Section
            _buildSpecializationSection(),
            const SizedBox(height: 24),

            // Qualifications Section
            _buildQualificationsSection(),
            const SizedBox(height: 24),

            // License Section
            _buildLicenseSection(),
            const SizedBox(height: 24),

            // Phone Number Section
            _buildPhoneNumberSection(),
            const SizedBox(height: 24),

            // Language Selection Section
            _buildLanguageSection(),
            const SizedBox(height: 32),

            // Submit Button
            _buildSubmitButton(),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1E3A8A),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add Doctor',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Introducing our interactive symptom assessment and questioning feature, which leverages AI technology to enhance the information-gathering process.',
                  style: const TextStyle(fontSize: 14, color: Colors.white70),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.person_add, color: Colors.white, size: 32),
          ),
        ],
      ),
    );
  }

  Widget _buildBasicInformationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Basic Information',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryAccentColor,
          ),
        ),
        const SizedBox(height: 16),

        // Full Name
        _buildTextField(
          controller.fullNameController,
          'Full Name *',
          'Enter Full Name',
        ),
        const SizedBox(height: 16),

        // Email Address
        _buildTextFieldWithType(
          controller.emailController,
          'Email Address *',
          'Enter Email',
          TextInputType.emailAddress,
        ),
        const SizedBox(height: 16),

        // Password
        Obx(() => _buildPasswordField()),
      ],
    );
  }

  Widget _buildSpecializationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Specialization*',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),

        // Main Specialization Pills
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: controller.mainSpecializations.map((specialization) {
            return _buildMainCategoryPill(specialization);
          }).toList(),
        ),

        const SizedBox(height: 24),

        // Sub-specializations for selected main categories - Made reactive with Obx
        Obx(() {
          return Column(
            children: controller.selectedMainCategories.map((mainCategory) {
              if (controller.subSpecializations.containsKey(mainCategory)) {
                return _buildSubSpecializationSection(mainCategory);
              }
              return const SizedBox.shrink();
            }).toList(),
          );
        }),

        const SizedBox(height: 16),

        // Selected Specializations Display
        Obx(() {
          if (controller.selectedSpecializationsCount > 0) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Selected specialties: (${controller.selectedSpecializationsCount})',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: controller.selectedSpecializations
                      .map(
                        (specialization) =>
                            _buildSelectedSpecializationChip(specialization),
                      )
                      .toList(),
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        }),
      ],
    );
  }

  Widget _buildMainCategoryPill(String category) {
    return Obx(() {
      final isSelected = controller.selectedMainCategories.contains(category);
      final subCount = controller.getSubSpecializationCount(category);

      return GestureDetector(
        onTap: () => controller.selectMainCategory(category),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFF3B82F6)
                : const Color(0xFFF3F4F6),
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: isSelected
                  ? const Color(0xFF3B82F6)
                  : const Color(0xFFD1D5DB),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                category,
                style: TextStyle(
                  color: isSelected ? Colors.white : const Color(0xFF374151),
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
              if (subCount > 0) ...[
                const SizedBox(width: 6),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    subCount.toString(),
                    style: const TextStyle(
                      color: Color(0xFF3B82F6),
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      );
    });
  }

  Widget _buildSubSpecializationSection(String mainCategory) {
    final subSpecs = controller.subSpecializations[mainCategory]!;
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            mainCategory,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: subSpecs.take((subSpecs.length / 2).ceil()).map((
                    subSpec,
                  ) {
                    return _buildSubSpecializationCheckbox(subSpec);
                  }).toList(),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  children: subSpecs.skip((subSpecs.length / 2).ceil()).map((
                    subSpec,
                  ) {
                    return _buildSubSpecializationCheckbox(subSpec);
                  }).toList(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSubSpecializationCheckbox(String specialization) {
    return Obx(() {
      final isSelected = controller.selectedSpecializations.contains(
        specialization,
      );

      return Container(
        margin: const EdgeInsets.only(bottom: 8),
        child: CheckboxListTile(
          title: Text(
            specialization,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF374151),
              fontWeight: FontWeight.w500,
            ),
          ),
          value: isSelected,
          onChanged: (value) => controller.selectSpecialization(specialization),
          activeColor: const Color(0xFF3B82F6),
          checkColor: Colors.white,
          controlAffinity: ListTileControlAffinity.leading,
          contentPadding: EdgeInsets.zero,
          dense: true,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
      );
    });
  }

  Widget _buildSelectedSpecializationChip(String specialization) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF3B82F6),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            specialization,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 4),
          GestureDetector(
            onTap: () =>
                controller.removeSelectedSpecialization(specialization),
            child: const Icon(Icons.close, color: Colors.white, size: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildQualificationsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Qualifications',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryAccentColor,
          ),
        ),
        const SizedBox(height: 16),
        _buildDropdownField(
          controller.selectedQualifications,
          controller.qualifications,
          'Qualifications *',
          'Select an option',
        ),
      ],
    );
  }

  Widget _buildLicenseSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'License',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryAccentColor,
          ),
        ),
        const SizedBox(height: 16),
        _buildTextField(
          controller.licenseController,
          'License *',
          'Enter License',
        ),
      ],
    );
  }

  Widget _buildPhoneNumberSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Phone Number',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryAccentColor,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            ClayContainer(
              depth: 16,
              spread: 2,
              color: AppColors.primaryColor,
              borderRadius: 8,
              child: CountryCodePicker(
                onChanged: (country) =>
                    controller.countryCode.value = country.dialCode ?? '',
                initialSelection: controller.countryCode.value.isNotEmpty
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
                depth: 16,
                spread: 2,
                color: AppColors.primaryColor,
                borderRadius: 8,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: TextField(
                    controller: controller.phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: 'Phone Number *',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 12),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLanguageSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Doctor Account Language',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryAccentColor,
          ),
        ),
        const SizedBox(height: 16),
        _buildDropdownField(
          controller.selectedLanguage,
          controller.languages,
          'Select Doctor Account Language *',
          'Select an option',
        ),
      ],
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    String hint,
  ) {
    return ClayContainer(
      depth: 16,
      spread: 2,
      color: AppColors.primaryColor,
      borderRadius: 8,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            hintText: hint,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFieldWithType(
    TextEditingController controller,
    String label,
    String hint,
    TextInputType keyboardType,
  ) {
    return ClayContainer(
      depth: 16,
      spread: 2,
      color: AppColors.primaryColor,
      borderRadius: 8,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: TextField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            labelText: label,
            hintText: hint,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    return ClayContainer(
      depth: 16,
      spread: 2,
      color: AppColors.primaryColor,
      borderRadius: 8,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: TextField(
          controller: controller.passwordController,
          obscureText: !controller.isPasswordVisible.value,
          decoration: InputDecoration(
            labelText: 'Password *',
            hintText: 'Enter Password',
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
            suffixIcon: IconButton(
              icon: Icon(
                controller.isPasswordVisible.value
                    ? Icons.visibility
                    : Icons.visibility_off,
                color: AppColors.primaryAccentColor,
              ),
              onPressed: controller.togglePasswordVisibility,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownField(
    RxString selectedValue,
    List<String> options,
    String label,
    String hint,
  ) {
    return ClayContainer(
      depth: 16,
      spread: 2,
      color: AppColors.primaryColor,
      borderRadius: 8,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Obx(
          () => DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedValue.value.isEmpty ? null : selectedValue.value,
              hint: Text(hint),
              isExpanded: true,
              items: options.map((String option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(option),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  selectedValue.value = newValue;
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: controller.submitDoctorRegistration,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryAccentColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 0,
        ),
        child: Text(
          'Register Doctor'.tr,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
