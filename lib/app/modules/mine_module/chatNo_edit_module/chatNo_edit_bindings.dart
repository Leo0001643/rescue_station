import 'package:get/get.dart';
import './chatNo_edit_controller.dart';

class ChatNoEditBinding implements Binding {
  @override
  List<Bind> dependencies() {
    return [Bind.lazyPut(() => ChatNoEditController())];
  }


}