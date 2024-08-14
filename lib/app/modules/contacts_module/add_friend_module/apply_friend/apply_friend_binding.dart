import 'package:get/get.dart';

import 'apply_friend_logic.dart';

class ApplyFriendBinding extends Binding {

  @override
  List<Bind> dependencies() {
    return [Bind.lazyPut(() => ApplyFriendLogic())];
  }


}
