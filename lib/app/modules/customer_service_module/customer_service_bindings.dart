import 'package:rescue_station/app/modules/customer_service_module/customer_service_controller.dart';
import 'package:get/get.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class CustomerServiceBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CustomerServiceController());
  }
}