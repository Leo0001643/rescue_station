import 'package:get/get.dart';
import './nick_name_edit_controller.dart';

class NickNameEditBindings implements Binding {
  @override
  List<Bind> dependencies() {
    return [Bind.lazyPut(() => NickNameEditController())];
  }


}