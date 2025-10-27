import 'package:get/get.dart';

import '../controllers/chatbox_socket_controller.dart';

class ChatboxSocketBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatboxSocketController>(
      () => ChatboxSocketController(),
    );
  }
}
