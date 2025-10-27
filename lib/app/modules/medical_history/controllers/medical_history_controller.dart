import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:dio/dio.dart' as dio;
import 'package:medi/app/core/helper/print_log.dart';
import 'package:medi/app/core/helper/shared_value_helper.dart';
import 'dart:io';
import 'dart:math';
import '../../../core/service/location_service.dart';
import '../../../core/service/translation_service.dart';
import '../../home/controllers/home_controller.dart';
import '../../../data/remote/model/user/user_data_response.dart';
import '../../../core/helper/app_widgets.dart';

class MedicalHistoryController extends GetxController {
  late HomeController homeController;

  // Upload related variables
  final documentNameController = TextEditingController();
  final selectedFile = Rx<File?>(null);
  final isUploading = false.obs;
  final uploadProgress = 0.0.obs;

  // Translation related variables
  final countryCode = ''.obs;
  final isTranslating = false.obs;
  final translatedData = <String, Map<String, String>>{}.obs;
  final translationProgress = 0.0.obs;
  final currentTranslatingSection = ''.obs;
  final completedSections = <String>[].obs;
  late final bool translateDoc;
  final lat = ''.obs;
  final lon = ''.obs;

  // API Configuration
  final String uploadApiUrl = 'https://mediai.tech/api/users/upload-files';
  @override
  void onInit() {
    super.onInit();
    homeController = Get.find<HomeController>();
    translateDoc = Get.arguments ?? false;
    if (translateDoc) {
      isTranslating.value = true;
      getUserLocationBasedLanguage();
    }
  }

  Future<void> getUserLocationBasedLanguage() async {
    try {
      var location = await getLocation();
      lat.value = location['lat'] ?? '';
      lon.value = location['lon'] ?? '';
      List<Placemark> placemarks = await placemarkFromCoordinates(
        double.parse(lat.toString()),
        double.parse(lon.toString()),
      );
      Placemark place = placemarks.first;
      countryCode.value = place.isoCountryCode?.toString() ?? 'US';
      printLog('Country Code: ${countryCode.value}');

      // Trigger translation if needed and translation is enabled
      if (translateDoc &&
          TranslationService.shouldTranslate(countryCode.value)) {
        await translateMedicalData();
      }
    } catch (e) {
      printLog('Error getting location: $e');
      countryCode.value = 'US'; // Default to US
    }
  }

  /// Translate medical data based on country code
  Future<void> translateMedicalData() async {
    if (currentUser == null ||
        !TranslationService.shouldTranslate(countryCode.value)) {
      return;
    }

    try {
      translationProgress.value = 0.0;
      currentTranslatingSection.value = '';
      completedSections.clear();
      final user = currentUser!;

      // Initialize empty translated data structure
      translatedData.value = {
        'personalDetails': <String, String>{},
        'personalLabels': <String, String>{},
        'addressDetails': <String, String>{},
        'addressLabels': <String, String>{},
        'medicalHistory': <String, String>{},
        'medicalLabels': <String, String>{},
        'lifestyle': <String, String>{},
        'lifestyleLabels': <String, String>{},
        'travelDetails': <String, String>{},
        'travelLabels': <String, String>{},
        'sectionsLabels': <String, String>{},
        'immunizationData': <String, String>{},
        'immunizationLabels': <String, String>{},
        'uiMessages': <String, String>{},
      };

      // First, translate UI status messages
      final uiMessages = {
        'Translating Content': 'Translating Content',
        'Translating': 'Translating',
        'Complete': 'Complete',
        'sections done': 'sections done',
        'Translated to': 'Translated to',
        'Personal Details': 'Personal Details',
        'Address Details': 'Address Details',
        'Medical History': 'Medical History',
        'Lifestyle Factors': 'Lifestyle Factors',
        'Travel Details': 'Travel Details',
        'Immunization History': 'Immunization History',
        'Section Titles': 'Section Titles',
      };

      currentTranslatingSection.value = 'UI Messages';
      translationProgress.value = 0.14; // 1/7 sections
      printLog('Translating UI Messages...');
      final translatedUIMessages = await TranslationService.translateMap(
        uiMessages,
        countryCode.value,
      );

      // Update UI immediately after UI Messages translation
      translatedData.value = {
        ...translatedData.value,
        'uiMessages': translatedUIMessages,
      };
      completedSections.add('UI Messages');
      printLog('UI Messages translation completed - UI updated');

      // Translate Section Titles FIRST (so users see section headers immediately)
      final sectionTitles = {
        'Personal Details': 'Personal Details',
        'Address Details': 'Address Details',
        'Medical History': 'Medical History',
        'Lifestyle Factors': 'Lifestyle Factors',
        'Travel Details': 'Travel Details',
        'Emergency Contacts': 'Emergency Contacts',
        'Immunization History': 'Immunization History',
        'Documents & Forms': 'Documents & Forms',
        'Upload Document': 'Upload Document',
        'Documents': 'Documents',
        'Submitted Forms': 'Submitted Forms',
        'Translated Documents': 'Translated Documents',
        'Your Medical Profile': 'Your Medical Profile',
        'Complete health overview for': 'Complete health overview for',
        'ID': 'ID',
        'No Medical Data Available': 'No Medical Data Available',
        'Please ensure your profile is complete':
            'Please ensure your profile is complete',
        'Go Back': 'Go Back',
        'Document Name': 'Document Name',
        'File Selected': 'File Selected',
        'Click to select file or drag and drop':
            'Click to select file or drag and drop',
        'PDF, DOC, JPG up to 10MB': 'PDF, DOC, JPG up to 10MB',
        'Size': 'Size',
        'Uploading...': 'Uploading...',
        'Cancel': 'Cancel',
        'Upload': 'Upload',
        'document(s) available': 'document(s) available',
        'No documents found': 'No documents found',
        'No forms assigned to this patient':
            'No forms assigned to this patient',
        'No immunization data': 'No immunization data',
        'Available': 'Available',
        'None': 'None',
        'Doses': 'Doses',
      };

      currentTranslatingSection.value = getTranslatedUIMessage(
        'Section Titles',
      );
      translationProgress.value = 0.28; // 2/7 sections
      printLog('Translating Section Titles...');
      final translatedSectionTitles = await TranslationService.translateMap(
        sectionTitles,
        countryCode.value,
      );

      // Update UI immediately with section titles
      translatedData.value = {
        ...translatedData.value,
        'sectionsLabels': translatedSectionTitles,
      };
      completedSections.add('Section Titles');
      currentTranslatingSection.value = '';
      printLog('Section Titles translation completed - UI updated');

      // Now translate Personal Details (both keys and values)
      final personalDetailsData = <String, String>{
        'Name':
            '${user.details?.personalDetails?.firstName ?? ''} ${user.details?.personalDetails?.lastName ?? ''}'
                .trim(),
        'Email': user.email ?? '',
        'Phone': user.phoneNumber ?? '',
        'MediID': user.mediid ?? '',
        'DOB':
            user.details?.personalDetails?.dateOfBirth?.toString().split(
              ' ',
            )[0] ??
            '',
        'Age': user.details?.personalDetails?.age ?? '',
        'Gender': user.details?.personalDetails?.gender ?? '',
        'Blood Type': user.details?.personalDetails?.bloodType ?? '',
        'Height': user.details?.personalDetails?.height ?? '',
        'Weight': user.details?.personalDetails?.weight ?? '',
      };

      // Translate Personal Details Labels
      final personalDetailsLabels = {
        'Name': 'Name',
        'Email': 'Email',
        'Phone': 'Phone',
        'MediID': 'MediID',
        'DOB': 'DOB',
        'Age': 'Age',
        'Gender': 'Gender',
        'Blood Type': 'Blood Type',
        'Height': 'Height',
        'Weight': 'Weight',
        'Relationship': 'Relationship',
      };

      // Add emergency contact data to personal details for translation
      if (user.details?.emergencyContacts != null) {
        for (var contact in user.details!.emergencyContacts!) {
          if (contact.nameOfEmergencyContact != null) {
            personalDetailsData[contact.nameOfEmergencyContact!] =
                contact.nameOfEmergencyContact!;
          }
          if (contact.relationship != null) {
            personalDetailsData['Relationship'] = contact.relationship!;
          }
        }
      }

      // Translate Personal Details progressively
      currentTranslatingSection.value = getTranslatedUIMessage(
        'Personal Details',
      );
      translationProgress.value = 0.42; // 3/7 sections
      printLog('Translating Personal Details...');
      final translatedPersonalDetails = await TranslationService.translateMap(
        personalDetailsData,
        countryCode.value,
      );
      final translatedPersonalLabels = await TranslationService.translateMap(
        personalDetailsLabels,
        countryCode.value,
      );

      // Update UI immediately after Personal Details translation
      translatedData.value = {
        ...translatedData.value,
        'personalDetails': translatedPersonalDetails,
        'personalLabels': translatedPersonalLabels,
      };
      completedSections.add('Personal Details');
      printLog('Personal Details translation completed - UI updated');

      // Translate Address Details
      final addressDetailsData = <String, String>{
        'Address 1': user.details?.personalDetails?.address1 ?? '',
        'Address 2': user.details?.personalDetails?.address2 ?? '',
        'City': user.details?.personalDetails?.city ?? '',
        'State': user.details?.personalDetails?.state ?? '',
        'Country': user.details?.personalDetails?.country ?? '',
        'Postal Code': user.details?.personalDetails?.postalCode ?? '',
        'Passport Number': user.details?.personalDetails?.passportNumber ?? '',
        'Language': user.details?.personalDetails?.language ?? '',
      };

      // Translate Address Details Labels
      final addressDetailsLabels = {
        'Address 1': 'Address 1',
        'Address 2': 'Address 2',
        'City': 'City',
        'State': 'State',
        'Country': 'Country',
        'Postal Code': 'Postal Code',
        'Passport Number': 'Passport Number',
        'Language': 'Language',
      };

      // Translate Address Details progressively
      currentTranslatingSection.value = getTranslatedUIMessage(
        'Address Details',
      );
      translationProgress.value = 0.56; // 4/7 sections
      printLog('Translating Address Details...');
      final translatedAddressDetails = await TranslationService.translateMap(
        addressDetailsData,
        countryCode.value,
      );
      final translatedAddressLabels = await TranslationService.translateMap(
        addressDetailsLabels,
        countryCode.value,
      );

      // Update UI immediately after Address Details translation
      translatedData.value = {
        ...translatedData.value,
        'addressDetails': translatedAddressDetails,
        'addressLabels': translatedAddressLabels,
      };
      completedSections.add('Address Details');
      printLog('Address Details translation completed - UI updated');

      // Translate Medical History
      final medicalHistoryData = <String, String>{
        'Conditions': user.details?.medicalHistory?.medicalCondition ?? '',
        'Sickness History':
            (user.details?.medicalHistory?.sicknessHistory
                    ?.join(', ')
                    ?.isEmpty ??
                true)
            ? 'None'
            : user.details?.medicalHistory?.sicknessHistory?.join(', ') ??
                  'None',
        'Surgeries':
            (user.details?.medicalHistory?.surgicalHistory
                    ?.join(', ')
                    ?.isEmpty ??
                true)
            ? 'None'
            : user.details?.medicalHistory?.surgicalHistory?.join(', ') ??
                  'None',
        'Allergies':
            (user.details?.medicalHistory?.allergy?.join(', ')?.isEmpty ?? true)
            ? 'None'
            : user.details?.medicalHistory?.allergy?.join(', ') ?? 'None',
        'Medications': user.details?.medicalHistory?.medication ?? '',
        'Medication Types':
            (user.details?.medicalHistory?.medicationTypes
                    ?.join(', ')
                    ?.isEmpty ??
                true)
            ? 'None'
            : user.details?.medicalHistory?.medicationTypes?.join(', ') ??
                  'None',
      };

      // Placeholder translation function
      String tr(String key) {
        // Replace with your actual translation service
        return key;
      }

      // Translate Medical History Labels
      final medicalHistoryLabels = {
        'Conditions': tr('Conditions'),
        'Sickness History': tr('Sickness History'),
        'Surgeries': tr('Surgeries'),
        'Allergies': tr('Allergies'),
        'Medications': tr('Medications'),
        'Medication Types': tr('Medication Types'),
      };

      // Translate Medical History progressively (3rd section in UI)
      currentTranslatingSection.value = getTranslatedUIMessage(
        'Medical History',
      );
      translationProgress.value = 0.70; // 5/7 sections
      printLog('Translating Medical History...');
      final translatedMedicalHistory = await TranslationService.translateMap(
        medicalHistoryData,
        countryCode.value,
      );
      final translatedMedicalLabels = await TranslationService.translateMap(
        medicalHistoryLabels,
        countryCode.value,
      );

      // Update UI immediately after Medical History translation
      translatedData.value = {
        ...translatedData.value,
        'medicalHistory': translatedMedicalHistory,
        'medicalLabels': translatedMedicalLabels,
      };
      completedSections.add('Medical History');
      printLog('Medical History translation completed - UI updated');

      // Translate Immunization Data (4th section in UI)
      final immunizationData = <String, String>{};
      final immunizationLabels = <String, String>{};

      if (user.details?.vaccineHistory?.immunizationHistory != null) {
        for (var vaccine
            in user.details!.vaccineHistory!.immunizationHistory!) {
          final vaccineName = vaccine.vaccines ?? '';
          if (vaccineName.isNotEmpty) {
            immunizationData[vaccineName] = vaccineName;
            immunizationLabels[vaccineName] = vaccineName;
            final doseInfo =
                '${vaccine.dateOfVaccine ?? ''} (Doses: ${vaccine.dosesReceived ?? 0})';
            immunizationData[doseInfo] = doseInfo;
          }
        }
      }

      currentTranslatingSection.value = getTranslatedUIMessage(
        'Immunization History',
      );
      translationProgress.value = 0.84; // 6/7 sections
      printLog('Translating Immunization History...');
      final translatedImmunizationData = await TranslationService.translateMap(
        immunizationData,
        countryCode.value,
      );
      final translatedImmunizationLabels =
          await TranslationService.translateMap(
            immunizationLabels,
            countryCode.value,
          );

      // Update UI immediately after Immunization translation
      translatedData.value = {
        ...translatedData.value,
        'immunizationData': translatedImmunizationData,
        'immunizationLabels': translatedImmunizationLabels,
      };
      completedSections.add('Immunization History');
      printLog('Immunization History translation completed - UI updated');

      // Translate Lifestyle Factors (5th section in UI)
      final lifestyleData = <String, String>{
        'Smoking': user.details?.lifestyleFactors?.smokingHabits ?? '',
        'Alcohol': user.details?.lifestyleFactors?.alcoholConsumptions ?? '',
        'Activity': user.details?.lifestyleFactors?.physicalActivityLevel ?? '',
        'Preferences': user.details?.lifestyleFactors?.preferences ?? '',
      };

      final lifestyleLabels = {
        'Smoking': 'Smoking',
        'Alcohol': 'Alcohol',
        'Activity': 'Activity',
        'Preferences': 'Preferences',
      };

      currentTranslatingSection.value = getTranslatedUIMessage(
        'Lifestyle Factors',
      );
      translationProgress.value = 0.98; // 6.8/7 sections
      printLog('Translating Lifestyle Factors...');
      final translatedLifestyle = await TranslationService.translateMap(
        lifestyleData,
        countryCode.value,
      );
      final translatedLifestyleLabels = await TranslationService.translateMap(
        lifestyleLabels,
        countryCode.value,
      );

      // Update UI immediately after Lifestyle translation
      translatedData.value = {
        ...translatedData.value,
        'lifestyle': translatedLifestyle,
        'lifestyleLabels': translatedLifestyleLabels,
      };
      completedSections.add('Lifestyle Factors');
      printLog('Lifestyle Factors translation completed - UI updated');

      // Translate Travel Details (6th section in UI)
      final travelDetailsData = <String, String>{
        'Arrived From': user.details?.travelDetails?.arriveFrom ?? '',
        'Days Ago Arrived': user.details?.travelDetails?.daysAgoArrived ?? '',
        'Days Stay': user.details?.travelDetails?.daysStay ?? '',
        'Visited Countries':
            user.details?.travelDetails?.visitedCountries ?? '',
        'Travel Reason': user.details?.travelDetails?.travelReason ?? '',
        'Medical Insurance':
            user.details?.travelDetails?.medicalInsurance ?? '',
        'Pregnant': user.details?.travelDetails?.pregnant ?? '',
        'Nursing': user.details?.travelDetails?.nursing ?? '',
      };

      final travelDetailsLabels = {
        'Arrived From': 'Arrived From',
        'Days Ago Arrived': 'Days Ago Arrived',
        'Days Stay': 'Days Stay',
        'Visited Countries': 'Visited Countries',
        'Travel Reason': 'Travel Reason',
        'Medical Insurance': 'Medical Insurance',
        'Pregnant': 'Pregnant',
        'Nursing': 'Nursing',
      };

      currentTranslatingSection.value = getTranslatedUIMessage(
        'Travel Details',
      );
      translationProgress.value = 1.0; // 7/7 sections (complete)
      printLog('Translating Travel Details...');
      final translatedTravelDetails = await TranslationService.translateMap(
        travelDetailsData,
        countryCode.value,
      );
      final translatedTravelLabels = await TranslationService.translateMap(
        travelDetailsLabels,
        countryCode.value,
      );

      // Update UI immediately after Travel Details translation
      translatedData.value = {
        ...translatedData.value,
        'travelDetails': translatedTravelDetails,
        'travelLabels': translatedTravelLabels,
      };
      completedSections.add('Travel Details');
      printLog('Travel Details translation completed - UI updated');

      // Section Titles already translated at the beginning

      printLog(
        'All translations completed for ${TranslationService.getLanguageName(countryCode.value)}',
      );
    } catch (e) {
      printLog('Translation error: $e');
      AppWidgets().getSnackBar(
        title: 'Translation Error'.tr,
        message: 'Failed to translate medical data: $e'.tr,
      );
    } finally {
      isTranslating.value = false;
    }
  }

  /// Get translated value or original value
  String getTranslatedValue(String section, String key, String originalValue) {
    if (!translateDoc ||
        !TranslationService.shouldTranslate(countryCode.value)) {
      return originalValue;
    }

    return translatedData[section]?[key] ?? originalValue;
  }

  /// Get translated label or original label
  String getTranslatedLabel(String section, String key, String originalLabel) {
    if (!translateDoc ||
        !TranslationService.shouldTranslate(countryCode.value)) {
      return originalLabel;
    }

    String labelSection;
    if (section == 'sections') {
      labelSection = 'sectionsLabels';
    } else {
      labelSection = '${section.replaceAll('Details', '')}Labels';
    }

    return translatedData[labelSection]?[key] ?? originalLabel;
  }

  /// Get language name for current country
  String getCurrentLanguageName() {
    return TranslationService.getLanguageName(countryCode.value);
  }

  /// Check if translation should be applied
  bool get shouldTranslate => translateDoc && countryCode.value.isNotEmpty;

  /// Get translated UI message or original message
  String getTranslatedUIMessage(String key) {
    if (!translateDoc ||
        !TranslationService.shouldTranslate(countryCode.value)) {
      return key;
    }
    return translatedData['uiMessages']?[key] ?? key;
  }

  @override
  void onClose() {
    documentNameController.dispose();
    super.onClose();
  }

  UserFilteredData? get currentUser {
    if (homeController.userData.isNotEmpty) {
      return homeController.userData.first;
    }
    return null;
  }

  // File selection method
  Future<void> selectFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'jpeg', 'png'],
        allowMultiple: false,
      );

      if (result != null && result.files.single.path != null) {
        selectedFile.value = File(result.files.single.path!);

        // Auto-fill document name if empty
        if (documentNameController.text.isEmpty) {
          documentNameController.text = result.files.single.name
              .split('.')
              .first;
        }

        AppWidgets().getSnackBar(
          title: 'File Selected'.tr,
          message: 'File ${result.files.single.name} selected successfully'.tr,
        );
      }
    } catch (e) {
      AppWidgets().getSnackBar(
        title: 'Error'.tr,
        message: 'Failed to select file: $e'.tr,
      );
    }
  }

  // File upload method
  Future<void> uploadFile() async {
    if (selectedFile.value == null) {
      AppWidgets().getSnackBar(
        title: 'Error'.tr,
        message: 'Please select a file first'.tr,
      );
      return;
    }

    if (documentNameController.text.trim().isEmpty) {
      AppWidgets().getSnackBar(
        title: 'Error'.tr,
        message: 'Please enter a document name'.tr,
      );
      return;
    }

    if (currentUser?.email == null) {
      AppWidgets().getSnackBar(
        title: 'Error'.tr,
        message: 'User email not found'.tr,
      );
      return;
    }

    try {
      isUploading.value = true;
      uploadProgress.value = 0.0;

      // Create Dio instance
      final dioClient = dio.Dio();

      // Prepare form data
      String fileName = selectedFile.value!.path.split('/').last;
      dio.FormData formData = dio.FormData.fromMap({
        'file': await dio.MultipartFile.fromFile(
          selectedFile.value!.path,
          filename: fileName,
        ),
        'email': currentUser!.email,
      });

      // Upload with progress tracking
      dio.Response response = await dioClient.post(
        uploadApiUrl,
        data: formData,
        options: dio.Options(
          headers: {
            'Authorization': accessToken.$,
            'Content-Type': 'multipart/form-data',
          },
        ),
        onSendProgress: (sent, total) {
          uploadProgress.value = sent / total;
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        AppWidgets().getSnackBar(
          title: 'Success'.tr,
          message: 'Document uploaded successfully'.tr,
        );

        // Clear form after successful upload
        clearForm();

        // Refresh user data to get updated documents
        await homeController.getUserData();
      } else {
        throw Exception('Upload failed with status: ${response.statusCode}');
      }
    } catch (e) {
      AppWidgets().getSnackBar(
        title: 'Upload Failed'.tr,
        message: 'Failed to upload document: $e'.tr,
      );
    } finally {
      isUploading.value = false;
      uploadProgress.value = 0.0;
    }
  }

  // Clear form method
  void clearForm() {
    documentNameController.clear();
    selectedFile.value = null;
  }

  // Cancel upload method
  void cancelUpload() {
    clearForm();
    AppWidgets().getSnackBar(
      title: 'Cancelled'.tr,
      message: 'Upload cancelled'.tr,
    );
  }

  // Get file size in readable format
  String getFileSize(File file) {
    int bytes = file.lengthSync();
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB"];
    var i = (log(bytes) / log(1024)).floor();
    return ((bytes / pow(1024, i)).toStringAsFixed(1)) + ' ' + suffixes[i];
  }

  // Check if file size is within limit (10MB)
  bool isFileSizeValid(File file) {
    const int maxSize = 10 * 1024 * 1024; // 10MB in bytes
    return file.lengthSync() <= maxSize;
  }
}
