import 'package:rescue_station/app/modules/contacts_module/contacts_controller.dart';
import 'package:get/get.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class ContactsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ContactsController());
  }
}