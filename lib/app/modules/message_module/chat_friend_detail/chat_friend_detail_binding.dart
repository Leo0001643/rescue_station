import 'package:get/get.dart';

import 'chat_friend_detail_logic.dart';

class ChatFriendDetailBinding extends Binding {
  @override
  List<Bind> dependencies() {
    return [Bind.lazyPut(() => ChatFriendDetailLogic())];
  }


}
