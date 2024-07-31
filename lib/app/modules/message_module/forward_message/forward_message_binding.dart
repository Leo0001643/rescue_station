import 'package:get/get.dart';

import 'forward_message_logic.dart';

class ForwardMessageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ForwardMessageLogic());
  }
}
