import 'package:get/get.dart';

import '../controllers/add_form_controller.dart';

class AddFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddFormController>(
      () => AddFormController(),
    );
  }
}
