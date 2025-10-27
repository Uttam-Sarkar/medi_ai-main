import 'package:flutter/material.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../core/style/app_colors.dart';
import '../../../core/helper/shared_value_helper.dart';
import '../controllers/travel_history_controller.dart';

class TravelHistoryView extends GetView<TravelHistoryController> {
  const TravelHistoryView({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: AppColors.primaryColor,
        leading: InkWell(
          onTap: () => Get.back(),
          child: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.primaryAccentColor,
          ),
        ),
        title: Text(
          'Travel Details'.tr,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryAccentColor,
          ),
        ),
        centerTitle: false,
        titleSpacing: -10,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with icon
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.primaryAccentColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        FontAwesomeIcons.planeArrival,
                        color: AppColors.primaryAccentColor,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Travel Health Form',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryAccentColor,
                            ),
                          ),
                          Text(
                            'Please fill in your travel details',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.textColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // Conditional fields for female users
                if (gender.$ == 'female') ...[
                  // Pregnancy question
                  Text(
                    'Are you Pregnant?',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryAccentColor,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Obx(
                    () => ClayContainer(
                      color: AppColors.primaryColor,
                      borderRadius: 8,
                      depth: 12,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: controller.isPregnant.value.isEmpty 
                                ? null 
                                : controller.isPregnant.value,
                            hint: Text('Select an option'),
                            isExpanded: true,
                            items: controller.yesNoOptions.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                controller.setPregnant(newValue);
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Nursing question
                  Text(
                    'Are you now Nursing?',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryAccentColor,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Obx(
                    () => ClayContainer(
                      color: AppColors.primaryColor,
                      borderRadius: 8,
                      depth: 12,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: controller.isNursing.value.isEmpty 
                                ? null 
                                : controller.isNursing.value,
                            hint: Text('Select an option'),
                            isExpanded: true,
                            items: controller.yesNoOptions.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                controller.setNursing(newValue);
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],

                // Payment method question
                Text(
                  'How will you pay your medical fee (credit card, cash)? *',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryAccentColor,
                  ),
                ),
                const SizedBox(height: 12),
                Obx(
                  () => ClayContainer(
                    color: AppColors.primaryColor,
                    borderRadius: 8,
                    depth: 12,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: controller.paymentMethod.value.isEmpty 
                              ? null 
                              : controller.paymentMethod.value,
                          hint: Text('Select an option'),
                          isExpanded: true,
                          items: controller.paymentOptions.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              controller.setPaymentMethod(newValue);
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Travel reason question
                Text(
                  'Travel Reason *',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryAccentColor,
                  ),
                ),
                const SizedBox(height: 12),
                Obx(
                  () => ClayContainer(
                    color: AppColors.primaryColor,
                    borderRadius: 8,
                    depth: 12,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: controller.travelReason.value.isEmpty 
                              ? null 
                              : controller.travelReason.value,
                          hint: Text('Select an option'),
                          isExpanded: true,
                          items: controller.travelReasonOptions.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              controller.setTravelReason(newValue);
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Travel start date
                Text(
                  'Date You Started Traveling',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryAccentColor,
                  ),
                ),
                const SizedBox(height: 12),
                ClayContainer(
                  color: AppColors.primaryColor,
                  borderRadius: 8,
                  depth: 12,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: TextField(
                      controller: controller.travelStartDateController,
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: 'mm / dd / yyyy',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                        suffixIcon: Icon(
                          Icons.calendar_today,
                          color: AppColors.primaryAccentColor,
                          size: 20,
                        ),
                      ),
                      onTap: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime.now(),
                        );
                        if (picked != null) {
                          controller.travelStartDateController.text = DateFormat('dd-MM-yyyy').format(picked);
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Medication question
                Text(
                  'Have you been taking any medication today? *',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryAccentColor,
                  ),
                ),
                const SizedBox(height: 12),
                Obx(
                  () => ClayContainer(
                    color: AppColors.primaryColor,
                    borderRadius: 8,
                    depth: 12,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: controller.medicationTaken.value.isEmpty 
                              ? null 
                              : controller.medicationTaken.value,
                          hint: Text('Select an option'),
                          isExpanded: true,
                          items: controller.medicationOptions.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              controller.setMedicationTaken(newValue);
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Days ago arrived
                Text(
                  'How many days ago have you arrived to (city)? (in Days)',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryAccentColor,
                  ),
                ),
                const SizedBox(height: 12),
                ClayContainer(
                  color: AppColors.primaryColor,
                  borderRadius: 8,
                  depth: 12,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: TextField(
                      controller: controller.daysAgoController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Enter number of days',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Stay duration
                Text(
                  'How long are you going to stay in (city)? (in Days)',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryAccentColor,
                  ),
                ),
                const SizedBox(height: 12),
                ClayContainer(
                  color: AppColors.primaryColor,
                  borderRadius: 8,
                  depth: 12,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: TextField(
                      controller: controller.stayDurationController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Enter number of days',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Countries visited
                Text(
                  'Where did you arrive from? (list the countries prior of arriving here)',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryAccentColor,
                  ),
                ),
                const SizedBox(height: 12),
                ClayContainer(
                  color: AppColors.primaryColor,
                  borderRadius: 8,
                  depth: 12,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: TextField(
                      controller: controller.countriesVisitedController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: 'Enter countries separated by commas',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Symptoms start
                Text(
                  'When did your symptoms start?',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryAccentColor,
                  ),
                ),
                const SizedBox(height: 12),
                ClayContainer(
                  color: AppColors.primaryColor,
                  borderRadius: 8,
                  depth: 12,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: TextField(
                      controller: controller.symptomsStartController,
                      decoration: InputDecoration(
                        hintText: 'e.g., 2 days ago, this morning, etc.',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Medical insurance
                Text(
                  'Do you have medical insurance? *',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryAccentColor,
                  ),
                ),
                const SizedBox(height: 12),
                Obx(
                  () => ClayContainer(
                    color: AppColors.primaryColor,
                    borderRadius: 8,
                    depth: 12,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: controller.hasMedicalInsurance.value.isEmpty 
                              ? null 
                              : controller.hasMedicalInsurance.value,
                          hint: Text('Select an option'),
                          isExpanded: true,
                          items: controller.insuranceOptions.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              controller.setMedicalInsurance(newValue);
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                // Submit button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: controller.submitTravelHistory,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryAccentColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(FontAwesomeIcons.paperPlane, size: 16),
                        const SizedBox(width: 8),
                        Text(
                          'Submit Travel Details',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
