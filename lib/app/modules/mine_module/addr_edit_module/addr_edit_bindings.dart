import 'package:get/get.dart';
import 'addr_edit_controller.dart';

class AddrEditBinding implements Binding {
  @override
  List<Bind> dependencies() {
    return [Bind.lazyPut(() => AddrEditController())];
  }


}