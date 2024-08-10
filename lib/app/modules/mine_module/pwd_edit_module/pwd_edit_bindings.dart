import './pwd_edit_controller.dart';
import 'package:get/get.dart';


class PwdEditBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PwdEditController());
  }
}