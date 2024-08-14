import 'package:get/get.dart';

import 'group_list_logic.dart';

class GroupListBinding extends Binding {
  @override
  List<Bind> dependencies() {
    return [Bind.lazyPut(() => GroupListLogic())];
  }

}
