import 'package:get/get.dart';
import 'package:medi/app/core/helper/print_log.dart';
import 'package:medi/app/routes/app_pages.dart';

import '../../../core/helper/auth_helper.dart';
import '../../../core/helper/language_helper.dart';
import '../../../core/helper/shared_value_helper.dart';

class SplashController extends GetxController {
  var scale = 0.0.obs;
  var opacity = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(milliseconds: 300), () {
      scale.value = 1.0;
      opacity.value = 1.0;
    });

    initializeApp();
  }

  @override
  void dispose() {
    super.dispose();
    scale.close();
    opacity.close();
  }

  void initializeApp() async {
    AuthHelper().loadItems();
    await Future.delayed(2200.milliseconds).then((value) async {
      await isLoggedIn.load().whenComplete(() async {
        if (isLoggedIn.$) {
          LocalizationService.changeLocale(selectedLanguage.$);
          Get.offNamed(Routes.HOME);
        } else {
          if (onBoardView.$) {
            Get.offNamed(Routes.ONBOARDING);
          } else {
            AuthHelper().clearUserData();
            Get.offNamed(Routes.LOGIN);
          }
        }
      });
    });
  }
}
