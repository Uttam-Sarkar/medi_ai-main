import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medi/app/modules/hospital_registration/model/operating_hours_entry.dart';
import 'package:medi/app/modules/hospital_registration/model/staff_entry.dart';
import 'package:medi/app/data/remote/model/auth/request'
    '/hospital_details_request.dart';
import 'package:medi/app/data/remote/repository/auth/auth_repository.dart';
import 'package:medi/app/routes/app_pages.dart';

import '../../../core/helper/app_widgets.dart';

class HospitalRegistrationController extends GetxController {
  final pageController = PageController();

  // Page 1
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var isPasswordVisible = false.obs;
  var countryCode = '+1'.obs;

  // Page 2
  var selectedType = ''.obs;
  void selectType(String type) => selectedType.value = type;

  // Page 3
  final nameController = TextEditingController();
  final dayPhoneController = TextEditingController();
  final locationController = TextEditingController();
  final nightPhoneController = TextEditingController();
  final emailPage3Controller = TextEditingController();
  final countryPage3Controller = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final postcodeController = TextEditingController();
  final currencyController = TextEditingController();
  final consumptionTaxController = TextEditingController();
  final buildingNameController = TextEditingController();
  final numberOfRoomsController = TextEditingController();
  final websiteUrlController = TextEditingController();
  var dayPhoneCountryCode = '+1'.obs;
  var nightPhoneCountryCode = '+1'.obs;

  var hasParking = false.obs;
  var isWheelchairAccessible = false.obs;
  var hasWheelchairToilet = false.obs;
  var hasVisualSupport = false.obs;
  var hasHearingSupport = false.obs;
  var hasForeignLanguageSupport = false.obs;

  // Departments
  final List<String> departments = [
    "Internal Medicine",
    "Surgical System",
    "Pediatrics",
    "Obstetrics",
    "Ophthalmology",
    "Dermatology",
    "Psychiatry",
    "Dental System",
    "Other Surgery",
  ];
  final Map<String, List<String>> subSpecialties = {/* ... */};
  var selectedDepartment = ''.obs;
  var subSpecialtyStates = <String, bool>{}.obs;
  void selectDepartment(String department) => selectedDepartment.value =
      selectedDepartment.value == department ? '' : department;
  void toggleSubSpecialty(String specialty, bool? value) =>
      subSpecialtyStates[specialty] = value ?? false;

  // Images
  final uploadedImages = <XFile>[].obs;
  Future<void> pickImages() async {
    final picker = ImagePicker();
    final images = await picker.pickMultiImage();
    uploadedImages.addAll(images);
  }

  void removeImage(int index) => uploadedImages.removeAt(index);

  // Operating Hours
  final RxList<OperatingHoursEntry> firstOpeningHours =
      <OperatingHoursEntry>[].obs;
  final RxList<OperatingHoursEntry> secondOpeningHours =
      <OperatingHoursEntry>[].obs;
  final List<String> weekdays = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday",
  ];
  @override
  void onInit() {
    for (var day in weekdays) {
      firstOpeningHours.add(OperatingHoursEntry(day));
      secondOpeningHours.add(OperatingHoursEntry(day));
    }
    super.onInit();
  }

  Future<void> pickTime(BuildContext context, Rx<TimeOfDay?> time) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: time.value ?? TimeOfDay.now(),
    );
    if (picked != null && picked != time.value) time.value = picked;
  }

  // Staff
  final RxList<StaffEntry> staffEntries = <StaffEntry>[StaffEntry()].obs;
  void addStaffEntry() => staffEntries.add(StaffEntry());
  void removeStaffEntry(int index) {
    if (staffEntries.length > 1) staffEntries.removeAt(index);
  }

  // Navigation
  Future<void> registerUser() async {
    if(phoneController.value.text.isEmpty){
      AppWidgets().getSnackBar(title: 'Info'.tr, message: 'Phone number is '
          'required'.tr);
      return;
    }

    if(emailController.value.text.isEmpty){
      AppWidgets().getSnackBar(title: 'Info'.tr, message: 'Email is required'
          .tr);
      return;
    }

    if(passwordController.value.text.isEmpty){
      AppWidgets().getSnackBar(title: 'Info'.tr, message: 'Password is '
          'required'.tr);
      return;
    }

    var response = await AuthRepository().getRegister(
      phoneController.text,
      emailController.text,
      passwordController.text,
      "hospital",
    );
    if (response.success == true) {
      goToNextPage();
    } else {
      AppWidgets().getSnackBar(title: 'Error'.tr, message: response.message);
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

  // Helper: Convert operating hours to API model
  List<Hour> _mapOperatingHours(List<OperatingHoursEntry> entries) {
    return entries
        .map(
          (e) => Hour(
            day: e.day,
            isOpen: e.isOpen.value,
            openTime: e.openTime.value?.format(Get.context!) ?? '',
            closeTime: e.closeTime.value?.format(Get.context!) ?? '',
          ),
        )
        .toList();
  }

  // Helper: Convert staff to API model
  List<AvailableDoctor> _mapStaffEntries(List<StaffEntry> entries) {
    return entries
        .map(
          (e) => AvailableDoctor(
            fullName: e.nameController.text,
            selectAccount: ['hospital'],
          ),
        )
        .toList();
  }

  // Helper: Get selected specialties
  List<dynamic> _getSelectedSpecialties() {
    return subSpecialtyStates.entries
        .where((e) => e.value)
        .map((e) => e.key)
        .toList();
  }

  // Helper: Get logo URL (stub, replace with actual upload logic)
  Future<String?> _uploadLogo() async {
    // Implement file upload and return URL
    return null;
  }

  // Build request object
  Future<HospitalDetailsRequest> buildHospitalDetailsRequest() async {
    final logoUrl = await _uploadLogo();
    return HospitalDetailsRequest(
      email: emailController.text,
      updatedFields: UpdatedFields(
        generalInfo: GeneralInfo(
          name: nameController.text,
          phoneNumber: dayPhoneController.text,
          nightPhone: nightPhoneController.text,
          location: locationController.text,
          type: selectedType.value,
          email: emailPage3Controller.text,
          country: countryPage3Controller.text,
          address: addressController.text,
          city: cityController.text,
          postalCode: postcodeController.text,
          currency: currencyController.text,
          taxConsumption: int.tryParse(consumptionTaxController.text),
          speciality: _getSelectedSpecialties(),
          websiteUrl: websiteUrlController.text,
          buildingName: buildingNameController.text,
          rooms: numberOfRoomsController.text,
          parking: hasParking.value,
          wheelChairEntry: isWheelchairAccessible.value,
          wheelChairToilet: hasWheelchairToilet.value,
          visuallyImpaired: hasVisualSupport.value,
          hearingImpairements: hasHearingSupport.value,
          foreignLanguageSupport: hasForeignLanguageSupport.value,
        ),
        uploadLogo: logoUrl,
        workingHours: _mapOperatingHours(firstOpeningHours),
        secondHours: _mapOperatingHours(secondOpeningHours),
        availableDoctors: _mapStaffEntries(staffEntries),
      ),
    );
  }

  // API call
  Future<void> submitRegistration() async {
    try {
      final request = await buildHospitalDetailsRequest();
      final response = await AuthRepository().updateUserDetails(request);
      if (response.success == true) {
        Get.snackbar('Success'.tr, 'Registration submitted!'.tr);
        Get.offAllNamed(Routes.HOME);
      } else {
        Get.snackbar(
          'Error'.tr,
          response.message?.tr ?? 'Registration failed'.tr,
        );
      }
    } catch (e) {
      Get.snackbar('Error'.tr, 'Registration failed: $e'.tr);
    }
  }
}
