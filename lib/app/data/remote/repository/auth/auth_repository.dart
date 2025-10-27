import 'package:medi/app/data/remote/model/auth/response/login_response.dart';
import 'package:medi/app/data/remote/model/auth/response/register_response'
    '.dart';
import '../../../../network_service/api_client.dart';
import '../../../../network_service/api_end_points.dart';

import '../../../../data/remote/model/auth/response/user_update_response.dart';

class AuthRepository {
  Future<LoginResponse> getSignIn(String email, String password) async {
    var response = await ApiClient().post(
      ApiEndPoints.login,
      {"email": email, "password": password},
      getSignIn,
      isHeaderRequired: false,
      isLoaderRequired: true,
    );
    return safeFromJson(
      response,
      (json) => LoginResponse.fromJson(json),
      LoginResponse(),
    );
  }

  Future<RegisterResponse> getRegister(
    String phone,
    String email,
    String password,
      String type
  ) async {
    var response = await ApiClient().post(
      ApiEndPoints.register,
      {"email": email, 'phone': phone, "password": password,"type":type},
      getSignIn,
      isHeaderRequired: false,
      isLoaderRequired: true,
    );

    return safeFromJson(
      response,
      (json) => RegisterResponse.fromJson(json),
      RegisterResponse(),
    );
  }

  Future<UserDetailsResponse> updateUserDetails(request) async {
    var response = await ApiClient().post(
      ApiEndPoints.updateUserDetails,
      request.toJson(),
      updateUserDetails,
      isHeaderRequired: false,
      isLoaderRequired: true,
    );

    return safeFromJson(
      response,
      (json) => UserDetailsResponse.fromJson(json),
      UserDetailsResponse(),
    );
  }
}
