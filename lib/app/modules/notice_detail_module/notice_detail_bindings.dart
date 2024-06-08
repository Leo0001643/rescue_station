import 'package:rescue_station/app/modules/notice_detail_module/notice_detail_controller.dart';
import 'package:get/get.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class NoticeDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NoticeDetailController());
  }
}