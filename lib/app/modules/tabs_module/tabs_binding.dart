import 'package:get/get.dart';
import '../../utils/navigator_observer.dart';
import 'tabs_controller.dart';
import '../../modules/home_module/home_controller.dart';
import '../message_module/message_controller.dart';
import '../contacts_module/contacts_controller.dart';
import '../mine_module/mine_controller.dart';
import '../customer_service_module/customer_service_controller.dart';




class TabsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(()=>CustomNavigatorObserver()
    );
    Get.lazyPut<TabsController>(
      () => TabsController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<MessageController>(
      () => MessageController(),
    );
    Get.lazyPut<MineController>(
      () => MineController(),
    );
    Get.lazyPut<CustomerServiceController>(
      () => CustomerServiceController(),
    );
    Get.lazyPut<ContactsController>(
      () => ContactsController(),
    );
  }
}
