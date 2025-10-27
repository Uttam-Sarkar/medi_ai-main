import 'package:flutter/material.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:get/get.dart';
import 'package:medi/app/core/custom_widgets/global_appbar.dart';
import '../../../core/style/app_colors.dart';

import '../controllers/add_invoice_controller.dart';

class AddInvoiceView extends GetView<AddInvoiceController> {
  const AddInvoiceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: globalAppBar(context, 'Add Invoice'.tr),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Patient Selection Dropdown (at the top)
                Text(
                  'Select a Patient:'.tr,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryAccentColor,
                  ),
                ),
                const SizedBox(height: 8),
                ClayContainer(
                  color: AppColors.primaryColor,
                  borderRadius: 8,
                  depth: 12,
                  child: Obx(
                    () => DropdownButtonFormField<String>(
                      value: controller.selectedPatientId.value,
                      decoration: InputDecoration(
                        hintText: 'Select a patient'.tr,
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                      ),
                      items: controller.patientList.map((patient) {
                        final name =
                            ('${patient.details?.personalDetails!.firstName} ${patient.details?.personalDetails!.lastName}');
                        return DropdownMenuItem(
                          value: patient.mediid,
                          child: Text(name.isNotEmpty ? name : 'Unknown'.tr),
                        );
                      }).toList(),
                      onChanged: (value) {
                        controller.selectedPatientId.value = value;
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Doctor Selection
                Text(
                  'Select Doctor:'.tr,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryAccentColor,
                  ),
                ),
                const SizedBox(height: 8),
                ClayContainer(
                  color: AppColors.primaryColor,
                  borderRadius: 8,
                  depth: 12,
                  child: Obx(
                    () => DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        hintText: 'Select a doctor'.tr,
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                      ),
                      value: controller.selectedDoctorId.value,
                      items: controller.doctorList.map((doctor) {
                        final name = doctor.details?.fullName ?? 'Unknown'.tr;
                        return DropdownMenuItem(
                          value: doctor.mediid,
                          child: Text(name),
                        );
                      }).toList(),
                      onChanged: (value) {
                        controller.selectedDoctorId.value = value;
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Freehand Treatment Description
                Text(
                  'Freehand Treatment Description'.tr,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryAccentColor,
                  ),
                ),
                const SizedBox(height: 8),
                ClayContainer(
                  color: AppColors.primaryColor,
                  borderRadius: 8,
                  depth: 12,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: TextField(
                      controller: controller.treatmentController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: 'Enter custom treatment details'.tr,
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Category Selection (moved below cost)
                Text(
                  'Select Category'.tr,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryAccentColor,
                  ),
                ),
                const SizedBox(height: 8),
                ClayContainer(
                  color: AppColors.primaryColor,
                  borderRadius: 8,
                  depth: 12,
                  child: Obx(
                    () => DropdownButtonFormField<String>(
                      value: controller.selectedCategory.value,
                      decoration: InputDecoration(
                        hintText: 'Select a category'.tr,
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                      ),
                      items: controller.categoryServices.keys.map((
                        String category,
                      ) {
                        return DropdownMenuItem<String>(
                          value: category,
                          child: Text(category.tr),
                        );
                      }).toList(),
                      onChanged: (value) {
                        controller.selectedCategory.value = value;
                        controller.onCategorySelected(value);
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Service Selection
                Text(
                  'Select Service'.tr,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryAccentColor,
                  ),
                ),
                const SizedBox(height: 8),
                ClayContainer(
                  color: AppColors.primaryColor,
                  borderRadius: 8,
                  depth: 12,
                  child: Obx(
                    () => DropdownButtonFormField<String>(
                      value: controller.selectedService.value,
                      decoration: InputDecoration(
                        hintText: controller.selectedCategory.value == null
                            ? 'Select a category first'.tr
                            : 'Please select a service'.tr,
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                      ),
                      items: controller.availableServices.isNotEmpty
                          ? controller.availableServices.map((String service) {
                              return DropdownMenuItem<String>(
                                value: service,
                                child: Text(service.tr),
                              );
                            }).toList()
                          : null,
                      onChanged: controller.selectedCategory.value != null
                          ? controller.onServiceSelected
                          : null,
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Cost
                Text(
                  'Cost'.tr,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryAccentColor,
                  ),
                ),
                const SizedBox(height: 8),
                ClayContainer(
                  color: AppColors.primaryColor,
                  borderRadius: 8,
                  depth: 12,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: TextField(
                      controller: controller.costController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: '0',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.add),
                    label: Text('Add Service'.tr),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryAccentColor,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      controller.addCurrentService();
                    },
                  ),
                ),
                const SizedBox(height: 16),

                // Tax Name
                Text(
                  'Tax Name'.tr,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryAccentColor,
                  ),
                ),
                const SizedBox(height: 8),
                ClayContainer(
                  color: AppColors.primaryColor,
                  borderRadius: 8,
                  depth: 12,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: TextField(
                      controller: controller.taxNameController,
                      decoration: InputDecoration(
                        hintText: 'Enter tax name (e.g., VAT)'.tr,
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Tax Percentage
                Text(
                  'Tax Percentage (%)'.tr,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryAccentColor,
                  ),
                ),
                const SizedBox(height: 8),
                ClayContainer(
                  color: AppColors.primaryColor,
                  borderRadius: 8,
                  depth: 12,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: TextField(
                      controller: controller.taxPercentageController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: '0',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.add),
                    label: Text('Add Tax'.tr),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryAccentColor,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      controller.addCurrentTax();
                    },
                  ),
                ),
                const SizedBox(height: 24),
                // Discount
                Text(
                  'Discount'.tr,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryAccentColor,
                  ),
                ),
                const SizedBox(height: 8),
                ClayContainer(
                  color: AppColors.primaryColor,
                  borderRadius: 8,
                  depth: 12,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: TextField(
                      controller: controller.discountController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: '0',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Additional Notes
                Text(
                  'Additional Notes'.tr,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryAccentColor,
                  ),
                ),
                const SizedBox(height: 8),
                ClayContainer(
                  color: AppColors.primaryColor,
                  borderRadius: 8,
                  depth: 12,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: TextField(
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: 'Write additional notes here...'.tr,
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // Total Section with Service List
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Total'.tr,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryAccentColor,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // List of Added Services (inside Total section)
                      Obx(
                        () => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Services:'.tr,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: AppColors.primaryAccentColor,
                              ),
                            ),
                            const SizedBox(height: 8),
                            if (controller.addedServices.isNotEmpty)
                              ...controller.addedServices.map(
                                (item) => Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${item['service']}'.tr,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: AppColors.primaryAccentColor,
                                      ),
                                    ),
                                    Text(
                                      '\$${(item['cost'] as double).toStringAsFixed(2)}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: AppColors.primaryAccentColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                            // List of Added Taxes
                            if (controller.addedTaxes.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(top: 12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Taxes:'.tr,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: AppColors.primaryAccentColor,
                                      ),
                                    ),
                                    ...controller.addedTaxes.map(
                                      (tax) => ListTile(
                                        dense: true,
                                        contentPadding: EdgeInsets.zero,
                                        title: Text(
                                          '${tax['name']}'.tr +
                                              ' (${tax['percent']}%)',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: AppColors.primaryAccentColor,
                                          ),
                                        ),
                                        trailing: Text(
                                          '+\$${((controller.subtotal.value * (tax['percent'] as double) / 100)).toStringAsFixed(2)}',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: AppColors.primaryAccentColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Subtotal'.tr,
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.primaryAccentColor,
                            ),
                          ),
                          Obx(
                            () => Text(
                              '\$${controller.subtotal.value.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.primaryAccentColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(
                            () => Text(
                              '${controller.taxName.value} (${controller.taxPercentage.value}%)',
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.primaryAccentColor,
                              ),
                            ),
                          ),
                          Obx(
                            () => Text(
                              '+\$${controller.taxAmount.value.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.primaryAccentColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Obx(
                        () => controller.discountAmount.value > 0
                            ? Column(
                                children: [
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Discount'.tr,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: AppColors.primaryAccentColor,
                                        ),
                                      ),
                                      Text(
                                        '-\$${controller.discountAmount.value.toStringAsFixed(2)}',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            : const SizedBox.shrink(),
                      ),
                      const Divider(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total'.tr,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryAccentColor,
                            ),
                          ),
                          Obx(
                            () => Text(
                              '\$${controller.total.value.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryAccentColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 45,
                        child: OutlinedButton(
                          onPressed: () => Get.back(),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: AppColors.primaryAccentColor,
                              width: 2,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            'Cancel'.tr,
                            style: TextStyle(
                              color: AppColors.primaryAccentColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: SizedBox(
                        height: 45,
                        child: ElevatedButton(
                          onPressed: () {
                            controller.addInvoice();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryAccentColor,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            'Generate'.tr,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
