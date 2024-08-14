import 'package:get/get.dart';

import 'bottom_chat_controller.dart';
import 'chat_by_friend_logic.dart';

class ChatByFriendBinding extends Binding {
  @override
  List<Bind> dependencies() {
    return [
      Bind.lazyPut(() => BottomChatController()),
      Bind.lazyPut(() => ChatByFriendLogic()),
    ];
  }


}
