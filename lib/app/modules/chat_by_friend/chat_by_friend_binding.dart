import 'package:get/get.dart';
import 'package:rescue_station/app/modules/chat_by_friend/bottom_chat_controller.dart';

import 'chat_by_friend_logic.dart';

class ChatByFriendBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BottomChatController());
    Get.lazyPut(() => ChatByFriendLogic());
  }
}
