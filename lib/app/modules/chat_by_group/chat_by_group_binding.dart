import 'package:get/get.dart';

import 'chat_by_group_logic.dart';

class ChatByGroupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChatByGroupLogic());
  }
}
