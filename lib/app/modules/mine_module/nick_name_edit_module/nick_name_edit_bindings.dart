import 'package:get/get.dart';
import './nick_name_edit_controller.dart';

class NickNameEditBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NickNameEditController());
  }
}