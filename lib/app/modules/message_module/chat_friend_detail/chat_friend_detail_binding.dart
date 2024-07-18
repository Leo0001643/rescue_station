import 'package:get/get.dart';

import 'chat_friend_detail_logic.dart';

class ChatFriendDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChatFriendDetailLogic());
  }
}
