import './pwd_edit_controller.dart';
import 'package:get/get.dart';


class PwdEditBinding implements Binding {
  @override
  List<Bind> dependencies() {
    return [Bind.lazyPut(() => PwdEditController())];
  }

}