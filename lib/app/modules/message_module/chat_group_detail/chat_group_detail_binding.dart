import 'package:get/get.dart';

import 'chat_group_detail_logic.dart';

class ChatGroupDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChatGroupDetailLogic());
  }
}
