import 'package:rescue_station/app/modules/notice_module/notice_controller.dart';
import 'package:get/get.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class NoticeBinding implements Binding {
  @override
  List<Bind> dependencies() {
    return [Bind.lazyPut(() => NoticeController())];
  }

}