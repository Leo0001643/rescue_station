import 'package:rescue_station/app/modules/customer_service_module/customer_service_controller.dart';
import 'package:get/get.dart';


class CustomerServiceBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CustomerServiceController());
  }
}