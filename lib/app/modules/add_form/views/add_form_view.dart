import 'package:flutter/material.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:get/get.dart';
import 'package:medi/app/core/custom_widgets/global_appbar.dart';
import '../../../core/style/app_colors.dart';

import '../controllers/add_form_controller.dart';

class AddFormView extends GetView<AddFormController> {
  const AddFormView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: globalAppBar(context, 'Create Form'.tr),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header Section with Description
              Container(
                width: double.infinity,
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E3A8A), // Dark blue
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Create a new form'.tr,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Introducing our interactive symptom assessment and questioning feature which leverages AI technology to enhance the information-gathering process.'
                                .tr,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white70,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Decorative elements
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Form Content
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Form Title
                    Text(
                      'Form Title :'.tr,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
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
                          controller: controller.formTitleController,
                          decoration: const InputDecoration(
                            labelText: 'Enter form title',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 12,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Dynamic Questions List
                    Obx(
                      () => Column(
                        children: controller.questions.asMap().entries.map((
                          entry,
                        ) {
                          final index = entry.key;
                          final question = entry.value;
                          return _buildQuestionCard(question, index);
                        }).toList(),
                      ),
                    ),

                    // Add Question Button
                    const SizedBox(height: 16),
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xFF1E3A8A),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TextButton.icon(
                          onPressed: controller.addQuestion,
                          icon: const Icon(Icons.add, color: Color(0xFF1E3A8A)),
                          label: Text(
                            'Add Question'.tr,
                            style: const TextStyle(
                              color: Color(0xFF1E3A8A),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Create Form Button (Login Button Style)
                    SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: ElevatedButton(
                        onPressed: controller.confirmForm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryAccentColor,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'Create Form'.tr,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionCard(Map<String, dynamic> question, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: ClayContainer(
        color: Colors.white,
        borderRadius: 16,
        depth: 8,
        spread: 2,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Question Header with Remove Button
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Question ${index + 1}:'.tr,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  if (controller.questions.length > 1)
                    IconButton(
                      onPressed: () => controller.removeQuestion(index),
                      icon: const Icon(
                        Icons.close,
                        color: Colors.red,
                        size: 20,
                      ),
                    ),
                ],
              ),

              const SizedBox(height: 12),

              // Label Input
              Text(
                'Label:'.tr,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 6),
              ClayContainer(
                color: AppColors.primaryColor,
                borderRadius: 8,
                depth: 12,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: TextField(
                    onChanged: (value) =>
                        controller.updateQuestionLabel(index, value),
                    decoration: const InputDecoration(
                      labelText: 'Enter question label',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 12),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Question Input
              Text(
                'Question:'.tr,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 6),
              ClayContainer(
                color: AppColors.primaryColor,
                borderRadius: 8,
                depth: 12,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: TextField(
                    onChanged: (value) =>
                        controller.updateQuestionText(index, value),
                    decoration: const InputDecoration(
                      labelText: 'Enter your question',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 12),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Select Answer Type
              Text(
                'Select Answer Type'.tr,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),

              // Answer Type Options
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildAnswerTypeOption(
                    'Text',
                    'text',
                    Icons.text_fields,
                    Colors.blue[100]!,
                    Colors.blue,
                    question['type'] == 'text',
                    index,
                  ),
                  _buildAnswerTypeOption(
                    'Yes Or No',
                    'yesandno',
                    Icons.check_circle,
                    Colors.green[100]!,
                    Colors.green,
                    question['type'] == 'yesandno',
                    index,
                  ),
                  _buildAnswerTypeOption(
                    'Multiple Choices',
                    'mcq',
                    Icons.list,
                    Colors.orange[100]!,
                    Colors.orange,
                    question['type'] == 'mcq',
                    index,
                  ),
                ],
              ),

              // Answer Fields based on question type
              if (question['type'] == 'text') ...[
                const SizedBox(height: 16),
                Text(
                  'Answer Field:'.tr,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
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
                      readOnly: true,
                      decoration: const InputDecoration(
                        labelText: 'Text input field for user answer',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 12),
                      ),
                    ),
                  ),
                ),
              ] else if (question['type'] == 'yesandno') ...[
                const SizedBox(height: 16),
                Text(
                  'Answer Options:'.tr,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: ClayContainer(
                        color: AppColors.primaryColor,
                        borderRadius: 8,
                        depth: 12,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: TextField(
                            readOnly: true,
                            decoration: const InputDecoration(
                              labelText: 'Yes',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ClayContainer(
                        color: AppColors.primaryColor,
                        borderRadius: 8,
                        depth: 12,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: TextField(
                            readOnly: true,
                            decoration: const InputDecoration(
                              labelText: 'No',
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
              ] else if (question['type'] == 'mcq') ...[
                const SizedBox(height: 16),
                Text(
                  'Multiple Choice Options:'.tr,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                ...((question['options'] as List<String>?) ?? [])
                    .asMap()
                    .entries
                    .map((entry) {
                      final optionIndex = entry.key;
                      final option = entry.value;
                      return Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: [
                            Expanded(
                              child: ClayContainer(
                                color: AppColors.primaryColor,
                                borderRadius: 8,
                                depth: 12,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 2,
                                  ),
                                  child: TextField(
                                    controller: TextEditingController(
                                      text: option,
                                    ),
                                    onChanged: (value) =>
                                        controller.updateMCQOption(
                                          index,
                                          optionIndex,
                                          value,
                                        ),
                                    decoration: InputDecoration(
                                      labelText: 'Option ${optionIndex + 1}',
                                      border: InputBorder.none,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                            horizontal: 12,
                                          ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () => controller.removeMCQOption(
                                index,
                                optionIndex,
                              ),
                              icon: const Icon(
                                Icons.remove_circle,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                TextButton.icon(
                  onPressed: () => controller.addMCQOption(index),
                  icon: const Icon(Icons.add, size: 16),
                  label: Text('Add Option'.tr),
                  style: TextButton.styleFrom(
                    foregroundColor: const Color(0xFF1E3A8A),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnswerTypeOption(
    String title,
    String type,
    IconData icon,
    Color backgroundColor,
    Color iconColor,
    bool isSelected,
    int questionIndex,
  ) {
    return GestureDetector(
      onTap: () => controller.updateQuestionType(questionIndex, type),
      child: Container(
        width: 90,
        height: 100,
        decoration: BoxDecoration(
          color: isSelected ? backgroundColor : Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? iconColor : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isSelected
                    ? iconColor.withOpacity(0.2)
                    : Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: isSelected ? iconColor : Colors.grey[600],
                size: 24,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title.tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? iconColor : Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

