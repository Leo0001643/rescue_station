import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'group_reduce_logic.dart';

class GroupReduceBinding extends Binding {
  @override
  List<Bind> dependencies() {
    return [Bind.lazyPut(() => GroupReduceLogic())];
  }

}
