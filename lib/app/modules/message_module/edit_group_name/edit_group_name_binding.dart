import 'package:get/get.dart';

import 'edit_group_name_logic.dart';

class EditGroupNameBinding extends Binding {
  @override
  List<Bind> dependencies() {
    return [
      Bind.lazyPut(() => EditGroupNameLogic())
    ];
  }


}
