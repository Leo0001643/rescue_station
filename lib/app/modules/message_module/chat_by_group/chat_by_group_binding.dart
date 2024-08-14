import 'package:get/get.dart';

import '../chat_by_friend/bottom_chat_controller.dart';
import 'chat_by_group_logic.dart';

class ChatByGroupBinding extends Binding {
  @override
  List<Bind> dependencies() {
    return [
      Bind.lazyPut(() => BottomChatController()),
      Bind.lazyPut(() => ChatByGroupLogic()),
    ];
  }

}
