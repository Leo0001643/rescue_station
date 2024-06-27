import 'package:get/get.dart';

import 'create_group_controller.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class CreateGroupBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreateGroupController());
  }
}