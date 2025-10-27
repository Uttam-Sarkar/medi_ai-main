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
  Future<ChatResponse> sendChatMessage(String message, String threadId) async {
    var response = await ApiClient(customBaseUrl: 'https://mediai.tech/api/')
        .post(
          ApiEndPoints.sendMessage,
          {
            "msg": message,
            "lang": selectedLanguage.$,
            "role": userRole.$,
            "thread_id": threadId,
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
