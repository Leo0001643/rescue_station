
import 'package:get/get.dart';
import 'phone_edit_controller.dart';

class PhoneEditBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PhoneEditController());
  }
}