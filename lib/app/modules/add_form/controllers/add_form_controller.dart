import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medi/app/core/helper/app_widgets.dart';
import 'package:medi/app/core/helper/print_log.dart';
import 'package:medi/app/core/style/app_colors.dart';
import 'package:medi/app/data/remote/repository/form/form_repository.dart';

class AddFormController extends GetxController {
  // Form title controller
  final formTitleController = TextEditingController();

  // Questions list - each question is a Map with label, question, type, and options
  final questions = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize with one default question
    addQuestion();
  }

  @override
  void onClose() {
    formTitleController.dispose();
    super.onClose();
  }

  // Add a new question to the form
  void addQuestion() {
    questions.add({
      'label': '',
      'question': '',
      'type': 'text', // Default to text type
      'options': <String>[], // For MCQ options
    });
  }

  // Remove a question from the form
  void removeQuestion(int index) {
    if (questions.length > 1 && index >= 0 && index < questions.length) {
      questions.removeAt(index);
    }
  }

  // Update question label
  void updateQuestionLabel(int index, String label) {
    if (index >= 0 && index < questions.length) {
      questions[index]['label'] = label;
      questions.refresh();
    }
  }

  // Update question text
  void updateQuestionText(int index, String questionText) {
    if (index >= 0 && index < questions.length) {
      questions[index]['question'] = questionText;
      questions.refresh();
    }
  }

  // Update question type
  void updateQuestionType(int index, String type) {
    if (index >= 0 && index < questions.length) {
      questions[index]['type'] = type;

      // Initialize options based on type
      if (type == 'mcq') {
        questions[index]['options'] = ['Option 1', 'Option 2'];
      } else if (type == 'yesandno') {
        questions[index]['options'] = ['yes', 'no'];
      } else {
        questions[index]['options'] = ['text'];
      }

      questions.refresh();
    }
  }

  // Add MCQ option
  void addMCQOption(int questionIndex) {
    if (questionIndex >= 0 && questionIndex < questions.length) {
      final options = questions[questionIndex]['options'] as List<String>;
      options.add('Option ${options.length + 1}');
      questions.refresh();
    }
  }

  // Remove MCQ option
  void removeMCQOption(int questionIndex, int optionIndex) {
    if (questionIndex >= 0 && questionIndex < questions.length) {
      final options = questions[questionIndex]['options'] as List<String>;
      if (options.length > 1 &&
          optionIndex >= 0 &&
          optionIndex < options.length) {
        options.removeAt(optionIndex);
        questions.refresh();
      }
    }
  }

  // Update MCQ option
  void updateMCQOption(int questionIndex, int optionIndex, String value) {
    if (questionIndex >= 0 && questionIndex < questions.length) {
      final options = questions[questionIndex]['options'] as List<String>;
      if (optionIndex >= 0 && optionIndex < options.length) {
        options[optionIndex] = value;
        questions.refresh();
      }
    }
  }

  // Validate form
  bool _validateForm() {
    if (formTitleController.text.trim().isEmpty) {
      Get.snackbar(
        'Validation Error'.tr,
        'Please enter a form title'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }

    for (int i = 0; i < questions.length; i++) {
      final question = questions[i];

      if (question['label'].toString().trim().isEmpty) {
        Get.snackbar(
          'Validation Error'.tr,
          'Please enter a label for question ${i + 1}'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return false;
      }

      if (question['question'].toString().trim().isEmpty) {
        Get.snackbar(
          'Validation Error'.tr,
          'Please enter question text for question ${i + 1}'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return false;
      }

      // Validate MCQ options
      if (question['type'] == 'mcq') {
        final options = question['options'] as List<String>;
        if (options.length < 2) {
          Get.snackbar(
            'Validation Error'.tr,
            'Question ${i + 1} must have at least 2 options'.tr,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
          return false;
        }

        for (int j = 0; j < options.length; j++) {
          if (options[j].trim().isEmpty) {
            Get.snackbar(
              'Validation Error'.tr,
              'Please fill option ${j + 1} for question ${i + 1}'.tr,
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
            return false;
          }
        }
      }
    }

    return true;
  }

  // Save form as draft
  void saveForm() {
    if (!_validateForm()) return;

    // Show loading
    Get.snackbar(
      'Saving'.tr,
      'Saving form as draft...'.tr,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.blue,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );

    // TODO: Implement actual save to draft functionality
    printLog('=== SAVING FORM AS DRAFT ===');
    printLog('Form Title: ${formTitleController.text}');
    printLog('Questions: ${questions.length}');

    for (int i = 0; i < questions.length; i++) {
      final question = questions[i];
      printLog('Question ${i + 1}:');
      printLog('  Label: ${question['label']}');
      printLog('  Question: ${question['question']}');
      printLog('  Type: ${question['type']}');
      printLog('  Options: ${question['options']}');
    }

    Get.snackbar(
      'Success'.tr,
      'Form saved as draft successfully'.tr,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  // Confirm and submit form
  void confirmForm() {
    if (!_validateForm()) return;

    // Show confirmation dialog
    Get.dialog(
      AlertDialog(
        title: Text('Confirm Form Creation'.tr),
        content: Text(
          'Are you sure you want to create this form with ${questions.length} questions?'
              .tr,
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: Text('Cancel'.tr)),
          ElevatedButton(
            onPressed: () {
              Get.back();
              _submitForm();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryAccentColor,
              foregroundColor: Colors.white,
            ),
            child: Text('Confirm'.tr),
          ),
        ],
      ),
    );
  }

  // Submit form to API
  void _submitForm() async {
    try {
      printLog('=== SUBMITTING FORM ===');
      printLog('Form Title: ${formTitleController.text}');
      printLog('Questions: ${questions.length}');

      // Prepare form data for API according to the specified format
      final body = {
        'title': formTitleController.text.trim(),
        'fields': questions
            .map(
              (question) => {
                'label': question['label'].toString().trim(),
                'question': question['question'].toString().trim(),
                'type': question['type'],
                'options': question['options'],
              },
            )
            .toList(),
        'userId': '67c4345e76c0916ac59c4d2c', // TODO: Get from user session
        'language': 'en', // Default to English
      };

      printLog('Form Data: $body');

      // Call API to create form
     await FormRepository().createForm(body);
      Get.back();

      AppWidgets().getSnackBar(
        title: 'Success'.tr,
        message: 'Form created successfully!'.tr,
      );

    } catch (e) {
      printLog('Error creating form: $e');
      Get.snackbar(
        'Error'.tr,
        'Failed to create form: ${e.toString()}'.tr,
      );
    }
  }

  // Reset form
  void resetForm() {
    formTitleController.clear();
    questions.clear();
    addQuestion(); // Add default question
  }
}
