import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:medi/app/core/custom_widgets/global_appbar.dart';
import '../controllers/medical_history_controller.dart';

class MedicalHistoryView extends GetView<MedicalHistoryController> {
  const MedicalHistoryView({super.key});

  // Create skeleton data for loading state
  List<Map<String, String>> _createSkeletonData(int itemCount) {
    return List.generate(
      itemCount,
      (index) => {
        'label': 'Loading placeholder text',
        'value': 'Loading placeholder value text here',
      },
    );
  }

  Widget _sectionCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required List<Map<String, String>> items,
    Color? iconColor,
    Color? headerColor,
    bool isLoading = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Skeletonizer(
        enabled: isLoading,
        child: ClayContainer(
          depth: 20,
          spread: 4,
          color: Colors.white,
          borderRadius: 16,
          child: Container(
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.white, Colors.grey.shade50],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: (iconColor ?? Colors.blue[600] ?? Colors.blue)
                            .withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        icon,
                        color: iconColor ?? Colors.blue[600],
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        title.tr,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: headerColor ?? const Color(0xFF0D47A1),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Column(
                    children: items
                        .map(
                          (item) => Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    (item['label'] ?? '').tr,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    (item['value'] ?? 'N/A').tr,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFE),
      appBar: globalAppBar(
        context,
        controller.translateDoc
            ? (controller.shouldTranslate
                  ? controller.getTranslatedLabel(
                      'sections',
                      'Translated Documents',
                      'Translated Documents'.tr,
                    )
                  : 'Translated Documents'.tr)
            : (controller.shouldTranslate
                  ? controller.getTranslatedLabel(
                      'sections',
                      'Medical History',
                      'Medical History'.tr,
                    )
                  : 'Medical History'.tr),
      ),
      body: Obx(() {
        final user = controller.currentUser;

        if (user == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade200,
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.medical_information_outlined,
                        size: 64,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        controller.translateDoc &&
                                controller.countryCode.value.isNotEmpty
                            ? controller.getTranslatedLabel(
                                'sections',
                                'No Medical Data Available',
                                'No Medical Data Available'.tr,
                              )
                            : 'No Medical Data Available'.tr,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        controller.translateDoc &&
                                controller.countryCode.value.isNotEmpty
                            ? controller.getTranslatedLabel(
                                'sections',
                                'Please ensure your profile is complete',
                                'Please ensure your profile is complete'.tr,
                              )
                            : 'Please ensure your profile is complete'.tr,
                        style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () => Get.back(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[600],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                        ),
                        child: Text(
                          controller.translateDoc &&
                                  controller.countryCode.value.isNotEmpty
                              ? controller.getTranslatedLabel(
                                  'sections',
                                  'Go Back',
                                  'Go Back'.tr,
                                )
                              : 'Go Back'.tr,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Header
              Skeletonizer(
                enabled:
                    controller.translateDoc && controller.isTranslating.value,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.blue[600] ?? Colors.blue,
                        Colors.blue[700] ?? Colors.blue.shade700,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.shade200,
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.translateDoc &&
                                      controller.countryCode.value.isNotEmpty
                                  ? controller.getTranslatedLabel(
                                      'sections',
                                      'Your Medical Profile',
                                      'Your Medical Profile'.tr,
                                    )
                                  : 'Your Medical Profile'.tr,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              controller.translateDoc &&
                                      controller.countryCode.value.isNotEmpty
                                  ? (controller.getTranslatedLabel(
                                          'sections',
                                          'Complete health overview for',
                                          'Complete health overview for'.tr,
                                        ) +
                                        ' ' +
                                        controller.getTranslatedValue(
                                          'personalDetails',
                                          'Name',
                                          user
                                                  .details
                                                  ?.personalDetails
                                                  ?.firstName ??
                                              '',
                                        ))
                                  : ('Complete health overview for '.tr +
                                        (user
                                                .details
                                                ?.personalDetails
                                                ?.firstName ??
                                            '')),
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                controller.translateDoc &&
                                        controller.countryCode.value.isNotEmpty
                                    ? (controller.getTranslatedLabel(
                                            'sections',
                                            'ID',
                                            'ID'.tr,
                                          ) +
                                          ': ' +
                                          (user.mediid ?? ''))
                                    : ('ID: '.tr + (user.mediid ?? '')),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Icon(
                          Icons.folder_shared,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Translation Status Indicator
              controller.shouldTranslate
                  ? Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: controller.isTranslating.value
                              ? [
                                  Colors.orange[400] ?? Colors.orange,
                                  Colors.orange[600] ?? Colors.orange.shade600,
                                ]
                              : [
                                  Colors.green[400] ?? Colors.green,
                                  Colors.green[600] ?? Colors.green.shade600,
                                ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color:
                                (controller.isTranslating.value
                                        ? Colors.orange
                                        : Colors.green)
                                    .shade200,
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Icon(
                            controller.isTranslating.value
                                ? Icons.translate
                                : Icons.check_circle,
                            color: Colors.white,
                            size: 24,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller.isTranslating.value
                                      ? (controller
                                                .currentTranslatingSection
                                                .value
                                                .isNotEmpty
                                            ? '${controller.getTranslatedUIMessage('Translating')} ${controller.currentTranslatingSection.value}...'
                                            : controller.getTranslatedUIMessage(
                                                'Translating Content',
                                              ))
                                      : '${controller.getTranslatedUIMessage('Translated to')} ${controller.getCurrentLanguageName()}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                if (controller.isTranslating.value)
                                  const SizedBox(height: 4),
                                if (controller.isTranslating.value)
                                  Text(
                                    '${(controller.translationProgress.value * 100).toInt()}% ${controller.getTranslatedUIMessage('Complete')} • ${controller.completedSections.length}/7 ${controller.getTranslatedUIMessage('sections done')}',
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 12,
                                    ),
                                  ),
                                if (controller.isTranslating.value)
                                  const SizedBox(height: 6),
                                if (controller.isTranslating.value)
                                  LinearProgressIndicator(
                                    backgroundColor: Colors.white24,
                                    valueColor:
                                        const AlwaysStoppedAnimation<Color>(
                                          Colors.white,
                                        ),
                                    value: controller.translationProgress.value,
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox.shrink(),

              _sectionCard(
                context: context,
                icon: Icons.person_outline,
                title:
                    controller.translateDoc &&
                        controller.countryCode.value.isNotEmpty
                    ? controller.getTranslatedLabel(
                        'sections',
                        'Personal Details',
                        'Personal Details'.tr,
                      )
                    : 'Personal Details'.tr,
                iconColor: Colors.green[600],
                isLoading:
                    controller.translateDoc && controller.isTranslating.value,
                items: controller.translateDoc && controller.isTranslating.value
                    ? _createSkeletonData(10)
                    : [
                        {
                          'label': controller.getTranslatedLabel(
                            'personalDetails',
                            'Name',
                            'Name'.tr,
                          ),
                          'value': controller.getTranslatedValue(
                            'personalDetails',
                            'Name',
                            '${user.details?.personalDetails?.firstName ?? ''} ${user.details?.personalDetails?.lastName ?? ''}'
                                .trim(),
                          ),
                        },
                        {
                          'label': controller.getTranslatedLabel(
                            'personalDetails',
                            'Email',
                            'Email'.tr,
                          ),
                          'value': controller.getTranslatedValue(
                            'personalDetails',
                            'Email',
                            user.email ?? '',
                          ),
                        },
                        {
                          'label': controller.getTranslatedLabel(
                            'personalDetails',
                            'Phone',
                            'Phone'.tr,
                          ),
                          'value': controller.getTranslatedValue(
                            'personalDetails',
                            'Phone',
                            user.phoneNumber ?? '',
                          ),
                        },
                        {
                          'label': controller.getTranslatedLabel(
                            'personalDetails',
                            'MediID',
                            'MediID'.tr,
                          ),
                          'value': controller.getTranslatedValue(
                            'personalDetails',
                            'MediID',
                            user.mediid ?? '',
                          ),
                        },
                        {
                          'label': controller.getTranslatedLabel(
                            'personalDetails',
                            'DOB',
                            'DOB'.tr,
                          ),
                          'value': controller.getTranslatedValue(
                            'personalDetails',
                            'DOB',
                            user.details?.personalDetails?.dateOfBirth
                                    ?.toString()
                                    .split(' ')[0] ??
                                '',
                          ),
                        },
                        {
                          'label': controller.getTranslatedLabel(
                            'personalDetails',
                            'Age',
                            'Age'.tr,
                          ),
                          'value': controller.getTranslatedValue(
                            'personalDetails',
                            'Age',
                            user.details?.personalDetails?.age ?? '',
                          ),
                        },
                        {
                          'label': controller.getTranslatedLabel(
                            'personalDetails',
                            'Gender',
                            'Gender'.tr,
                          ),
                          'value': controller.getTranslatedValue(
                            'personalDetails',
                            'Gender',
                            user.details?.personalDetails?.gender ?? '',
                          ),
                        },
                        {
                          'label': controller.getTranslatedLabel(
                            'personalDetails',
                            'Blood Type',
                            'Blood Type'.tr,
                          ),
                          'value': controller.getTranslatedValue(
                            'personalDetails',
                            'Blood Type',
                            user.details?.personalDetails?.bloodType ?? '',
                          ),
                        },
                        {
                          'label': controller.getTranslatedLabel(
                            'personalDetails',
                            'Height',
                            'Height'.tr,
                          ),
                          'value': controller.getTranslatedValue(
                            'personalDetails',
                            'Height',
                            user.details?.personalDetails?.height ?? '',
                          ),
                        },
                        {
                          'label': controller.getTranslatedLabel(
                            'personalDetails',
                            'Weight',
                            'Weight'.tr,
                          ),
                          'value': controller.getTranslatedValue(
                            'personalDetails',
                            'Weight',
                            user.details?.personalDetails?.weight ?? '',
                          ),
                        },
                      ],
              ),
              _sectionCard(
                context: context,
                icon: Icons.location_on_outlined,
                title:
                    controller.translateDoc &&
                        controller.countryCode.value.isNotEmpty
                    ? controller.getTranslatedLabel(
                        'sections',
                        'Address Details',
                        'Address Details'.tr,
                      )
                    : 'Address Details'.tr,
                iconColor: Colors.orange[600],
                isLoading:
                    controller.translateDoc && controller.isTranslating.value,
                items: controller.translateDoc && controller.isTranslating.value
                    ? _createSkeletonData(8)
                    : [
                        {
                          'label': controller.getTranslatedLabel(
                            'addressDetails',
                            'Address 1',
                            'Address 1'.tr,
                          ),
                          'value': controller.getTranslatedValue(
                            'addressDetails',
                            'Address 1',
                            user.details?.personalDetails?.address1 ?? '',
                          ),
                        },
                        {
                          'label': controller.getTranslatedLabel(
                            'addressDetails',
                            'Address 2',
                            'Address 2'.tr,
                          ),
                          'value': controller.getTranslatedValue(
                            'addressDetails',
                            'Address 2',
                            user.details?.personalDetails?.address2 ?? '',
                          ),
                        },
                        {
                          'label': controller.getTranslatedLabel(
                            'addressDetails',
                            'City',
                            'City'.tr,
                          ),
                          'value': controller.getTranslatedValue(
                            'addressDetails',
                            'City',
                            user.details?.personalDetails?.city ?? '',
                          ),
                        },
                        {
                          'label': controller.getTranslatedLabel(
                            'addressDetails',
                            'State',
                            'State'.tr,
                          ),
                          'value': controller.getTranslatedValue(
                            'addressDetails',
                            'State',
                            user.details?.personalDetails?.state ?? '',
                          ),
                        },
                        {
                          'label': controller.getTranslatedLabel(
                            'addressDetails',
                            'Country',
                            'Country'.tr,
                          ),
                          'value': controller.getTranslatedValue(
                            'addressDetails',
                            'Country',
                            user.details?.personalDetails?.country ?? '',
                          ),
                        },
                        {
                          'label': controller.getTranslatedLabel(
                            'addressDetails',
                            'Postal Code',
                            'Postal Code'.tr,
                          ),
                          'value': controller.getTranslatedValue(
                            'addressDetails',
                            'Postal Code',
                            user.details?.personalDetails?.postalCode ?? '',
                          ),
                        },
                        {
                          'label': controller.getTranslatedLabel(
                            'addressDetails',
                            'Passport Number',
                            'Passport Number'.tr,
                          ),
                          'value': controller.getTranslatedValue(
                            'addressDetails',
                            'Passport Number',
                            user.details?.personalDetails?.passportNumber ?? '',
                          ),
                        },
                        {
                          'label': controller.getTranslatedLabel(
                            'addressDetails',
                            'Language',
                            'Language'.tr,
                          ),
                          'value': controller.getTranslatedValue(
                            'addressDetails',
                            'Language',
                            user.details?.personalDetails?.language ?? '',
                          ),
                        },
                      ],
              ),
              _sectionCard(
                context: context,
                icon: Icons.history_edu_outlined,
                title:
                    controller.translateDoc &&
                        controller.countryCode.value.isNotEmpty
                    ? controller.getTranslatedLabel(
                        'sections',
                        'Medical History',
                        'Medical History'.tr,
                      )
                    : 'Medical History'.tr,
                iconColor: Colors.purple[600],
                isLoading:
                    controller.translateDoc && controller.isTranslating.value,
                items: controller.translateDoc && controller.isTranslating.value
                    ? _createSkeletonData(6)
                    : [
                        {
                          'label': controller.getTranslatedLabel(
                            'medicalHistory',
                            'Conditions',
                            'Conditions'.tr,
                          ),
                          'value': controller.getTranslatedValue(
                            'medicalHistory',
                            'Conditions',
                            user.details?.medicalHistory?.medicalCondition ??
                                '',
                          ),
                        },
                        {
                          'label': controller.getTranslatedLabel(
                            'medicalHistory',
                            'Sickness History',
                            'Sickness History'.tr,
                          ),
                          'value': controller.getTranslatedValue(
                            'medicalHistory',
                            'Sickness History',
                            user.details?.medicalHistory?.sicknessHistory?.join(
                                  ', ',
                                ) ??
                                'None'.tr,
                          ),
                        },
                        {
                          'label': controller.getTranslatedLabel(
                            'medicalHistory',
                            'Surgeries',
                            'Surgeries'.tr,
                          ),
                          'value': controller.getTranslatedValue(
                            'medicalHistory',
                            'Surgeries',
                            user.details?.medicalHistory?.surgicalHistory?.join(
                                  ', ',
                                ) ??
                                'None'.tr,
                          ),
                        },
                        {
                          'label': controller.getTranslatedLabel(
                            'medicalHistory',
                            'Allergies',
                            'Allergies'.tr,
                          ),
                          'value': controller.getTranslatedValue(
                            'medicalHistory',
                            'Allergies',
                            user.details?.medicalHistory?.allergy?.join(', ') ??
                                'None'.tr,
                          ),
                        },
                        {
                          'label': controller.getTranslatedLabel(
                            'medicalHistory',
                            'Medications',
                            'Medications'.tr,
                          ),
                          'value': controller.getTranslatedValue(
                            'medicalHistory',
                            'Medications',
                            user.details?.medicalHistory?.medication ?? '',
                          ),
                        },
                        {
                          'label': controller.getTranslatedLabel(
                            'medicalHistory',
                            'Medication Types',
                            'Medication Types'.tr,
                          ),
                          'value': controller.getTranslatedValue(
                            'medicalHistory',
                            'Medication Types',
                            user.details?.medicalHistory?.medicationTypes?.join(
                                  ', ',
                                ) ??
                                'None'.tr,
                          ),
                        },
                      ],
              ),
              _sectionCard(
                context: context,
                icon: Icons.vaccines_outlined,
                title:
                    controller.translateDoc &&
                        controller.countryCode.value.isNotEmpty
                    ? controller.getTranslatedLabel(
                        'sections',
                        'Immunization History',
                        'Immunization History'.tr,
                      )
                    : 'Immunization History'.tr,
                iconColor: Colors.teal[600],
                isLoading:
                    controller.translateDoc && controller.isTranslating.value,
                items: controller.translateDoc && controller.isTranslating.value
                    ? _createSkeletonData(3)
                    : (user
                              .details
                              ?.vaccineHistory
                              ?.immunizationHistory
                              ?.isNotEmpty ??
                          false)
                    ? user.details!.vaccineHistory!.immunizationHistory!
                          .map(
                            (vaccine) => {
                              'label':
                                  controller.translateDoc &&
                                      controller.countryCode.value.isNotEmpty
                                  ? controller.getTranslatedValue(
                                      'immunizationLabels',
                                      vaccine.vaccines ?? '',
                                      (vaccine.vaccines ?? '').tr,
                                    )
                                  : (vaccine.vaccines ?? '').tr,
                              'value':
                                  controller.translateDoc &&
                                      controller.countryCode.value.isNotEmpty
                                  ? controller.getTranslatedValue(
                                      'immunizationData',
                                      '${vaccine.dateOfVaccine ?? ''} (Doses: ${vaccine.dosesReceived ?? 0})',
                                      '${vaccine.dateOfVaccine ?? ''} (${controller.getTranslatedLabel('sections', 'Doses', 'Doses'.tr)}: ${vaccine.dosesReceived ?? 0})',
                                    )
                                  : ('${vaccine.dateOfVaccine ?? ''} (Doses: ${vaccine.dosesReceived ?? 0})')
                                        .tr,
                            },
                          )
                          .toList()
                    : [
                        {
                          'label':
                              controller.translateDoc &&
                                  controller.countryCode.value.isNotEmpty
                              ? controller.getTranslatedLabel(
                                  'sections',
                                  'No immunization data',
                                  'No immunization data'.tr,
                                )
                              : 'No immunization data'.tr,
                          'value':
                              controller.translateDoc &&
                                  controller.countryCode.value.isNotEmpty
                              ? controller.getTranslatedLabel(
                                  'sections',
                                  'Available',
                                  'Available'.tr,
                                )
                              : 'Available'.tr,
                        },
                      ],
              ),
              _sectionCard(
                context: context,
                icon: Icons.self_improvement_outlined,
                title:
                    controller.translateDoc &&
                        controller.countryCode.value.isNotEmpty
                    ? controller.getTranslatedLabel(
                        'sections',
                        'Lifestyle Factors',
                        'Lifestyle Factors'.tr,
                      )
                    : 'Lifestyle Factors'.tr,
                iconColor: Colors.indigo[600],
                isLoading:
                    controller.translateDoc && controller.isTranslating.value,
                items: controller.translateDoc && controller.isTranslating.value
                    ? _createSkeletonData(4)
                    : [
                        {
                          'label': controller.getTranslatedLabel(
                            'lifestyle',
                            'Smoking',
                            'Smoking'.tr,
                          ),
                          'value': controller.getTranslatedValue(
                            'lifestyle',
                            'Smoking',
                            user.details?.lifestyleFactors?.smokingHabits ?? '',
                          ),
                        },
                        {
                          'label': controller.getTranslatedLabel(
                            'lifestyle',
                            'Alcohol',
                            'Alcohol'.tr,
                          ),
                          'value': controller.getTranslatedValue(
                            'lifestyle',
                            'Alcohol',
                            user
                                    .details
                                    ?.lifestyleFactors
                                    ?.alcoholConsumptions ??
                                '',
                          ),
                        },
                        {
                          'label': controller.getTranslatedLabel(
                            'lifestyle',
                            'Activity',
                            'Activity'.tr,
                          ),
                          'value': controller.getTranslatedValue(
                            'lifestyle',
                            'Activity',
                            user
                                    .details
                                    ?.lifestyleFactors
                                    ?.physicalActivityLevel ??
                                '',
                          ),
                        },
                        {
                          'label': controller.getTranslatedLabel(
                            'lifestyle',
                            'Preferences',
                            'Preferences'.tr,
                          ),
                          'value': controller.getTranslatedValue(
                            'lifestyle',
                            'Preferences',
                            user.details?.lifestyleFactors?.preferences ?? '',
                          ),
                        },
                      ],
              ),
              _sectionCard(
                context: context,
                icon: Icons.flight_takeoff_outlined,
                title:
                    controller.translateDoc &&
                        controller.countryCode.value.isNotEmpty
                    ? controller.getTranslatedLabel(
                        'sections',
                        'Travel Details',
                        'Travel Details'.tr,
                      )
                    : 'Travel Details'.tr,
                iconColor: Colors.cyan[600],
                isLoading:
                    controller.translateDoc && controller.isTranslating.value,
                items: controller.translateDoc && controller.isTranslating.value
                    ? _createSkeletonData(8)
                    : [
                        {
                          'label': controller.getTranslatedLabel(
                            'travelDetails',
                            'Arrived From',
                            'Arrived From'.tr,
                          ),
                          'value': controller.getTranslatedValue(
                            'travelDetails',
                            'Arrived From',
                            user.details?.travelDetails?.arriveFrom ?? '',
                          ),
                        },
                        {
                          'label': controller.getTranslatedLabel(
                            'travelDetails',
                            'Days Ago Arrived',
                            'Days Ago Arrived'.tr,
                          ),
                          'value': controller.getTranslatedValue(
                            'travelDetails',
                            'Days Ago Arrived',
                            user.details?.travelDetails?.daysAgoArrived ?? '',
                          ),
                        },
                        {
                          'label': controller.getTranslatedLabel(
                            'travelDetails',
                            'Days Stay',
                            'Days Stay'.tr,
                          ),
                          'value': controller.getTranslatedValue(
                            'travelDetails',
                            'Days Stay',
                            user.details?.travelDetails?.daysStay ?? '',
                          ),
                        },
                        {
                          'label': controller.getTranslatedLabel(
                            'travelDetails',
                            'Visited Countries',
                            'Visited Countries'.tr,
                          ),
                          'value': controller.getTranslatedValue(
                            'travelDetails',
                            'Visited Countries',
                            user.details?.travelDetails?.visitedCountries ?? '',
                          ),
                        },
                        {
                          'label': controller.getTranslatedLabel(
                            'travelDetails',
                            'Travel Reason',
                            'Travel Reason'.tr,
                          ),
                          'value': controller.getTranslatedValue(
                            'travelDetails',
                            'Travel Reason',
                            user.details?.travelDetails?.travelReason ?? '',
                          ),
                        },
                        {
                          'label': controller.getTranslatedLabel(
                            'travelDetails',
                            'Medical Insurance',
                            'Medical Insurance'.tr,
                          ),
                          'value': controller.getTranslatedValue(
                            'travelDetails',
                            'Medical Insurance',
                            user.details?.travelDetails?.medicalInsurance ?? '',
                          ),
                        },
                        {
                          'label': controller.getTranslatedLabel(
                            'travelDetails',
                            'Pregnant',
                            'Pregnant'.tr,
                          ),
                          'value': controller.getTranslatedValue(
                            'travelDetails',
                            'Pregnant',
                            user.details?.travelDetails?.pregnant ?? '',
                          ),
                        },
                        {
                          'label': controller.getTranslatedLabel(
                            'travelDetails',
                            'Nursing',
                            'Nursing'.tr,
                          ),
                          'value': controller.getTranslatedValue(
                            'travelDetails',
                            'Nursing',
                            user.details?.travelDetails?.nursing ?? '',
                          ),
                        },
                      ],
              ),
              if (user.details?.emergencyContacts?.isNotEmpty ?? false)
                _sectionCard(
                  context: context,
                  icon: Icons.contact_phone_outlined,
                  title:
                      controller.translateDoc &&
                          controller.countryCode.value.isNotEmpty
                      ? controller.getTranslatedLabel(
                          'sections',
                          'Emergency Contacts',
                          'Emergency Contacts'.tr,
                        )
                      : 'Emergency Contacts'.tr,
                  iconColor: Colors.pink[600],
                  isLoading:
                      controller.translateDoc && controller.isTranslating.value,
                  items:
                      controller.translateDoc && controller.isTranslating.value
                      ? _createSkeletonData(2)
                      : user.details?.emergencyContacts
                                ?.map(
                                  (contact) => {
                                    'label':
                                        controller.translateDoc &&
                                            controller
                                                .countryCode
                                                .value
                                                .isNotEmpty
                                        ? controller.getTranslatedValue(
                                            'personalDetails',
                                            'Name',
                                            (contact.nameOfEmergencyContact ??
                                                    '')
                                                .tr,
                                          )
                                        : (contact.nameOfEmergencyContact ?? '')
                                              .tr,
                                    'value':
                                        controller.translateDoc &&
                                            controller
                                                .countryCode
                                                .value
                                                .isNotEmpty
                                        ? ('${controller.getTranslatedValue('personalDetails', 'Relationship', contact.relationship ?? '')} - ${contact.phoneNumber ?? ''} (${contact.email ?? ''})')
                                        : ('${contact.relationship ?? ''} - ${contact.phoneNumber ?? ''} (${contact.email ?? ''})')
                                              .tr,
                                  },
                                )
                                .toList() ??
                            [],
                ),
              const SizedBox(height: 32),

              // Documents Section Header
              Text(
                controller.translateDoc &&
                        controller.countryCode.value.isNotEmpty
                    ? controller.getTranslatedLabel(
                        'sections',
                        'Documents & Forms',
                        'Documents & Forms'.tr,
                      )
                    : 'Documents & Forms'.tr,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(height: 16),

              // Upload Document Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
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
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.blue[50],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.cloud_upload_outlined,
                            color: Colors.blue[600],
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            controller.translateDoc &&
                                    controller.countryCode.value.isNotEmpty
                                ? controller.getTranslatedLabel(
                                    'sections',
                                    'Upload Document',
                                    'Upload Document'.tr,
                                  )
                                : 'Upload Document'.tr,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Color(0xFF0D47A1),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: controller.documentNameController,
                      decoration: InputDecoration(
                        labelText:
                            controller.translateDoc &&
                                controller.countryCode.value.isNotEmpty
                            ? controller.getTranslatedLabel(
                                'sections',
                                'Document Name',
                                'Document Name'.tr,
                              )
                            : 'Document Name'.tr,
                        prefixIcon: Icon(
                          Icons.description,
                          color: Colors.blue[600],
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: Colors.blue[600] ?? Colors.blue,
                            width: 2,
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.grey[50],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Obx(
                      () => GestureDetector(
                        onTap: controller.isUploading.value
                            ? null
                            : controller.selectFile,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: controller.selectedFile.value != null
                                ? Colors.blue[50]
                                : Colors.grey[50],
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: controller.selectedFile.value != null
                                  ? Colors.blue.shade300
                                  : Colors.grey.shade300,
                              style: BorderStyle.solid,
                            ),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                controller.selectedFile.value != null
                                    ? Icons.check_circle_outline
                                    : Icons.file_upload_outlined,
                                size: 48,
                                color: controller.selectedFile.value != null
                                    ? Colors.blue[600]
                                    : Colors.grey[400],
                              ),
                              const SizedBox(height: 12),
                              Text(
                                controller.selectedFile.value != null
                                    ? ((controller.translateDoc &&
                                                  controller
                                                      .countryCode
                                                      .value
                                                      .isNotEmpty
                                              ? controller.getTranslatedLabel(
                                                  'sections',
                                                  'File Selected',
                                                  'File Selected'.tr,
                                                )
                                              : 'File Selected'.tr) +
                                          ': ' +
                                          (controller.selectedFile.value?.path
                                                  ?.split('/')
                                                  .last ??
                                              'Unknown file'))
                                    : (controller.translateDoc &&
                                              controller
                                                  .countryCode
                                                  .value
                                                  .isNotEmpty
                                          ? controller.getTranslatedLabel(
                                              'sections',
                                              'Click to select file or drag and drop',
                                              'Click to select file or drag and drop'
                                                  .tr,
                                            )
                                          : 'Click to select file or drag and drop'
                                                .tr),
                                style: TextStyle(
                                  color: controller.selectedFile.value != null
                                      ? Colors.blue[600]
                                      : Colors.grey[600],
                                  fontSize: 14,
                                  fontWeight:
                                      controller.selectedFile.value != null
                                      ? FontWeight.w600
                                      : FontWeight.normal,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              if (controller.selectedFile.value == null) ...[
                                const SizedBox(height: 4),
                                Text(
                                  controller.translateDoc &&
                                          controller
                                              .countryCode
                                              .value
                                              .isNotEmpty
                                      ? controller.getTranslatedLabel(
                                          'sections',
                                          'PDF, DOC, JPG up to 10MB',
                                          'PDF, DOC, JPG up to 10MB'.tr,
                                        )
                                      : 'PDF, DOC, JPG up to 10MB'.tr,
                                  style: TextStyle(
                                    color: Colors.grey[500],
                                    fontSize: 12,
                                  ),
                                ),
                              ] else ...[
                                const SizedBox(height: 4),
                                Text(
                                  ((controller.translateDoc &&
                                              controller
                                                  .countryCode
                                                  .value
                                                  .isNotEmpty
                                          ? controller.getTranslatedLabel(
                                              'sections',
                                              'Size',
                                              'Size'.tr,
                                            )
                                          : 'Size'.tr) +
                                      ': ${controller.selectedFile.value != null ? controller.getFileSize(controller.selectedFile.value!) : '0 MB'}'),
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Obx(() {
                      if (controller.isUploading.value) {
                        return Column(
                          children: [
                            LinearProgressIndicator(
                              value: controller.uploadProgress.value,
                              backgroundColor: Colors.grey[300],
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.blue[600] ?? Colors.blue,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              ((controller.translateDoc &&
                                          controller
                                              .countryCode
                                              .value
                                              .isNotEmpty
                                      ? controller.getTranslatedLabel(
                                          'sections',
                                          'Uploading...',
                                          'Uploading...'.tr,
                                        )
                                      : 'Uploading...'.tr) +
                                  ' ' +
                                  '${(controller.uploadProgress.value * 100).toInt()}%'),
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 12),
                          ],
                        );
                      }
                      return const SizedBox.shrink();
                    }),
                    Obx(
                      () => Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: controller.isUploading.value
                                  ? null
                                  : controller.cancelUpload,
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                side: BorderSide(
                                  color: Colors.grey[400] ?? Colors.grey,
                                ),
                              ),
                              child: Text(
                                controller.translateDoc &&
                                        controller.countryCode.value.isNotEmpty
                                    ? controller.getTranslatedLabel(
                                        'sections',
                                        'Cancel',
                                        'Cancel'.tr,
                                      )
                                    : 'Cancel'.tr,
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: controller.isUploading.value
                                  ? null
                                  : controller.uploadFile,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: controller.isUploading.value
                                    ? Colors.grey[400]
                                    : Colors.blue[600],
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 0,
                              ),
                              child: controller.isUploading.value
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                              Colors.white,
                                            ),
                                      ),
                                    )
                                  : Text(
                                      controller.translateDoc &&
                                              controller
                                                  .countryCode
                                                  .value
                                                  .isNotEmpty
                                          ? controller.getTranslatedLabel(
                                              'sections',
                                              'Upload',
                                              'Upload'.tr,
                                            )
                                          : 'Upload'.tr,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
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
              const SizedBox(height: 20),

              // Documents List
              Skeletonizer(
                enabled:
                    controller.translateDoc && controller.isTranslating.value,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
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
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color:
                                  (user.details?.uploadDocuments?.isNotEmpty ??
                                      false)
                                  ? Colors.green[50]
                                  : Colors.grey[50],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              Icons.description_outlined,
                              color:
                                  (user.details?.uploadDocuments?.isNotEmpty ??
                                      false)
                                  ? Colors.green[600]
                                  : Colors.grey[400],
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller.translateDoc &&
                                          controller
                                              .countryCode
                                              .value
                                              .isNotEmpty
                                      ? controller.getTranslatedLabel(
                                          'sections',
                                          'Documents',
                                          'Documents'.tr,
                                        )
                                      : 'Documents'.tr,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Color(0xFF0D47A1),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  (user.details?.uploadDocuments?.isNotEmpty ??
                                          false)
                                      ? ('${user.details?.uploadDocuments?.length ?? 0} ' +
                                            (controller.translateDoc &&
                                                    controller
                                                        .countryCode
                                                        .value
                                                        .isNotEmpty
                                                ? controller.getTranslatedLabel(
                                                    'sections',
                                                    'document(s) available',
                                                    'document(s) available'.tr,
                                                  )
                                                : 'document(s) available'.tr))
                                      : (controller.translateDoc &&
                                                controller
                                                    .countryCode
                                                    .value
                                                    .isNotEmpty
                                            ? controller.getTranslatedLabel(
                                                'sections',
                                                'No documents found',
                                                'No documents found'.tr,
                                              )
                                            : 'No documents found'.tr),
                                  style: TextStyle(
                                    color:
                                        (user
                                                .details
                                                ?.uploadDocuments
                                                ?.isNotEmpty ??
                                            false)
                                        ? Colors.green[600]
                                        : Colors.grey[500],
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if ((user.details?.uploadDocuments?.isNotEmpty ??
                              false))
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.grey[400],
                              size: 16,
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Submitted Forms
              Skeletonizer(
                enabled:
                    controller.translateDoc && controller.isTranslating.value,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
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
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.red[50],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.assignment_turned_in_outlined,
                          color: Colors.red[600],
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.translateDoc &&
                                      controller.countryCode.value.isNotEmpty
                                  ? controller.getTranslatedLabel(
                                      'sections',
                                      'Submitted Forms',
                                      'Submitted Forms'.tr,
                                    )
                                  : 'Submitted Forms'.tr,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Color(0xFF0D47A1),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              controller.translateDoc &&
                                      controller.countryCode.value.isNotEmpty
                                  ? controller.getTranslatedLabel(
                                      'sections',
                                      'No forms assigned to this patient',
                                      'No forms assigned to this patient'.tr,
                                    )
                                  : 'No forms assigned to this patient'.tr,
                              style: TextStyle(
                                color: Colors.red[600],
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        );
      }),
    );
  }
}
