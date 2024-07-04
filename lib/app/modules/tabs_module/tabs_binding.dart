import 'package:get/get.dart';
import '../../utils/navigator_observer.dart';
import 'tabs_controller.dart';




class TabsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(()=>CustomNavigatorObserver());
    Get.lazyPut<TabsController>(() => TabsController(),);
    // Get.lazyPut<HomeController>(
    //   () => HomeController(),
    // );
    // Get.lazyPut<MessageController>(
    //   () => MessageController(),
    // );
    // Get.lazyPut<MineController>(
    //   () => MineController(),
    // );
    // Get.lazyPut<CustomerServiceController>(
    //   () => CustomerServiceController(),
    // );
    // Get.lazyPut<ContactsController>(
    //   () => ContactsController(),
    // );
  }
}
