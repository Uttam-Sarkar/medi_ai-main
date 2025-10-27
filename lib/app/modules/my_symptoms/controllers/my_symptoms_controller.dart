import 'dart:convert';
import 'package:get/get.dart';
import '../../../core/helper/dialog_helper.dart';
import '../../../core/helper/print_log.dart';
import '../../../core/helper/shared_value_helper.dart';
import '../../../data/remote/repository/chat/chat_repository.dart';
import '../../../routes/app_pages.dart';
import '../../home/controllers/home_controller.dart';
import '../../../data/remote/model/user/user_data_response.dart';
import 'package:flutter/material.dart';

class MySymptomsController extends GetxController {
  late HomeController homeController;
  bool _isFirstMessage = true;
  final threadId = ''.obs;
  final speciality = [].obs;

  @override
  void onInit() {
    super.onInit();
    homeController = Get.find<HomeController>();
    messages.addAll([
      {
        'text': 'chatbox.greeting'.trParams({'userName': userName.$}),
        'isUser': false,
        'time': DateTime.now(),
      },
    ]);
  }

  UserFilteredData? get currentUser {
    if (homeController.userData.isNotEmpty) {
      return homeController.userData.first;
    }
    return null;
  }

  final TextEditingController messageController = TextEditingController();
  final RxList<Map<String, dynamic>> messages = <Map<String, dynamic>>[].obs;
  final RxBool isTyping = false.obs;

  @override
  void onClose() {
    messageController.dispose();
    super.onClose();
  }

  void sendMessage(BuildContext context) async {
    final message = messageController.text.trim();
    if (message.isNotEmpty) {
      messages.add({'text': message, 'isUser': true, 'time': DateTime.now()});
      messageController.clear();

      // Show typing indicator
      isTyping.value = true;

      // Only format the first message with patient details
      final messageToSend = _isFirstMessage
          ? _formatPatientDetailsMessage(message)
          : message;

      var response = await ChatRepository().sendChatMessage(
        messageToSend,
        threadId.value,
      );
      threadId.value = response.data?.threadId ?? threadId.value;
      // Hide typing indicator
      isTyping.value = false;

      if (response.success!) {
        String extractMessageAnswer(String jsonString) {
          final Map<String, dynamic> data = json.decode(jsonString);
          printLog(data);
          return data['answer'] ?? '';
        }

        String extractMessageSpeciality(String jsonString) {
          final Map<String, dynamic> data = json.decode(jsonString);
          printLog(data);
          return data['speciality'] ?? '';
        }

        var data = extractMessageSpeciality(response.data!.message.toString());

        if (data.trim().isNotEmpty) {
          speciality.add(
            extractMessageSpeciality(response.data!.message.toString()),
          );
        }

        messages.add({
          'text': extractMessageAnswer(response.data!.message.toString()),
          'isUser': false,
          'time': DateTime.now(),
        });
      }

      // Mark that first message has been sent

      if (speciality.isNotEmpty) {
        DialogHelper().customDialogBox(
          context,
          'Nearby Hospitals'.tr,
          leftButtonOnTap: () {
            Get.back();
          },
          rightButtonOnTap: () async {
            Get.back();
            await Get.find<HomeController>().getUserLocation();
            await Get.find<HomeController>()
                .getHospitalData(speciality)
                .then((_) {
              Get.toNamed(Routes.HOSPITAL);
            });
          },
        );
      }
      _isFirstMessage = false;
    }
  }

  String _formatPatientDetailsMessage(String userMessage) {
    final user = currentUser;
    if (user == null) {
      return userMessage;
    }

    final details = user.details;
    final personalDetails = details?.personalDetails;
    final lifestyleFactors = details?.lifestyleFactors;
    final medicalHistory = details?.medicalHistory;
    final vaccineHistory = details?.vaccineHistory;

    // Format lists to comma-separated strings - handle nullable lists
    String formatListSafe(List<dynamic>? list) {
      return list?.isEmpty ?? true ? '' : list!.join(', ');
    }

    // Get immunization history
    String immunizationInfo = '';
    if (vaccineHistory?.immunizationHistory?.isNotEmpty == true) {
      final latest = vaccineHistory!.immunizationHistory!.first;
      immunizationInfo = '${latest.vaccines} (${latest.dateOfVaccine})';
    }

    return '''Patient details: patient name: ${personalDetails?.firstName ?? ''}, patient gender: ${personalDetails?.gender ?? ''}, patient weight: ${personalDetails?.weight ?? ''}, patient age: ${personalDetails?.age ?? ''}, patient Blood Group: ${personalDetails?.bloodType ?? ''}, patient life style factors, smoking habits: ${lifestyleFactors?.smokingHabits ?? ''},
alcohol consumptions: ${lifestyleFactors?.alcoholConsumptions ?? ''},
physical activity level: ${lifestyleFactors?.physicalActivityLevel ?? ''},
preferences: ${lifestyleFactors?.preferences ?? ''}, medical history, medical condition: ${medicalHistory?.medicalCondition ?? ''},
sickness history: ${formatListSafe(medicalHistory?.sicknessHistory)},
surgical history: ${formatListSafe(medicalHistory?.surgicalHistory)},
allergy: ${formatListSafe(medicalHistory?.allergy)},
medication: ${medicalHistory?.medication ?? null},
medication types: ${formatListSafe(medicalHistory?.medicationTypes)},
custom input medications: ${formatListSafe(medicalHistory?.customInputMedications)}, vaccine history, received covid vaccine: ${vaccineHistory?.immunizationHistory?.isNotEmpty == true ? vaccineHistory!.immunizationHistory!.first.hasReceivedCovidVaccine : ''},
doses received: ${vaccineHistory?.immunizationHistory?.isNotEmpty == true ? vaccineHistory!.immunizationHistory!.first.dosesReceived : ''},
time since last vaccination: ${vaccineHistory?.immunizationHistory?.isNotEmpty == true ? vaccineHistory!.immunizationHistory!.first.timeSinceLastVaccination : ''},
immunization history: ${immunizationInfo}\n\nPatient Message: $userMessage''';
  }

  String formatList(List<String>? list) {
    if (list?.isEmpty ?? true) {
      return '';
    }
    return list!.join(', ');
  }
}
