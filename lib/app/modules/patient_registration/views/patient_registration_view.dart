import 'dart:io';
import 'package:clay_containers/widgets/clay_container.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medi/app/core/helper/app_widgets.dart';
import 'package:multiselect/multiselect.dart';
import '../../../core/style/app_colors.dart';
import '../controllers/patient_registration_controller.dart';

class PatientRegistrationView extends GetView<PatientRegistrationController> {
  const PatientRegistrationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Container(
          width: Get.width / 1.10,
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: GetBuilder<PatientRegistrationController>(
            builder: (controller) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: PageView(
                    controller: controller.pageController,
                    physics: NeverScrollableScrollPhysics(),
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
                            SizedBox(height: 24),
                            Row(
                              children: [
                                ClayContainer(
                                  depth: 16,
                                  spread: 2,
                                  color: AppColors.primaryColor,
                                  borderRadius: 8,
                                  child: CountryCodePicker(
                                    onChanged: (country) =>
                                        controller.countryCode.value =
                                            country.dialCode ?? '',
                                    initialSelection:
                                        controller.countryCode.value.isNotEmpty
                                        ? controller.countryCode.value
                                        : '+1',
                                    favorite: ['+1', '+88'],
                                    showCountryOnly: false,
                                    showOnlyCountryWhenClosed: false,
                                    alignLeft: false,
                                    textStyle: TextStyle(color: Colors.black),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 12,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                  child: ClayContainer(
                                    depth: 16,
                                    spread: 2,
                                    color: AppColors.primaryColor,
                                    borderRadius: 8,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
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
                            SizedBox(height: 16),
                            ClayContainer(
                              depth: 16,
                              spread: 2,
                              color: AppColors.primaryColor,
                              borderRadius: 8,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 2),
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
                            SizedBox(height: 16),
                            Obx(
                              () => ClayContainer(
                                depth: 16,
                                spread: 2,
                                color: AppColors.primaryColor,
                                borderRadius: 8,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2),
                                  child: TextField(
                                    controller: controller.passwordController,
                                    obscureText:
                                        !controller.isPasswordVisible.value,
                                    decoration: InputDecoration(
                                      labelText: 'Password'.tr,
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.symmetric(
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
                                              !controller
                                                  .isPasswordVisible
                                                  .value;
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 32),
                            SizedBox(
                              width: double.infinity,
                              height: 45,
                              child: ElevatedButton(
                                onPressed: () {
                                    controller.registerUser();
                                },
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
                      // Page 2: Personal & Address Details
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            ClayContainer(
                              depth: 16,
                              spread: 2,
                              color: AppColors.primaryColor,
                              borderRadius: 60,
                              child: SizedBox(
                                width: 100,
                                height: 100,
                                child: Icon(
                                  Icons.assignment_ind,
                                  size: 48,
                                  color: AppColors.primaryAccentColor,
                                ),
                              ),
                            ),
                            SizedBox(height: 24),
                            Row(
                              children: [
                                Expanded(
                                  child: ClayContainer(
                                    depth: 16,
                                    spread: 2,
                                    color: AppColors.primaryColor,
                                    borderRadius: 8,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 2,
                                      ),
                                      child: TextField(
                                        controller:
                                            controller.firstNameController,
                                        decoration: InputDecoration(
                                          labelText: 'First Name'.tr,
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.symmetric(
                                            horizontal: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                  child: ClayContainer(
                                    depth: 16,
                                    spread: 2,
                                    color: AppColors.primaryColor,
                                    borderRadius: 8,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 2,
                                      ),
                                      child: TextField(
                                        controller:
                                            controller.lastNameController,
                                        decoration: InputDecoration(
                                          labelText: 'Last Name'.tr,
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
                            SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: ClayContainer(
                                    depth: 16,
                                    spread: 2,
                                    color: AppColors.primaryColor,
                                    borderRadius: 8,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 2,
                                      ),
                                      child: TextField(
                                        controller: controller.dobController,
                                        readOnly: true,
                                        onTap: controller.pickDateOfBirth,
                                        decoration: InputDecoration(
                                          labelText: 'Date of Birth'.tr,
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.symmetric(
                                            horizontal: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                  child: ClayContainer(
                                    depth: 16,
                                    spread: 2,
                                    color: AppColors.primaryColor,
                                    borderRadius: 8,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 2,
                                      ),
                                      child: TextField(
                                        controller: controller.ageController,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          labelText: 'Age'.tr,
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
                            SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: ClayContainer(
                                    depth: 16,
                                    spread: 2,
                                    color: AppColors.primaryColor,
                                    borderRadius: 8,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 2,
                                      ),
                                      child: DropdownButtonFormField<String>(
                                        // initialValue:
                                        //     controller.gender.value.isEmpty
                                        //     ? null
                                        //     : controller.gender.value,
                                        items: ['Male', 'Female']
                                            .map(
                                              (g) => DropdownMenuItem(
                                                value: g,
                                                child: Text(g),
                                              ),
                                            )
                                            .toList(),
                                        onChanged: (val) =>
                                            controller.gender.value = val ?? '',
                                        decoration: InputDecoration(
                                          labelText: 'Gender'.tr,
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.symmetric(
                                            horizontal: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                  child: ClayContainer(
                                    depth: 16,
                                    spread: 2,
                                    color: AppColors.primaryColor,
                                    borderRadius: 8,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 2,
                                      ),
                                      child: DropdownButtonFormField<String>(
                                        // initialValue:
                                        //     controller.bloodType.value.isEmpty
                                        //     ? null
                                        //     : controller.bloodType.value,
                                        items:
                                            [
                                                  'A+',
                                                  'A-',
                                                  'B+',
                                                  'B-',
                                                  'AB+',
                                                  'AB-',
                                                  'O+',
                                                  'O-',
                                                  'I\'m not sure',
                                                ]
                                                .map(
                                                  (b) => DropdownMenuItem(
                                                    value: b,
                                                    child: Text(b),
                                                  ),
                                                )
                                                .toList(),
                                        onChanged: (val) =>
                                            controller.bloodType.value =
                                                val ?? '',
                                        decoration: InputDecoration(
                                          labelText: 'Blood Type'.tr,
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
                            SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: ClayContainer(
                                    depth: 16,
                                    spread: 2,
                                    color: AppColors.primaryColor,
                                    borderRadius: 8,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 2,
                                      ),
                                      child: TextField(
                                        controller: controller.heightController,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          labelText: 'Height (cm)'.tr,
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.symmetric(
                                            horizontal: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                  child: ClayContainer(
                                    depth: 16,
                                    spread: 2,
                                    color: AppColors.primaryColor,
                                    borderRadius: 8,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 2,
                                      ),
                                      child: TextField(
                                        controller: controller.weightController,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          labelText: 'Weight (kg)'.tr,
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
                            SizedBox(height: 16),
                            ClayContainer(
                              depth: 16,
                              spread: 2,
                              color: AppColors.primaryColor,
                              borderRadius: 8,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 2),
                                child: TextField(
                                  controller: controller.countryController,
                                  decoration: InputDecoration(
                                    labelText: 'Country of Residence'.tr,
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 16),
                            ClayContainer(
                              depth: 16,
                              spread: 2,
                              color: AppColors.primaryColor,
                              borderRadius: 8,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 2),
                                child: TextField(
                                  controller: controller.prefectureController,
                                  decoration: InputDecoration(
                                    labelText: 'Prefecture'.tr,
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 16),
                            ClayContainer(
                              depth: 16,
                              spread: 2,
                              color: AppColors.primaryColor,
                              borderRadius: 8,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 2),
                                child: TextField(
                                  controller: controller.address1Controller,
                                  decoration: InputDecoration(
                                    labelText: 'Address 1'.tr,
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 16),
                            ClayContainer(
                              depth: 16,
                              spread: 2,
                              color: AppColors.primaryColor,
                              borderRadius: 8,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 2),
                                child: TextField(
                                  controller: controller.address2Controller,
                                  decoration: InputDecoration(
                                    labelText: 'Address 2'.tr,
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: ClayContainer(
                                    depth: 16,
                                    spread: 2,
                                    color: AppColors.primaryColor,
                                    borderRadius: 8,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 2,
                                      ),
                                      child: TextField(
                                        controller: controller.cityController,
                                        decoration: InputDecoration(
                                          labelText: 'City Name'.tr,
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.symmetric(
                                            horizontal: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                  child: ClayContainer(
                                    depth: 16,
                                    spread: 2,
                                    color: AppColors.primaryColor,
                                    borderRadius: 8,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 2,
                                      ),
                                      child: TextField(
                                        controller:
                                            controller.postalCodeController,
                                        decoration: InputDecoration(
                                          labelText: 'Postal Code'.tr,
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
                            SizedBox(height: 32),
                            Row(
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    height: 45,
                                    child: ElevatedButton(
                                      onPressed: controller.goToPreviousPage,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white12,
                                        foregroundColor:
                                            AppColors.primaryAccentColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        elevation: 0,
                                      ),
                                      child: Text('Back'.tr),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  child: SizedBox(
                                    height: 45,
                                    child: ElevatedButton(
                                      onPressed: controller.goToNextPage,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            AppColors.primaryAccentColor,
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        elevation: 0,
                                      ),
                                      child: Text('Next'.tr),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Page 3: Medical Details
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            ClayContainer(
                              depth: 16,
                              spread: 2,
                              color: AppColors.primaryColor,
                              borderRadius: 60,
                              child: SizedBox(
                                width: 100,
                                height: 100,
                                child: Icon(
                                  Icons.medical_services,
                                  size: 48,
                                  color: AppColors.primaryAccentColor,
                                ),
                              ),
                            ),
                            SizedBox(height: 24),
                            ClayContainer(
                              depth: 16,
                              spread: 2,
                              color: AppColors.primaryColor,
                              borderRadius: 8,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 2),
                                child: DropdownButtonFormField<String>(
                                  value:
                                      controller
                                          .currentMedicalCondition
                                          .value
                                          .isEmpty
                                      ? null
                                      : controller
                                            .currentMedicalCondition
                                            .value,
                                  items:
                                      [
                                            'Select an option'.tr,
                                            'Healthy individual'.tr,
                                            'Healthy under medication'.tr,
                                            'Healthy undergoing medical preventive'
                                                .tr,
                                            'Healthy undergoing medical treatment'
                                                .tr,
                                            'Healthy with a medical history'.tr,
                                            'Healthy with disability'.tr,
                                            'Unhealthy individual'.tr,
                                            'Unhealthy undergoing medical treatment'
                                                .tr,
                                          ]
                                          .map(
                                            (c) => DropdownMenuItem(
                                              value: c == 'Select an option'
                                                  ? ''
                                                  : c,
                                              child: Text(c),
                                            ),
                                          )
                                          .toList(),
                                  onChanged: (val) =>
                                      controller.currentMedicalCondition.value =
                                          val ?? '',
                                  decoration: InputDecoration(
                                    labelText:
                                        'What is your current medical condition?'
                                            .tr,
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 16),
                            ClayContainer(
                              depth: 16,
                              spread: 2,
                              color: AppColors.primaryColor,
                              borderRadius: 8,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 2),
                                child: _buildMultiSelectDropdown(
                                  label: 'Please indicate if you have ever been diagnosed with any of the following conditions:'.tr,
                                  options: [
                                    "Never been diagnosed",
                                    "Arrhythmia",
                                    "Asthma",
                                    "Atopic",
                                    "Cancer",
                                    "Cerebral Hemorrhage",
                                    "Cerebral Infarction",
                                    "Diabetes",
                                    "Gout",
                                    "Hay Fever",
                                    "Heart Disease",
                                    "Hepatitis",
                                    "High Blood Pressure",
                                    "HIV",
                                    "Hyperlipidemia",
                                    "Kidney Disease",
                                    "Liver Disease",
                                    "Rheumatism",
                                    "Other",
                                  ],
                                  selectedValues: controller.diagnosedCondition,
                                ),
                              ),
                            ),
                            SizedBox(height: 16),
                            ClayContainer(
                              depth: 16,
                              spread: 2,
                              color: AppColors.primaryColor,
                              borderRadius: 8,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 2),
                                child: _buildMultiSelectDropdown(
                                  label: 'What is your surgical history?'.tr,
                                  options: [
                                    "No Surgical History",
                                    "Cardiovascular Surgery",
                                    "Orthopedic Surgery",
                                    "Oncological Surgery",
                                    "Pediatrics Surgery",
                                    "Vascular Surgery",
                                    "Transplant Surgery",
                                    "Heart Surgery",
                                    "Cosmetic Surgery",
                                    "Other Surgery",
                                  ],
                                  selectedValues: controller.surgicalHistory,
                                ),
                              ),
                            ),
                            SizedBox(height: 16),
                            ClayContainer(
                              depth: 16,
                              spread: 2,
                              color: AppColors.primaryColor,
                              borderRadius: 8,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 2),
                                child: _buildMultiSelectDropdown(
                                  label: 'Allergies'.tr,
                                  options: [
                                    "No Allergy",
                                    "Hay Fever",
                                    "Food Allergies",
                                    "Pet Allergies",
                                    "Drug Allergies",
                                    "Dust Mite Allergy",
                                    "Pollen Allergy",
                                    "Other",
                                  ],
                                  selectedValues: controller.allergies,
                                ),
                              ),
                            ),
                            SizedBox(height: 16),
                            ClayContainer(
                              depth: 16,
                              spread: 2,
                              color: AppColors.primaryColor,
                              borderRadius: 8,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 2),
                                child: DropdownButtonFormField<String>(
                                  value:
                                      controller.underMedication.value.isEmpty
                                      ? null
                                      : controller.underMedication.value,
                                  items:
                                      [
                                            "Not on Medication",
                                            "Occasionally on Medication",
                                            "Currently on Medication",
                                            "On Daily Medication",
                                          ]
                                          .map(
                                            (c) => DropdownMenuItem(
                                              value: c,
                                              child: Text(c),
                                            ),
                                          )
                                          .toList(),
                                  onChanged: (val) {
                                    controller.underMedication.value = val ?? '';
                                    // Clear medication types if "Not on Medication" is selected
                                    if (val == "Not on Medication") {
                                      controller.medicationTypes.clear();
                                    }
                                  },
                                  decoration: InputDecoration(
                                    labelText:
                                        'Are you under any medications?'.tr,
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // Show medication types multi-select if not "Not on Medication"
                            Obx(() {
                              if (controller.underMedication.value.isNotEmpty && 
                                  controller.underMedication.value != "Not on Medication") {
                                return Column(
                                  children: [
                                    SizedBox(height: 16),
                                    ClayContainer(
                                      depth: 16,
                                      spread: 2,
                                      color: AppColors.primaryColor,
                                      borderRadius: 8,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(vertical: 2),
                                        child: _buildMultiSelectDropdown(
                                          label: 'What type of medications are you taking?'.tr,
                                          options: [
                                            "Antibiotics",
                                            "Antipyretics", 
                                            "Antacids and Gastrointestinal Medications",
                                            "Cardiovascular Medications",
                                            "Respiratory Medications",
                                            "Antidepressants and Antianxiety Medications",
                                            "Diabetes Medications",
                                            "Anticoagulants and Antiplatelet Medications",
                                            "Vaccines and Immunizations",
                                          ],
                                          selectedValues: controller.medicationTypes,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }
                              return SizedBox.shrink();
                            }),
                            SizedBox(height: 32),
                            Row(
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    height: 45,
                                    child: ElevatedButton(
                                      onPressed: controller.goToPreviousPage,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white12,
                                        foregroundColor:
                                            AppColors.primaryAccentColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        elevation: 0,
                                      ),
                                      child: Text('Back'.tr),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  child: SizedBox(
                                    height: 45,
                                    child: ElevatedButton(
                                      onPressed: controller.goToNextPage,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            AppColors.primaryAccentColor,
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        elevation: 0,
                                      ),
                                      child: Text('Next'.tr),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Page 4: Vaccination List
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            ClayContainer(
                              depth: 16,
                              spread: 2,
                              color: AppColors.primaryColor,
                              borderRadius: 60,
                              child: SizedBox(
                                width: 100,
                                height: 100,
                                child: Icon(
                                  Icons.vaccines,
                                  size: 48,
                                  color: AppColors.primaryAccentColor,
                                ),
                              ),
                            ),
                            SizedBox(height: 24),
                            Obx(
                              () => Column(
                                children: List.generate(
                                  controller.vaccinations.length,
                                  (index) {
                                    final entry =
                                        controller.vaccinations[index];
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ClayContainer(
                                          depth: 16,
                                          spread: 2,
                                          color: AppColors.primaryColor,
                                          borderRadius: 8,
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 2,
                                            ),
                                            child: DropdownButtonFormField<String>(
                                              value:
                                                  entry
                                                      .vaccineType
                                                      .value
                                                      .isEmpty
                                                  ? null
                                                  : entry.vaccineType.value,
                                              items: ["Yes", "No"]
                                                  .map(
                                                    (c) => DropdownMenuItem(
                                                      value: c,
                                                      child: Text(c),
                                                    ),
                                                  )
                                                  .toList(),
                                              onChanged: (val) =>
                                                  entry.vaccineType.value =
                                                      val ?? '',
                                              decoration: InputDecoration(
                                                labelText:
                                                    'Any vaccinations you might have had in the past 12 Month?'
                                                        .tr,
                                                border: InputBorder.none,
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        ClayContainer(
                                          depth: 16,
                                          spread: 2,
                                          color: AppColors.primaryColor,
                                          borderRadius: 8,
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 2,
                                            ),
                                            child: TextField(
                                              controller:
                                                  entry.vaccineNameController,
                                              decoration: InputDecoration(
                                                labelText: 'Vaccines'.tr,
                                                border: InputBorder.none,
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        ClayContainer(
                                          depth: 16,
                                          spread: 2,
                                          color: AppColors.primaryColor,
                                          borderRadius: 8,
                                          child: ListTile(
                                            title: Text(
                                              entry.date.value == null
                                                  ? 'Select Date'.tr
                                                  : '${entry.date.value!.year}-${entry.date.value!.month.toString().padLeft(2, '0')}-${entry.date.value!.day.toString().padLeft(2, '0')}',
                                            ),
                                            trailing: Icon(
                                              Icons.calendar_today,
                                            ),
                                            onTap: () => controller
                                                .pickVaccinationDate(index),
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            if (index > 0)
                                              IconButton(
                                                icon: Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                ),
                                                onPressed: () => controller
                                                    .removeVaccinationEntry(
                                                      index,
                                                    ),
                                              ),
                                          ],
                                        ),
                                        SizedBox(height: 16),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                ElevatedButton.icon(
                                  onPressed: controller.addVaccinationEntry,
                                  icon: Icon(Icons.add),
                                  label: Text('Add'.tr),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        AppColors.primaryAccentColor,
                                    foregroundColor: Colors.white,
                                    elevation: 0,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 32),
                            Row(
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    height: 45,
                                    child: ElevatedButton(
                                      onPressed: controller.goToPreviousPage,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white12,
                                        foregroundColor:
                                            AppColors.primaryAccentColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        elevation: 0,
                                      ),
                                      child: Text('Back'.tr),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  child: SizedBox(
                                    height: 45,
                                    child: ElevatedButton(
                                      onPressed: controller.goToNextPage,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            AppColors.primaryAccentColor,
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        elevation: 0,
                                      ),
                                      child: Text('Next'.tr),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Page 5: Emergency Contacts
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            ClayContainer(
                              depth: 16,
                              spread: 2,
                              color: AppColors.primaryColor,
                              borderRadius: 60,
                              child: SizedBox(
                                width: 100,
                                height: 100,
                                child: Icon(
                                  Icons.contact_phone,
                                  size: 48,
                                  color: AppColors.primaryAccentColor,
                                ),
                              ),
                            ),
                            SizedBox(height: 24),
                            Obx(
                              () => Column(
                                children: List.generate(
                                  controller.emergencyContacts.length,
                                  (index) {
                                    final entry =
                                        controller.emergencyContacts[index];
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ClayContainer(
                                          depth: 16,
                                          spread: 2,
                                          color: AppColors.primaryColor,
                                          borderRadius: 8,
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 2,
                                            ),
                                            child: TextField(
                                              controller: entry.nameController,
                                              decoration: InputDecoration(
                                                labelText:
                                                    'Name of Emergency Contact'
                                                        .tr,
                                                border: InputBorder.none,
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        ClayContainer(
                                          depth: 16,
                                          spread: 2,
                                          color: AppColors.primaryColor,
                                          borderRadius: 8,
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 2,
                                            ),
                                            child: TextField(
                                              controller: entry.phoneController,
                                              decoration: InputDecoration(
                                                labelText:
                                                    'Phone Number with country code'
                                                        .tr,
                                                border: InputBorder.none,
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        ClayContainer(
                                          depth: 16,
                                          spread: 2,
                                          color: AppColors.primaryColor,
                                          borderRadius: 8,
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 2,
                                            ),
                                            child: Obx(
                                              () =>
                                                  DropdownButtonFormField<
                                                    String
                                                  >(
                                                    value:
                                                        entry
                                                            .relationship
                                                            .value
                                                            .isEmpty
                                                        ? null
                                                        : entry
                                                              .relationship
                                                              .value,
                                                    items:
                                                        [
                                                              'Family'.tr,
                                                              'Friend'.tr,
                                                              'Doctor'.tr,
                                                            ]
                                                            .map(
                                                              (c) =>
                                                                  DropdownMenuItem(
                                                                    value: c,
                                                                    child: Text(
                                                                      c,
                                                                    ),
                                                                  ),
                                                            )
                                                            .toList(),
                                                    onChanged: (val) =>
                                                        entry
                                                                .relationship
                                                                .value =
                                                            val ?? '',
                                                    decoration: InputDecoration(
                                                      labelText:
                                                          'Relationship'.tr,
                                                      border: InputBorder.none,
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                            horizontal: 12,
                                                          ),
                                                    ),
                                                  ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        ClayContainer(
                                          depth: 16,
                                          spread: 2,
                                          color: AppColors.primaryColor,
                                          borderRadius: 8,
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 2,
                                            ),
                                            child: TextField(
                                              controller: entry.emailController,
                                              decoration: InputDecoration(
                                                labelText: 'Email'.tr,
                                                border: InputBorder.none,
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        ClayContainer(
                                          depth: 16,
                                          spread: 2,
                                          color: AppColors.primaryColor,
                                          borderRadius: 8,
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 2,
                                            ),
                                            child: TextField(
                                              controller:
                                                  entry.mediAiIdController,
                                              decoration: InputDecoration(
                                                labelText: 'MediAi ID'.tr,
                                                border: InputBorder.none,
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            if (index > 0)
                                              IconButton(
                                                icon: Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                ),
                                                onPressed: () => controller
                                                    .removeEmergencyContactEntry(
                                                      index,
                                                    ),
                                              ),
                                          ],
                                        ),
                                        SizedBox(height: 16),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                ElevatedButton.icon(
                                  onPressed:
                                      controller.addEmergencyContactEntry,
                                  icon: Icon(Icons.add),
                                  label: Text('Add'.tr),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        AppColors.primaryAccentColor,
                                    foregroundColor: Colors.white,
                                    elevation: 0,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 32),
                            Row(
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    height: 45,
                                    child: ElevatedButton(
                                      onPressed: controller.goToPreviousPage,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white12,
                                        foregroundColor:
                                            AppColors.primaryAccentColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        elevation: 0,
                                      ),
                                      child: Text('Back'.tr),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  child: SizedBox(
                                    height: 45,
                                    child: ElevatedButton(
                                      onPressed: controller.goToNextPage,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            AppColors.primaryAccentColor,
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        elevation: 0,
                                      ),
                                      child: Text('Next'.tr),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Page 6: Lifestyle and Preferences
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            ClayContainer(
                              depth: 16,
                              spread: 2,
                              color: AppColors.primaryColor,
                              borderRadius: 60,
                              child: SizedBox(
                                width: 100,
                                height: 100,
                                child: Icon(
                                  Icons.health_and_safety,
                                  size: 48,
                                  color: AppColors.primaryAccentColor,
                                ),
                              ),
                            ),
                            SizedBox(height: 24),
                            ClayContainer(
                              depth: 16,
                              spread: 2,
                              color: AppColors.primaryColor,
                              borderRadius: 8,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 2),
                                child: DropdownButtonFormField<String>(
                                  value: controller.smokingHabits.value.isEmpty
                                      ? null
                                      : controller.smokingHabits.value,
                                  items: ['Yes', 'No']
                                      .map(
                                        (s) => DropdownMenuItem(
                                          value: s,
                                          child: Text(s),
                                        ),
                                      )
                                      .toList(),
                                  onChanged: (val) =>
                                      controller.smokingHabits.value =
                                          val ?? '',
                                  decoration: InputDecoration(
                                    labelText: 'Smoking Habits'.tr,
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 16),
                            ClayContainer(
                              depth: 16,
                              spread: 2,
                              color: AppColors.primaryColor,
                              borderRadius: 8,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 2),
                                child: DropdownButtonFormField<String>(
                                  value:
                                      controller
                                          .alcoholConsumption
                                          .value
                                          .isEmpty
                                      ? null
                                      : controller.alcoholConsumption.value,
                                  items:
                                      [
                                            "Not drinking",
                                            "Occasionally drinking",
                                            "Frequently drinking",
                                          ]
                                          .map(
                                            (a) => DropdownMenuItem(
                                              value: a,
                                              child: Text(a),
                                            ),
                                          )
                                          .toList(),
                                  onChanged: (val) =>
                                      controller.alcoholConsumption.value =
                                          val ?? '',
                                  decoration: InputDecoration(
                                    labelText: 'Alcohol Consumption'.tr,
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 16),
                            ClayContainer(
                              depth: 16,
                              spread: 2,
                              color: AppColors.primaryColor,
                              borderRadius: 8,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 2),
                                child: DropdownButtonFormField<String>(
                                  value:
                                      controller.physicalActivity.value.isEmpty
                                      ? null
                                      : controller.physicalActivity.value,
                                  items:
                                      [
                                            "Sedentary (little or no exercise)",
                                            "Lightly Active (light exercise or sports 1-3 days a week)",
                                            "Moderately Active (moderate exercise or sports 3-5 days a week)",
                                            "Very Active (hard exercise or sports 6-7 days a week)",
                                            "Super Active (very hard exercise, physical job, or training)",
                                          ]
                                          .map(
                                            (p) => DropdownMenuItem(
                                              value: p,
                                              child: Text(p),
                                            ),
                                          )
                                          .toList(),
                                  onChanged: (val) =>
                                      controller.physicalActivity.value =
                                          val ?? '',
                                  decoration: InputDecoration(
                                    labelText: 'Physical Activity Level'.tr,
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 16),
                            ClayContainer(
                              depth: 16,
                              spread: 2,
                              color: AppColors.primaryColor,
                              borderRadius: 8,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 2),
                                child: DropdownButtonFormField<String>(
                                  value: controller.preferences.value.isEmpty
                                      ? null
                                      : controller.preferences.value,
                                  items:
                                      [
                                            "None (No preferences or restrictions)",
                                            "Vegetarian",
                                            "Vegan",
                                            "Gluten-Free",
                                            "Dairy-Free",
                                            "Nut-Free",
                                            "Other",
                                          ]
                                          .map(
                                            (p) => DropdownMenuItem(
                                              value: p,
                                              child: Text(p),
                                            ),
                                          )
                                          .toList(),
                                  onChanged: (val) =>
                                      controller.preferences.value = val ?? '',
                                  decoration: InputDecoration(
                                    labelText: 'Preferences/Restrictions'.tr,
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 32),
                            Row(
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    height: 45,
                                    child: ElevatedButton(
                                      onPressed: controller.goToPreviousPage,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white12,
                                        foregroundColor:
                                            AppColors.primaryAccentColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        elevation: 0,
                                      ),
                                      child: Text('Back'.tr),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  child: SizedBox(
                                    height: 45,
                                    child: ElevatedButton(
                                      onPressed: controller.goToNextPage,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            AppColors.primaryAccentColor,
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        elevation: 0,
                                      ),
                                      child: Text('Next'.tr),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Page 7: Upload Medical Documents/Images
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            ClayContainer(
                              depth: 16,
                              spread: 2,
                              color: AppColors.primaryColor,
                              borderRadius: 60,
                              child: SizedBox(
                                width: 100,
                                height: 100,
                                child: Icon(
                                  Icons.upload_file,
                                  size: 48,
                                  color: AppColors.primaryAccentColor,
                                ),
                              ),
                            ),
                            SizedBox(height: 24),
                            Padding(
                              padding: EdgeInsets.only(bottom: 16),
                              child: Text(
                                'Upload X-rays, medication images, doctor diagnoses, or any pertinent files related to your health. In emergencies or as needed, these documents can be reviewed by healthcare professionals with your prior permission for more informed and efficient care.'
                                    .tr,
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Obx(
                              () => Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: List.generate(
                                  controller.uploadedImages.length,
                                  (index) => Stack(
                                    alignment: Alignment.topRight,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.file(
                                          File(
                                            controller
                                                .uploadedImages[index]
                                                .path,
                                          ),
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Positioned(
                                        right: 0,
                                        child: GestureDetector(
                                          onTap: () =>
                                              controller.removeImage(index),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.red,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Icon(
                                              Icons.close,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: controller.pickImages,
                                icon: Icon(Icons.add_a_photo),
                                label: Text('Add Images'.tr),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryAccentColor,
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                ),
                              ),
                            ),
                            SizedBox(height: 32),
                            Row(
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    height: 45,
                                    child: ElevatedButton(
                                      onPressed: controller.goToPreviousPage,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white12,
                                        foregroundColor:
                                            AppColors.primaryAccentColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        elevation: 0,
                                      ),
                                      child: Text('Back'.tr),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  child: SizedBox(
                                    height: 45,
                                    child: ElevatedButton(
                                      onPressed: controller.submitRegistration,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            AppColors.primaryAccentColor,
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        elevation: 0,
                                      ),
                                      child: Text('Complete'.tr),
                                    ),
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMultiSelectDropdown({
    required String label,
    required List<String> options,
    required RxList<String> selectedValues,
  }) {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
          DropDownMultiSelect(
            onChanged: (List<String> selectedList) {
              selectedValues.assignAll(selectedList);
            },
            options: options,
            selectedValues: selectedValues.toList(),
            whenEmpty: 'Select options...',
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: AppColors.primaryAccentColor),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            ),
            childBuilder: (selectedList) {
              if (selectedList.isEmpty) {
                return Text(
                  'Select options...',
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 16,
                  ),
                );
              }
              return Wrap(
                spacing: 4,
                runSpacing: 4,
                children: selectedList.map<Widget>((value) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.primaryAccentColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColors.primaryAccentColor.withOpacity(0.3),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          value,
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.primaryAccentColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: 4),
                        GestureDetector(
                          onTap: () {
                            final newValues = List<String>.from(selectedValues);
                            newValues.remove(value);
                            selectedValues.assignAll(newValues);
                          },
                          child: Icon(
                            Icons.close,
                            size: 14,
                            color: AppColors.primaryAccentColor,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ],
      );
    });
  }

}
