import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medi/app/core/helper/print_log.dart';
import 'package:medi/app/data/remote/repository/form/form_repository.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../data/remote/model/form/all_forms_response.dart';

class FormController extends GetxController {
  final formList = <AllFormsResponse>[].obs;

  @override
  void onInit() {
    super.onInit();
    getFormData();
  }

  Future<void> getFormData() async {
    try {
      formList.clear();
      // Get list of forms from repository
      List<AllFormsResponse> response = await FormRepository().getAllForm();

      formList.addAll(response);

      // Log all form information
      printLog('=== API Response ===');
      printLog('Total Forms Received: ${response.length}');

      for (int i = 0; i < formList.length; i++) {
        final form = formList[i];
        printLog('=== Form ${i + 1} ===');
        printLog('Form Title: ${form.title}');
        printLog('Form ID: ${form.id}');
        printLog('Created By: ${form.createdBy}');
        printLog('Created At: ${form.createdAt}');
        printLog('Language: ${form.language}');
        printLog('Fields Count: ${form.fields?.length ?? 0}');

        form.fields?.forEach((field) {
          printLog('  Field Label: ${field.label}');
          printLog('  Field Type: ${field.type}');
          printLog('  Field Question: ${field.question}');
          printLog('  Field Options: ${field.options}');
        });
      }

      printLog('Total Forms in List: ${formList.length}');
    } catch (e) {
      printLog('Error loading forms: $e');
    }
  }

  // Get total questions count for a form
  int getQuestionsCount(AllFormsResponse form) {
    return form.fields?.length ?? 0;
  }

  // Get form creation date formatted
  String getFormattedDate(String? dateString) {
    if (dateString == null) return 'Unknown date';
    try {
      final date = DateTime.parse(dateString);
      return '${date.day}/${date.month}/${date.year}';
    } catch (e) {
      return 'Unknown date';
    }
  }

  // Send form functionality
  void sendForm(AllFormsResponse form) {
    // TODO: Implement actual send form API call
    printLog('Sending form: ${form.title}');
  }

  // Download form as text file functionality
  Future<void> downloadFormPDF(AllFormsResponse form) async {
    try {
      // Request storage permission for Android
      if (Platform.isAndroid) {
        var status = await Permission.storage.status;
        if (!status.isGranted) {
          status = await Permission.storage.request();
          if (!status.isGranted) {
            Get.snackbar(
              'Permission Denied'.tr,
              'Storage permission is required to download file'.tr,
              snackPosition: SnackPosition.BOTTOM,
            );
            return;
          }
        }
      }

      // Show loading
      Get.snackbar(
        'Generating File'.tr,
        'Please wait while we generate your form file...'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.blue,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );

      // Create form content as text
      String formContent = _generateFormContent(form);

      // Get download directory
      Directory? downloadDir;
      if (Platform.isAndroid) {
        downloadDir = Directory('/storage/emulated/0/Download');
        if (!await downloadDir.exists()) {
          downloadDir = await getExternalStorageDirectory();
        }
      } else if (Platform.isIOS) {
        downloadDir = await getApplicationDocumentsDirectory();
      } else {
        downloadDir = await getDownloadsDirectory();
      }

      if (downloadDir != null) {
        final fileName =
            '${form.title?.replaceAll(' ', '_') ?? 'form'}_${DateTime.now().millisecondsSinceEpoch}.txt';
        final file = File('${downloadDir.path}/$fileName');

        await file.writeAsString(formContent);

        Get.snackbar(
          'File Downloaded'.tr,
          'Form saved to Downloads folder: $fileName'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );

        printLog('Form file saved to: ${file.path}');
      } else {
        throw Exception('Could not access download directory');
      }
    } catch (e) {
      printLog('Error generating file: $e');
      Get.snackbar(
        'Download Failed'.tr,
        'Failed to generate file: ${e.toString()}'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // Generate form content as text
  String _generateFormContent(AllFormsResponse form) {
    StringBuffer content = StringBuffer();

    content.writeln('=== FORM DETAILS ===');
    content.writeln('Title: ${form.title ?? 'Untitled'}');
    content.writeln('Form ID: ${form.id ?? 'Unknown'}');
    content.writeln('Language: ${form.language ?? 'Unknown'}');
    content.writeln('Created By: ${form.createdBy ?? 'Unknown'}');
    content.writeln('Created Date: ${getFormattedDate(form.createdAt)}');
    content.writeln('Total Questions: ${getQuestionsCount(form)}');
    content.writeln('');

    if (form.fields != null && form.fields!.isNotEmpty) {
      content.writeln('=== FORM QUESTIONS ===');
      content.writeln('');

      for (int i = 0; i < form.fields!.length; i++) {
        final field = form.fields![i];
        content.writeln('Question ${i + 1}: ${field.label ?? 'Untitled'}');
        content.writeln('Type: ${field.type ?? 'text'}');

        if (field.question != null && field.question!.isNotEmpty) {
          content.writeln('Question Text: ${field.question}');
        }

        if (field.options != null && field.options!.isNotEmpty) {
          content.writeln('Available Options:');
          for (String option in field.options!) {
            content.writeln('  - $option');
          }
        }

        content.writeln('Field ID: ${field.id ?? 'Unknown'}');
        content.writeln('');
      }
    }

    content.writeln('Generated on: ${DateTime.now().toString()}');
    content.writeln('Generated by: MediAi App');

    return content.toString();
  }

  // Delete form functionality
  void deleteForm(int index) {
    if (index >= 0 && index < formList.length) {
      final form = formList[index];

      var response = FormRepository().deleteForm(form.id ?? '');
      if (response != null) {
        Get.back();
        Get.snackbar('Success'.tr, 'Form deleted successfully'.tr);
        getFormData();
      }
    }
  }

  // Refresh forms
  Future<void> refreshForms() async {
    await getFormData();
  }
}
