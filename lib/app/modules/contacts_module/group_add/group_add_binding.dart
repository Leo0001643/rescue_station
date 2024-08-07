import 'package:get/get.dart';

import 'group_add_logic.dart';

class GroupAddBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GroupAddLogic());
  }
}
