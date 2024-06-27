import 'package:get/get.dart';

import 'logic.dart';

class NickNameEditPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NickNameEditPageLogic());
  }
}
