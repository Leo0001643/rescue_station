import 'package:get/get.dart';

import 'chat_by_friend_logic.dart';

class ChatByFriendBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChatByFriendLogic());
  }
}
