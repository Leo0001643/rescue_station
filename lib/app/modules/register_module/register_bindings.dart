import 'package:rescue_station/app/modules/register_module/register_controller.dart';
import 'package:get/get.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class registerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => registerController());
  }
}