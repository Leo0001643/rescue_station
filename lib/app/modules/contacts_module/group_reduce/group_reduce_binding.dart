import 'package:get/get.dart';

import 'group_reduce_logic.dart';

class GroupReduceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GroupReduceLogic());
  }
}
