
import 'package:get/get.dart';
import 'phone_edit_controller.dart';

class PhoneEditBinding implements Binding {
  @override
  List<Bind> dependencies() {
    return [Bind.lazyPut(() => PhoneEditController())];
  }

}