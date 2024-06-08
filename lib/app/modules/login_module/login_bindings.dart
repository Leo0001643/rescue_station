import 'package:rescue_station/app/modules/login_module/login_controller.dart';
import 'package:get/get.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class loginBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => loginController());
  }
}