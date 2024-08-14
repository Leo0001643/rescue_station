import 'package:get/get.dart';

import 'group_add_logic.dart';

class GroupAddBinding extends Binding {
  @override
  List<Bind> dependencies() {
    return [Bind.lazyPut(() => GroupAddLogic())];
  }

}
