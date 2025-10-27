import 'package:get/get.dart';

import '../controllers/medical_history_controller.dart';
import '../../home/controllers/home_controller.dart';

class MedicalHistoryBinding extends Bindings {
  @override
  void dependencies() {
    // Ensure HomeController is available
    if (!Get.isRegistered<HomeController>()) {
      Get.put<HomeController>(HomeController());
    }

    Get.lazyPut<MedicalHistoryController>(() => MedicalHistoryController());
  }
}
