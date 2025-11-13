import 'package:medi/app/core/helper/shared_value_helper.dart';
import 'package:medi/app/data/remote/model/chat/chat_data_response.dart';
import 'package:medi/app/data/remote/model/chat/chat_response.dart';
import 'package:medi/app/data/remote/model/user/ambulance_data_response.dart';
import 'package:medi/app/data/remote/model/user/user_data_response.dart';
import 'package:medi/app/network_service/api_client.dart';
import 'package:medi/app/network_service/api_end_points.dart';

import '../../model/chat/chat_list_response.dart';
import '../../model/user/chat_patient_list_response.dart';
import '../../model/user/patient_data_response.dart';

class ChatRepository {
  // Helper method to build userContext from user data
  Map<String, dynamic> _buildUserContext(UserFilteredData? userData) {
    if (userData == null || userData.details == null) {
      return {
        "medicalHistory": [],
        "medications": [],
        "allergies": [],
        "age": 0,
        "gender": gender.$,
      };
    }

    final details = userData.details!;
    final medicalHistory = details.medicalHistory;
    final personalDetails = details.personalDetails;

    return {
      "medicalHistory": medicalHistory?.sicknessHistory ?? [],
      "medications": medicalHistory?.medicationTypes ?? [],
      "allergies": medicalHistory?.allergy ?? [],
      "age": personalDetails?.age != null
          ? int.tryParse(personalDetails!.age!) ?? 0
          : 0,
      "gender": personalDetails?.gender ?? gender.$,
    };
  }

  // Helper method to build patient details string for first message
  String _buildPatientDetailsString(UserFilteredData? userData) {
    if (userData == null || userData.details == null) {
      return "";
    }

    final details = userData.details!;
    final personal = details.personalDetails;
    final medical = details.medicalHistory;
    final lifestyle = details.lifestyleFactors;
    final vaccine = details.vaccineHistory;

    final buffer = StringBuffer("Patient details:\n");

    // Personal details
    if (personal != null) {
      if (personal.firstName != null) buffer.write("Name: ${personal.firstName}\n");
      if (personal.age != null) buffer.write("Age: ${personal.age}\n");
      if (personal.gender != null) buffer.write("Gender: ${personal.gender}\n");
      if (personal.bloodType != null) buffer.write("Blood Type: ${personal.bloodType}\n");
    }

    // Lifestyle factors
    if (lifestyle != null) {
      buffer.write("\nLifestyle Factors:\n");
      if (lifestyle.smokingHabits != null) buffer.write("Smoking: ${lifestyle.smokingHabits}\n");
      if (lifestyle.alcoholConsumptions != null) buffer.write("Alcohol: ${lifestyle.alcoholConsumptions}\n");
      if (lifestyle.physicalActivityLevel != null) buffer.write("Physical Activity: ${lifestyle.physicalActivityLevel}\n");
    }

    // Medical history
    if (medical != null) {
      buffer.write("\nMedical History:\n");
      if (medical.medicalCondition != null) buffer.write("Conditions: ${medical.medicalCondition}\n");
      if (medical.sicknessHistory != null && medical.sicknessHistory!.isNotEmpty) {
        buffer.write("Sickness History: ${medical.sicknessHistory!.join(', ')}\n");
      }
      if (medical.surgicalHistory != null && medical.surgicalHistory!.isNotEmpty) {
        buffer.write("Surgical History: ${medical.surgicalHistory!.join(', ')}\n");
      }
      if (medical.allergy != null && medical.allergy!.isNotEmpty) {
        buffer.write("Allergies: ${medical.allergy!.join(', ')}\n");
      }
      if (medical.medicationTypes != null && medical.medicationTypes!.isNotEmpty) {
        buffer.write("Medications: ${medical.medicationTypes!.join(', ')}\n");
      }
    }

    // Vaccine history
    if (vaccine != null && vaccine.immunizationHistory != null && vaccine.immunizationHistory!.isNotEmpty) {
      buffer.write("\nVaccine History:\n");
      for (var immunization in vaccine.immunizationHistory!) {
        if (immunization.vaccines != null) {
          buffer.write("${immunization.vaccines}");
          if (immunization.dateOfVaccine != null) {
            buffer.write(" (${immunization.dateOfVaccine})");
          }
          buffer.write("\n");
        }
      }
    }

    buffer.write("\nPatient Message: ");
    return buffer.toString();
  }

  Future<ChatResponse> sendChatMessage(
    String message,
    String threadId, {
    UserFilteredData? userData,
    bool isFirstMessage = false,
  }) async {
    // Build userContext from actual user data
    final userContext = _buildUserContext(userData);

    // If first message, prepend patient details
    final finalMessage = isFirstMessage && userData != null
        ? "${_buildPatientDetailsString(userData)}$message"
        : message;

    var response = await ApiClient(customBaseUrl: 'https://mediai.tech/api/')
        .post(
          ApiEndPoints.sendMessage,
          {
            "msg": finalMessage,
            "lang": selectedLanguage.$,
            "role": userRole.$,
            "use_claude": false,
            "userContext": userContext,
            if (threadId.isNotEmpty) "thread_id": threadId,
          },
          sendChatMessage,
          isHeaderRequired: true,
          isLoaderRequired: false,
        );
    return safeFromJson(
      response,
      (json) => ChatResponse.fromJson(json),
      ChatResponse(
        message: '',
        success: false,
        data: Data(user: '', qtn: '', message: '', threadId: ''),
      ),
    );
  }

  // Deprecated: Old method signature for backward compatibility
  @Deprecated('Use sendChatMessage with userData parameter')
  Future<ChatResponse> sendChatMessageOld(String message, String threadId) async {
    var response = await ApiClient(customBaseUrl: 'https://mediai.tech/api/')
        .post(
          ApiEndPoints.sendMessage,
          {
            "msg": message,
            "lang": selectedLanguage.$,
            "role": userRole.$,
            "use_claude": false,
            "userContext": {
              "medicalHistory": [],
              "medications": [],
              "allergies": [],
              "age": 0,
              "gender": gender.$,
            },
            if (threadId.isNotEmpty) "thread_id": threadId,
          },
          sendChatMessage,
          isHeaderRequired: true,
          isLoaderRequired: false,
        );
    return safeFromJson(
      response,
      (json) => ChatResponse.fromJson(json),
      ChatResponse(
        message: '',
        success: false,
        data: Data(user: '', qtn: '', message: '', threadId: ''),
      ),
    );
  }

  Future<List<ChatListResponse>> getChatList() async {
    var response = await ApiClient(customBaseUrl: 'https://mediai.tech/api/')
        .get(
          ApiEndPoints.chatList,
          getChatList,
          isHeaderRequired: true,
          isLoaderRequired: true,
        );
    // Assuming response is a List<dynamic>
    return (response as List)
        .map((json) => ChatListResponse.fromJson(json))
        .toList();
  }

  Future<ChatDataResponse> getChatData(
    String senderId,
    String receiverId,
  ) async {
    var response =
        await ApiClient(
          customBaseUrl:
              'https://mediai'
              '.tech/api/chat/',
        ).post(
          ApiEndPoints.chatData,
          {
            "filter": {"sender": senderId, "receiver": receiverId},
          },
          getChatList,
          isHeaderRequired: true,
          isLoaderRequired: true,
        );
    // Assuming response is a List<dynamic>
    return safeFromJson(
      response,
      (json) => ChatDataResponse.fromJson(json),
      ChatDataResponse(),
    );
  }

  Future<PatientChatListResponse> getPatientListForChat() async {
    var response = await ApiClient().post(
      ApiEndPoints.userData,
      {
        "filter": {
          "role": 'patient',
          "requestDetails"
                  ".userId":
              userId.$,
        },
      },
      getPatientListForChat,
      isHeaderRequired: true,
      isLoaderRequired: true,
    );
    return safeFromJson(
      response,
      (json) => PatientChatListResponse.fromJson(json),
      PatientChatListResponse(message: '', success: false, data: []),
    );
  }
}
