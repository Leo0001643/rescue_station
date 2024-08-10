import 'package:get/get.dart';
import 'addr_edit_controller.dart';

class AddrEditBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddrEditController());
  }
}