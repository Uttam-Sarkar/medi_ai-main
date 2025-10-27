import 'package:get/get.dart';
import '../../home/controllers/home_controller.dart';
import '../controllers/my_symptoms_controller.dart';

class MySymptomsBinding extends Bindings {
  @override
  void dependencies() {
    // Ensure HomeController is available
    if (!Get.isRegistered<HomeController>()) {
      Get.put(HomeController());
    }

    Get.lazyPut<MySymptomsController>(() => MySymptomsController());
  }
}
