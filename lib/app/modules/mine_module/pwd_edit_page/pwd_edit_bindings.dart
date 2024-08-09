import 'package:rescue_station/app/modules/mine_module/pwd_edit_page/pwd_edit_controller.dart';
import 'package:get/get.dart';


class PwdEditBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PwdEditController());
  }
}