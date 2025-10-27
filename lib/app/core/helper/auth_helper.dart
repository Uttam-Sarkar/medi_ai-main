import 'package:medi/app/core/helper/shared_value_helper.dart';

import '../../data/remote/model/auth/response/login_response.dart';
import 'language_helper.dart';

class AuthHelper {
  setUserData(LoginResponse loginResponse, String todayLoginTime) {
    if (loginResponse.token != null) {
      isLoggedIn.$ = true;
      isLoggedIn.save();

      accessToken.$ = "Bearer ${loginResponse.token}";
      accessToken.save();

      userName.$ = "${loginResponse.data?.details?.personalDetails?.firstName} "
          "${loginResponse.data?.details?.personalDetails?.lastName}";
      userName.save();

      gender.$ = "${loginResponse.data?.details?.personalDetails?.gender}";
      gender.save();

      userId.$ = loginResponse.data!.id.toString();
      userId.save();

      userRole.$ = loginResponse.data!.role!;
      userRole.save();

      mediId.$ = loginResponse.data!.mediid!;
      mediId.save();

      email.$ = loginResponse.data!.email!;
      email.save();


      selectedLanguage.$ = loginResponse.data?.details?.personalDetails
          ?.language ?? "en";
      selectedLanguage.save();
      LocalizationService.changeLocale(selectedLanguage.$);

    }
  }

  void clearUserData() {
    isLoggedIn.$ = false;
    isLoggedIn.save();

    accessToken.$ = "";
    accessToken.save();

    email.$ = "";
    email.save();

    userName.$ = "";
    userName.save();

    gender.$ = "";
    gender.save();

    userId.$ = "";
    userId.save();

    userRole.$ = "";
    userRole.save();

    mediId.$ = "";
    mediId.save();

    onBoardView.$ = true;
    onBoardView.save();

    selectedLanguage.$ = "en";
    selectedLanguage.save();

    translateDocs.$ = false;
    translateDocs.save();

  }

  void loadItems() {
    selectedLanguage.load();
    onBoardView.load();
    isLoggedIn.load();
    accessToken.load();
    userName.load();
    gender.load();
    email.load();
    userId.load();
    userRole.load();
    mediId.load();
    translateDocs.load();
  }
}
