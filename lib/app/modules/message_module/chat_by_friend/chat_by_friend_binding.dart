import 'package:get/get.dart';

import 'bottom_chat_controller.dart';
import 'chat_by_friend_logic.dart';

class ChatByFriendBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BottomChatController());
    Get.lazyPut(() => ChatByFriendLogic());
  }
}
