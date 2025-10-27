import 'package:get/get.dart';

import '../controllers/travel_history_controller.dart';

class TravelHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TravelHistoryController>(
      () => TravelHistoryController(),
    );
  }
}
