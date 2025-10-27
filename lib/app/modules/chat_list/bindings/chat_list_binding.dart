import 'package:get/get.dart';
import 'package:medi/app/modules/home/controllers/home_controller.dart';

import '../controllers/chat_list_controller.dart';

class ChatListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatListController>(
      () => ChatListController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}
