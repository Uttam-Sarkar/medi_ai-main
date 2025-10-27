import 'package:get/get.dart';

import '../controllers/hospital_registration_controller.dart';

class HospitalRegistrationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HospitalRegistrationController>(
      () => HospitalRegistrationController(),
    );
  }
}
