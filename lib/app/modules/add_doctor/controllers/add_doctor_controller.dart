import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:medi/app/data/remote/repository/doctor/doctor_repository.dart';
import 'package:medi/app/core/helper/shared_value_helper.dart';

class AddDoctorController extends GetxController {
  // Text Controllers
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final licenseController = TextEditingController();
  final phoneController = TextEditingController();

  // Observable variables
  var isPasswordVisible = false.obs;
  var countryCode = '+1'.obs;
  var selectedQualifications = ''.obs;
  var selectedLanguage = ''.obs;

  // Specialization management
  var selectedMainCategories = <String>[].obs; // Selected main categories
  var selectedSpecializations =
      <String>[].obs; // Selected sub-categories as specialities

  // Main specializations
  final List<String> mainSpecializations = [
    'Internal Medicine',
    'Surgical System',
    'Pediatrics',
    'Obstetrics',
    'Ophthalmology',
    'Dermatology',
    'Psychiatry',
    'Dental System',
    'Other Surgery',
  ];

  // Sub-specializations for each main category
  final Map<String, List<String>> subSpecializations = {
    'Internal Medicine': [
      'Internal Medicine',
      'Respiratory Department',
      'Gastroenterology',
      'Tracheoesophageal Department',
      'Gastrointestinal Medicine',
      'Diabetes Internal Medicine',
      'Chinese Medicine Medicine',
      'Neurology',
      'Department of Gastroenterology',
      'Cardiology',
      'Respiratory Medicine',
      'Nephrology',
      'Artificial Dialysis Internal Medicine',
    ],
    'Surgical System': [
      'General Surgery',
      'Cardiovascular Surgery',
      'Neurosurgery',
      'Orthopedic Surgery',
      'Plastic Surgery',
      'Urological Surgery',
      'Thoracic Surgery',
      'Vascular Surgery',
      'Pediatric Surgery',
    ],
    'Pediatrics': [
      'General Pediatrics',
      'Pediatric Cardiology',
      'Pediatric Neurology',
      'Pediatric Surgery',
      'Pediatric Emergency Medicine',
      'Neonatology',
      'Pediatric Oncology',
      'Pediatric Endocrinology',
    ],
    'Obstetrics': [
      'Obstetrics and Gynecology',
      'Maternal-Fetal Medicine',
      'Reproductive Endocrinology',
      'Gynecologic Oncology',
      'Urogynecology',
      'Family Planning',
    ],
    'Ophthalmology': [
      'General Ophthalmology',
      'Retina Specialist',
      'Cornea Specialist',
      'Glaucoma Specialist',
      'Pediatric Ophthalmology',
      'Oculoplastic Surgery',
      'Neuro-Ophthalmology',
    ],
    'Dermatology': [
      'General Dermatology',
      'Dermatopathology',
      'Pediatric Dermatology',
      'Cosmetic Dermatology',
      'Mohs Surgery',
      'Dermatologic Surgery',
    ],
    'Psychiatry': [
      'General Psychiatry',
      'Child and Adolescent Psychiatry',
      'Geriatric Psychiatry',
      'Addiction Psychiatry',
      'Forensic Psychiatry',
      'Psychosomatic Medicine',
    ],
    'Dental System': [
      'General Dentistry',
      'Oral and Maxillofacial Surgery',
      'Orthodontics',
      'Periodontics',
      'Endodontics',
      'Prosthodontics',
      'Pediatric Dentistry',
    ],
    'Other Surgery': [
      'ENT (Ear, Nose, Throat)',
      'Urology',
      'Anesthesiology',
      'Radiology',
      'Pathology',
      'Emergency Medicine',
      'Family Medicine',
    ],
  };

  // Qualifications options
  final List<String> qualifications = [
    'MD (Doctor of Medicine)',
    'DO (Doctor of Osteopathic Medicine)',
    'MBBS (Bachelor of Medicine, Bachelor of Surgery)',
    'MBChB (Bachelor of Medicine and Bachelor of Surgery)',
    'PhD in Medicine',
    'Specialist Certificate',
    'Board Certified',
  ];

  // Language options
  final List<String> languages = [
    'English',
    'Spanish',
    'French',
    'German',
    'Italian',
    'Portuguese',
    'Chinese',
    'Japanese',
    'Korean',
    'Arabic',
    'Hindi',
    'Russian',
  ];

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    licenseController.dispose();
    phoneController.dispose();
    super.onClose();
  }

  // Toggle password visibility
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  // Select/deselect main category
  void selectMainCategory(String category) {
    if (selectedMainCategories.contains(category)) {
      selectedMainCategories.remove(category);
      // Remove all sub-categories of this main category when deselected
      if (subSpecializations.containsKey(category)) {
        for (String subSpec in subSpecializations[category]!) {
          selectedSpecializations.remove(subSpec);
        }
      }
    } else {
      selectedMainCategories.add(category);
    }
  }

  // Select/deselect sub-category as specialization
  void selectSpecialization(String specialization) {
    if (selectedSpecializations.contains(specialization)) {
      selectedSpecializations.remove(specialization);
    } else {
      selectedSpecializations.add(specialization);
    }
  }

  // Remove selected specialization
  void removeSelectedSpecialization(String specialization) {
    selectedSpecializations.remove(specialization);
  }

  // Check if main category is selected
  bool isMainCategorySelected(String category) {
    return selectedMainCategories.contains(category);
  }

  // Check if sub-category is selected as specialization
  bool isSpecializationSelected(String specialization) {
    return selectedSpecializations.contains(specialization);
  }

  // Get count of selected sub-specializations for a main category
  int getSubSpecializationCount(String mainCategory) {
    if (!subSpecializations.containsKey(mainCategory)) return 0;

    int count = 0;
    for (String subSpec in subSpecializations[mainCategory]!) {
      if (selectedSpecializations.contains(subSpec)) {
        count++;
      }
    }
    return count;
  }

  // Get total selected specializations count
  int get selectedSpecializationsCount => selectedSpecializations.length;

  // Build request body for doctor registration
  Map<String, dynamic> _buildRequestBody() {
    return {
      "fullName": fullNameController.text.trim(),
      "email": emailController.text.trim(),
      "password": passwordController.text.trim(),
      "specialization": selectedSpecializations.toList(),
      "qualifications": selectedQualifications.value,
      "license": licenseController.text.trim(),
      "phoneNumber": "${countryCode.value}${phoneController.text.trim()}",
      "hospitalName": "",
      "department": "",
      "workingHours": "",
      "bio": "",
      "profilePicture": "",
      "socialMedia": "",
      "languages": selectedLanguage.value,
      "insuranceInfo": "",
      "emergencyContact": "",
      "owner": userId.$,
      "type": "doctor",
      "createdBy": userId.$,
    };
  }

  // Validate form data
  bool _validateForm() {
    if (fullNameController.text.trim().isEmpty) {
      Get.snackbar('Error', 'Please enter full name');
      return false;
    }
    if (emailController.text.trim().isEmpty) {
      Get.snackbar('Error', 'Please enter email address');
      return false;
    }
    if (passwordController.text.trim().isEmpty) {
      Get.snackbar('Error', 'Please enter password');
      return false;
    }
    if (selectedSpecializations.isEmpty) {
      Get.snackbar('Error', 'Please select at least one specialization');
      return false;
    }
    if (selectedQualifications.value.isEmpty) {
      Get.snackbar('Error', 'Please select qualifications');
      return false;
    }
    if (licenseController.text.trim().isEmpty) {
      Get.snackbar('Error', 'Please enter license number');
      return false;
    }
    if (phoneController.text.trim().isEmpty) {
      Get.snackbar('Error', 'Please enter phone number');
      return false;
    }
    if (selectedLanguage.value.isEmpty) {
      Get.snackbar('Error', 'Please select language');
      return false;
    }
    return true;
  }

  // Submit doctor registration
  Future<void> submitDoctorRegistration() async {
    try {
      // Validate form
      if (!_validateForm()) {
        return;
      }

      // Build request body
      final body = _buildRequestBody();

      // Show loading
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );

      // Make API call
      await DoctorRepository().createDoctor(body);

      // Hide loading
      Get.back();

      Get.snackbar(
        'Success',
        'Doctor registration submitted successfully!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      // Clear form
      _clearForm();

      // Navigate back
      Get.back();
    } catch (e) {
      // Hide loading if still showing
      if (Get.isDialogOpen == true) {
        Get.back();
      }

      Get.snackbar(
        'Error',
        'Registration failed: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // Clear form data
  void _clearForm() {
    fullNameController.clear();
    emailController.clear();
    passwordController.clear();
    licenseController.clear();
    phoneController.clear();
    selectedMainCategories.clear();
    selectedSpecializations.clear();
    selectedQualifications.value = '';
    selectedLanguage.value = '';
    countryCode.value = '+1';
    isPasswordVisible.value = false;
  }
}
