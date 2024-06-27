import 'package:get/get.dart';

import 'friend_detail_logic.dart';

class FriendDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FriendDetailLogic());
  }
}
