import 'package:get/get.dart';

import 'new_friend_logic.dart';

class NewFriendBinding extends Binding {
  @override
  List<Bind> dependencies() {
    return [Bind.lazyPut(() => NewFriendLogic())];
  }

}
