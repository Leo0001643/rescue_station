import 'package:get/get.dart';

import 'friend_detail_logic.dart';

class FriendDetailBinding extends Binding {
  @override
  List<Bind> dependencies() {
    return [Bind.lazyPut(() => FriendDetailLogic())];
  }

}
