import 'package:get/get.dart';
import './chatNo_edit_controller.dart';

class ChatNoEditBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChatNoEditController());
  }
}