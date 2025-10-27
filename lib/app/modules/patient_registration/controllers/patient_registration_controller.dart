import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:image_picker/image_picker.dart';
import 'package:medi/app/core/helper/app_widgets.dart';
import 'package:medi/app/core/helper/auth_helper.dart';
import 'package:medi/app/core/helper/print_log.dart';
import 'package:medi/app/data/remote/repository/auth/auth_repository.dart';
import 'package:medi/app/routes/app_pages.dart';
import '../../../core/helper/app_helper.dart';
import '../model/vaccination_entry.dart';
import '../model/emergency_contact_entry.dart';
import 'package:medi/app/data/remote/model/auth/request/patient_details_request.dart';
import 'dart:convert';

class PatientRegistrationController extends GetxController {
  final pageController = PageController();

  // Page 1
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var isPasswordVisible = false.obs;
  var countryCode = '+1'.obs;

  // Page 2
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final dobController = TextEditingController();
  final ageController = TextEditingController();
  var gender = ''.obs;
  var bloodType = ''.obs;
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final countryController = TextEditingController();
  final prefectureController = TextEditingController();
  final address1Controller = TextEditingController();
  final address2Controller = TextEditingController();
  final cityController = TextEditingController();
  final postalCodeController = TextEditingController();

  // Page 3: Medical dropdowns
  var currentMedicalCondition = ''.obs;
  var diagnosedCondition = <String>[].obs;
  var surgicalHistory = <String>[].obs;
  var allergies = <String>[].obs;
  var underMedication = ''.obs;
  var medicationTypes = <String>[].obs;

  // Page 4: Vaccination entries
  RxList<VaccinationEntry> vaccinations = <VaccinationEntry>[
    VaccinationEntry(),
  ].obs;

  void addVaccinationEntry() {
    vaccinations.add(VaccinationEntry());
    update();
  }

  void removeVaccinationEntry(int index) {
    if (index > 0) {
      vaccinations.removeAt(index);
      update();
    }
  }

  Future<void> pickVaccinationDate(int index) async {
    DateTime? picked = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      vaccinations[index].date.value = picked;
      update();
    }
  }

  // Page 5: Emergency contacts
  RxList<EmergencyContactEntry> emergencyContacts = <EmergencyContactEntry>[
    EmergencyContactEntry(),
  ].obs;

  void addEmergencyContactEntry() {
    emergencyContacts.add(EmergencyContactEntry());
    update();
  }

  void removeEmergencyContactEntry(int index) {
    if (index > 0) {
      emergencyContacts.removeAt(index);
      update();
    }
  }

  // Page 6: Lifestyle and preferences

  final smokingHabits = ''.obs;
  final alcoholConsumption = ''.obs;
  final physicalActivity = ''.obs;
  final preferences = ''.obs;

  // Page 7: Image upload

  final uploadedImages = <XFile>[].obs;

  Future<void> pickImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> images = await picker.pickMultiImage();
    uploadedImages.addAll(images);
  }

  void removeImage(int index) {
    uploadedImages.removeAt(index);
  }

  // Navigation

  Future<void> registerUser() async {
    if (phoneController.value.text.isEmpty) {
      AppWidgets().getSnackBar(
        title: 'Info'.tr,
        message:
            'Phone number is '
                    'required'
                .tr,
      );
      return;
    }

    if (emailController.value.text.isEmpty) {
      AppWidgets().getSnackBar(
        title: 'Info'.tr,
        message: 'Email is required'.tr,
      );
      return;
    }

    if (passwordController.value.text.isEmpty) {
      AppWidgets().getSnackBar(
        title: 'Info'.tr,
        message:
            'Password is '
                    'required'
                .tr,
      );
      return;
    }
    var response = await AuthRepository().getRegister(
      phoneController.text,
      emailController.text,
      passwordController.text,
      "patient",
    );
    if (response.success == true) {
      goToNextPage();
    } else {
      AppWidgets().getSnackBar(
        title: 'Error'.tr,
        message: response.message?.tr ?? 'Registration failed'.tr,
      );
    }
  }

  void goToNextPage() {
    pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    update();
  }

  void goToPreviousPage() {
    pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    update();
  }

  void pickDateOfBirth() async {
    DateTime? picked = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime(2000, 1, 1),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      dobController.text =
          '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
      final now = DateTime.now();
      int age = now.year - picked.year;
      if (now.month < picked.month ||
          (now.month == picked.month && now.day < picked.day)) {
        age--;
      }
      ageController.text = age.toString();
      update();
    }
  }

  PatientDetailsRequest createUserDetailsRequest() {
    // Create personal details
    final personalDetails = PersonalDetails(
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      email: emailController.text,
      language: "en",
      dateOfBirth: dobController.text.isNotEmpty
          ? DateTime.parse(dobController.text)
          : null,
      age: ageController.text,
      gender: gender.value,
      country: countryController.text,
      state: prefectureController.text,
      address1: address1Controller.text,
      address2: address2Controller.text,
      bloodType: bloodType.value,
      city: cityController.text,
      postalCode: postalCodeController.text,
      passportNumber: "",
      // Add a controller if needed
      height: heightController.text,
      weight: weightController.text,
    );

    // Create travel details
    final travelDetails = TravelDetails(
      pregnant: "",
      nursing: "",
      medication: "",
      daysAgoArrived: "",
      daysStay: "",
      arriveFrom: "",
      visitedCountries: "",
      symptomsStart: "",
      medicalInsurance: "",
      medicalFee: "",
      travelReason: "",
      dateOfTravel: "",
      travelLocation: "",
    );

    // Create medical history
    final medicalHistory = MedicalHistory(
      medicalCondition: currentMedicalCondition.value,
      sicknessHistory: diagnosedCondition,
      surgicalHistory: surgicalHistory,
      allergy: allergies,
      medication: underMedication.value,
      medicationTypes: medicationTypes,
      customInputMedications: [],
    );

    // Create vaccine history
    final vaccineEntries = vaccinations
        .map(
          (vaccine) => ImmunizationHistory(
            vaccines: vaccine.vaccineType.value,
            dateOfVaccine: vaccine.date.value,
            hasReceivedCovidVaccine: "",
            dosesReceived: "",
            timeSinceLastVaccination: "",
          ),
        )
        .toList();

    final vaccineHistory = VaccineHistory(immunizationHistory: vaccineEntries);

    // Create emergency contacts
    final emergencyContactsList = emergencyContacts
        .map(
          (contact) => EmergencyContact(
            nameOfEmergencyContact: contact.nameController.text,
            phoneNumber: contact.phoneController.text,
            relationship: contact.relationship.value,
            email: contact.emailController.text,
            mediaiId: contact.mediAiIdController.text,
          ),
        )
        .toList();

    // Create lifestyle factors
    final lifestyleFactors = LifestyleFactors(
      smokingHabits: smokingHabits.value,
      alcoholConsumptions: alcoholConsumption.value,
      physicalActivityLevel: physicalActivity.value,
      preferences: preferences.value,
    );

    // Create upload documents
    final uploadDocuments = uploadedImages
        .map((_) => UploadDocument())
        .toList();

    // Create updated fields
    final updatedFields = UpdatedFields(
      personalDetails: personalDetails,
      travelDetails: travelDetails,
      medicalHistory: medicalHistory,
      vaccineHistory: vaccineHistory,
      emergencyContacts: emergencyContactsList,
      lifestyleFactors: lifestyleFactors,
      uploadDocuments: uploadDocuments,
    );

    // Create and return the final request object
    return PatientDetailsRequest(
      email: emailController.text,
      updatedFields: updatedFields,
    );
  }

  // Add this method to get the JSON representation
  String getUserDetailsJson() {
    final request = createUserDetailsRequest();
    return jsonEncode(request.toJson());
  }

  // Add this method to upload files before registration
  Future<List<String>> uploadFiles() async {
    List<String> uploadedFileUrls = [];

    if (uploadedImages.isEmpty) {
      return uploadedFileUrls;
    }

    try {
      // Create FormData for multipart request
      var formData = FormData();

      // Add email to form data
      formData.fields.add(MapEntry('email', emailController.text));

      // Add files to form data
      for (int i = 0; i < uploadedImages.length; i++) {
        final file = await MultipartFile.fromFile(
          uploadedImages[i].path,
          filename: uploadedImages[i].name,
        );
        formData.files.add(MapEntry('file', file));
      }

      // Create Dio instance with custom configuration for file upload
      final dio = Dio();
      dio.options.headers["Accept"] = "application/json, text/plain, */*";
      dio.options.headers["Accept-Language"] = "en-GB,en-US;q=0.9,en;q=0.8";
      dio.options.headers["Authorization"] = "Basic bWVkaWFpLVkmQTpEZXY3Nzg5";
      dio.options.headers["Cache-Control"] = "no-cache";
      dio.options.headers["Connection"] = "keep-alive";
      dio.options.headers["Pragma"] = "no-cache";
      dio.options.headers["Origin"] = "https://mediai.tech";
      dio.options.headers["Referer"] = "https://mediai.tech/signup";
      dio.options.headers["Sec-Fetch-Dest"] = "empty";
      dio.options.headers["Sec-Fetch-Mode"] = "cors";
      dio.options.headers["Sec-Fetch-Site"] = "same-origin";
      dio.options.headers["User-Agent"] =
          "Mozilla/5.0 (X11; Linux aarch64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 CrKey/1.54.250320";

      // Make the API call
      final response = await dio.post(
        'https://mediai.tech/api/users/upload-many-files',
        data: formData,
      );

      // Process response
      if (response.statusCode == 200) {
        // Extract file URLs from response if available
        if (response.data is Map && response.data['fileUrls'] is List) {
          uploadedFileUrls = List<String>.from(response.data['fileUrls']);
        }
        printLog("Files uploaded successfully: $uploadedFileUrls");
      } else {
        printLog("File upload failed with status: ${response.statusCode}");
      }
    } catch (e) {
      printLog("Error uploading files: $e");
    }

    return uploadedFileUrls;
  }

  // Update the submitRegistration method to upload files first
  void submitRegistration() async {
    // Show loader
    AppHelper().showLoader();

    try {
      // First upload files
      List<String> fileUrls = await uploadFiles();

      // Create user details request
      final userDetailsRequest = createUserDetailsRequest();

      // Update upload documents with file URLs if available
      if (fileUrls.isNotEmpty && userDetailsRequest.updatedFields != null) {
        userDetailsRequest.updatedFields!.uploadDocuments = fileUrls.map((url) {
          final doc = UploadDocument();
          // Add the URL to the document if needed
          // This depends on how your UploadDocument class is structured
          return doc;
        }).toList();
      }

      printLog(jsonEncode(userDetailsRequest.toJson()));

      // Submit user details
      var response = await AuthRepository().updateUserDetails(
        userDetailsRequest,
      );
      if (response.success == true) {
        login();

        // Get.toNamed(Routes.HOME);
        // Get.snackbar('Success'.tr, 'Registration submitted!'.tr);
      } else {
        AppWidgets().getSnackBar(
          title: 'Error'.tr,
          message: response.message?.tr ?? 'Registration failed'.tr,
        );
      }
    } catch (e) {
      printLog("Error during registration: $e");
      AppWidgets().getSnackBar(
        title: 'Error'.tr,
        message: 'Registration failed: $e'.tr,
      );
    } finally {
      // Hide loader
      AppHelper().hideLoader();
    }
  }

  void login() async {
    // Email login
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(email)) {
      AppWidgets().getSnackBar(title: "Error", message: "Invalid email format");
      return;
    }
    var response = await AuthRepository().getSignIn(email, password);
    if (response.success == true) {
      await AuthHelper().setUserData(
        response,
        DateTime.now().toIso8601String(),
      );

      AppWidgets().getSnackBar(title: "Success", message: response.message);
      Get.offAllNamed(Routes.HOME);
    } else {
      AppWidgets().getSnackBar(title: "Info", message: '${response.message}');
    }
  }
}
