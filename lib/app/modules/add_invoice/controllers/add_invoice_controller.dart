import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medi/app/core/helper/app_widgets.dart';
import 'package:medi/app/data/remote/model/invoices/create_invoiec_request.dart'
    as invoice_req;
import 'package:medi/app/data/remote/model/invoices/doctor_response.dart';
import 'package:medi/app/data/remote/repository/invoices/invoices_repository.dart';

import '../../../data/remote/model/invoices/patient_response.dart';

class AddInvoiceController extends GetxController {
  // List of added taxes (tax name, percentage)
  final addedTaxes = <Map<String, dynamic>>[].obs;

  // Add current tax to the list
  void addCurrentTax() {
    final name = taxNameController.text.trim();
    final percentText = taxPercentageController.text.trim();
    if (name.isNotEmpty && percentText.isNotEmpty) {
      final percent = double.tryParse(percentText) ?? 0.0;
      addedTaxes.add({'name': name, 'percent': percent});
      // Optionally clear fields after adding
      taxNameController.clear();
      taxPercentageController.clear();
      calculateTotals();
    }
  }

  // List of added services (category, service, cost)
  final addedServices = <Map<String, dynamic>>[].obs;

  // Add current selection to the list
  void addCurrentService() {
    if (selectedCategory.value != null &&
        selectedService.value != null &&
        costController.text.isNotEmpty) {
      final cost = double.tryParse(costController.text) ?? 0.0;
      addedServices.add({
        'category': selectedCategory.value,
        'service': selectedService.value,
        'cost': cost,
      });
      // Clear cost for next entry
      costController.clear();
      // Optionally reset service
      selectedService.value = null;
      calculateTotals();
    }
  }

  // Calculate totals: sum all services, apply all added taxes, subtract discount
  void calculateTotals() {
    final subtotalSum = addedServices.fold<double>(
      0.0,
      (sum, item) => sum + (item['cost'] as double),
    );
    subtotal.value = subtotalSum;

    // Sum all added taxes
    double totalTax = 0.0;
    for (final tax in addedTaxes) {
      final percent = tax['percent'] as double? ?? 0.0;
      totalTax += subtotal.value * percent / 100;
    }
    taxAmount.value = totalTax;

    final discountVal = double.tryParse(discountController.text) ?? 0.0;
    discountAmount.value = discountVal;
    total.value = subtotal.value + taxAmount.value - discountAmount.value;
  }

  final selectedPatientId = RxnString();
  final selectedDoctorId = RxnString();
  // Text Controllers
  final treatmentController = TextEditingController();
  final costController = TextEditingController();
  final taxNameController = TextEditingController();
  final taxPercentageController = TextEditingController();
  final discountController = TextEditingController();

  // Reactive variables for calculations
  final subtotal = 0.0.obs;
  final taxAmount = 0.0.obs;
  final discountAmount = 0.0.obs;
  final total = 0.0.obs;

  // Reactive variables for display
  final taxName = 'Tax'.tr.obs;
  final taxPercentage = '0'.obs;

  // Category and Service Selection
  final selectedCategory = Rxn<String>();
  final selectedService = Rxn<String>();
  final availableServices = <String>[].obs;

  final patientList = <PatientData>[].obs;
  final doctorList = <DoctorList>[].obs;

  Future<void> getCategories() async {
    var response = await InvoicesRepository().getCategories('');
  }

  Future<void> getAllDoctors() async {
    var response = await InvoicesRepository().getAllDoctors();

    if (response.success == true) {
      doctorList.clear();
      doctorList.addAll(response.data ?? []);
    } else {
      AppWidgets().getSnackBar(message: response.message);
    }
  }

  Future<void> getAllPatients() async {
    var response = await InvoicesRepository().getAllPatients();

    if (response.success == true) {
      patientList.clear();
      patientList.addAll(response.data ?? []);
    } else {
      AppWidgets().getSnackBar(message: response.message);
    }
  }

  // Categories with their services
  final Map<String, List<String>> categoryServices = {
    'Medical Service'.tr: [
      'General Consultation'.tr,
      'Specialist Consultation'.tr,
      'Follow-up Consultation'.tr,
      'Health Checkup'.tr,
      'Physical Examination'.tr,
    ],
    'Diagnostic Imaging'.tr: [
      'X-Ray'.tr,
      'CT Scan'.tr,
      'MRI'.tr,
      'Ultrasound'.tr,
      'Mammography'.tr,
      'Echocardiography'.tr,
    ],
    'Laboratory Tests'.tr: [
      'Blood Test'.tr,
      'Urine Test'.tr,
      'Stool Test'.tr,
      'Biopsy'.tr,
      'Culture Test'.tr,
      'Pathology'.tr,
    ],
    'Surgical Procedures'.tr: [
      'Minor Surgery'.tr,
      'Major Surgery'.tr,
      'Day Surgery'.tr,
      'Emergency Surgery'.tr,
      'Cosmetic Surgery'.tr,
    ],
    'Dental and Maxillofacial Procedures'.tr: [
      'Dental Cleaning'.tr,
      'Tooth Extraction'.tr,
      'Root Canal'.tr,
      'Dental Filling'.tr,
      'Dental Implant'.tr,
      'Orthodontics'.tr,
    ],
    'Hospital Room Charges'.tr: [
      'Private Room'.tr,
      'Semi-Private Room'.tr,
      'General Ward'.tr,
      'ICU'.tr,
      'CCU'.tr,
      'Recovery Room'.tr,
    ],
    'Medications'.tr: [
      'Prescription Drugs'.tr,
      'Over-the-counter Drugs'.tr,
      'Injectable Medications'.tr,
      'IV Fluids'.tr,
      'Medical Supplies'.tr,
    ],
    'Emergency Room Services'.tr: [
      'Emergency Consultation'.tr,
      'Trauma Care'.tr,
      'Critical Care'.tr,
      'Ambulance Service'.tr,
      'Emergency Surgery'.tr,
    ],
    'Rehabilitation Services'.tr: [
      'Physiotherapy'.tr,
      'Occupational Therapy'.tr,
      'Speech Therapy'.tr,
      'Rehabilitation Program'.tr,
      'Home Care Services'.tr,
    ],
    'Miscellaneous Charges'.tr: [
      'Administrative Fees'.tr,
      'Medical Records'.tr,
      'Certificate Fees'.tr,
      'Equipment Usage'.tr,
      'Facility Charges'.tr,
    ],
    'Maternity and Delivery Services'.tr: [
      'Prenatal Care'.tr,
      'Delivery Charges'.tr,
      'Postnatal Care'.tr,
      'C-Section'.tr,
      'NICU Services'.tr,
    ],
    'Other'.tr: [
      'Consultation Fee'.tr,
      'Service Charge'.tr,
      'Miscellaneous Fee'.tr,
      'Special Services'.tr,
      'Custom Service'.tr,
    ],
  };

  @override
  void onInit() {
    super.onInit();
    // Add listeners to text controllers
    costController.addListener(calculateTotals);
    taxPercentageController.addListener(() {
      calculateTotals();
      taxPercentage.value = taxPercentageController.text;
    });
    discountController.addListener(calculateTotals);
    taxNameController.addListener(() {
      taxName.value =
          taxNameController.text.isEmpty ? 'Tax' : taxNameController.text;
    });

    getAllPatients();
    getAllDoctors();
    getCategories();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    // Dispose controllers
    treatmentController.dispose();
    costController.dispose();
    taxNameController.dispose();
    taxPercentageController.dispose();
    discountController.dispose();
    super.onClose();
  }

  // Function to calculate totals

  // Handle category selection
  void onCategorySelected(String? category) {
    selectedCategory.value = category;
    selectedService.value = null; // Reset service selection

    if (category != null && categoryServices.containsKey(category)) {
      availableServices.value = categoryServices[category]!;
    } else {
      availableServices.clear();
    }
  }

  Future<void> addInvoice() async {
    final body = {
      "patientMediid": selectedPatientId.value,
      "doctorMediid": selectedDoctorId.value,
      "details": addedServices
          .map(
            (service) => {
              "name": service['service'],
              "price": (service['cost'] as double?)?.toInt() ?? 0,
              "qty": 1,
              "isFreehand": false,
            },
          )
          .toList(),
      "discount": discountAmount.value.toInt(),
      "subtotal": subtotal.value.toInt(),
      "tax": {
        "otherTaxes": addedTaxes
            .map(
              (tax) => {
                "name": tax['name'],
                "percent": (tax['percent'] as double?)?.toInt() ?? 0,
              },
            )
            .toList(),
        "consumptionTax": 15, // You can set this dynamically if needed
      },
      "hospitalDetails": {
        "hospitalMediid": "88710521h",
        "hospitalName": "HASAN",
        "hospitalAddress": "HASAN",
        "hospitalCity": "HASAN",
        "hospitalCountry": "Bangladesh",
        "hospitalPostalCode": "HASAN",
        "hospitalEmail": "nhashik40@gmail.com",
        "hospitalPhone": "+8801305727216",
      },
      "hospitalLogo":
          "https://res.cloudinary.com/dkzp6bxd1/image/upload/v1740911772/hospital_logos/zb51oxej3h3lzrcyhpyl.webp",
      "hospitalCurrency": "INR",
      "hospitalLanguage": "en",
      "date": DateTime.now().millisecondsSinceEpoch,
      "createdBy": "HOSPITAL",
    };

    var response = await InvoicesRepository().addInvoice(body);
    if (response != null) {
      Get.back();
      AppWidgets().getSnackBar(message: 'Invoice Created Successfully'.tr);
    }
  }

  // Handle service selection
  void onServiceSelected(String? service) {
    selectedService.value = service;
  }
}

// OnboardingController already localized
// ChatboxController localized
// Next: AddInvoiceController
