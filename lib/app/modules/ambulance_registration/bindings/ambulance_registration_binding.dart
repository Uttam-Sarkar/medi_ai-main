import 'package:get/get.dart';

import '../controllers/ambulance_registration_controller.dart';

class AmbulanceRegistrationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AmbulanceRegistrationController>(
      () => AmbulanceRegistrationController(),
    );
  }
}
