import 'package:rescue_station/app/modules/create_group_module/create_group_controller.dart';
import 'package:get/get.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class CreateGroupBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreateGroupController());
  }
}