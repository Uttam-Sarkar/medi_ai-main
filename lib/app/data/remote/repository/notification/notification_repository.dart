import 'package:medi/app/core/helper/shared_value_helper.dart';
import 'package:medi/app/data/remote/model/default_model.dart';
import 'package:medi/app/data/remote/model/notification/notifications_response.dart';
import 'package:medi/app/network_service/api_client.dart';
import 'package:medi/app/network_service/api_end_points.dart';

class NotificationRepository {
  Future<NotificationsResponse> getUserData() async {
    var response = await ApiClient().post(
      ApiEndPoints.userData,
      {"filter":{"role":"patient","_id":userId.$}},
      getUserData,
      isHeaderRequired: true,
      isLoaderRequired: true,
    );
    return safeFromJson(
      response,
      (json) => NotificationsResponse.fromJson(json),
      NotificationsResponse(),
    );
  }

  Future<DefaultModel> acceptRequest({
    required String invitationId,
  }) async {
    var response = await ApiClient().post(
      ApiEndPoints.userInvitation,
      {
        "_id": userId.$,
        "status": "accepted",
        "invitationId": invitationId,
      },
      acceptRequest,
      isHeaderRequired: true,
      isLoaderRequired: true,
    );
    return safeFromJson(
      response,
      (json) => DefaultModel.fromJson(json),
      DefaultModel(),
    );
  }

  Future<DefaultModel> declineRequest({
    required String invitationId,
  }) async {
    var response = await ApiClient().post(
      ApiEndPoints.userInvitation,
      {
        "_id": userId.$,
        "status": "declined",
        "invitationId": invitationId,
      },
      declineRequest,
      isHeaderRequired: true,
      isLoaderRequired: true,
    );
    return safeFromJson(
      response,
      (json) => DefaultModel.fromJson(json),
      DefaultModel(),
    );
  }
}
