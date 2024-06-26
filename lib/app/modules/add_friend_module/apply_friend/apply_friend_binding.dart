import 'package:get/get.dart';

import 'apply_friend_logic.dart';

class ApplyFriendBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ApplyFriendLogic());
  }
}
