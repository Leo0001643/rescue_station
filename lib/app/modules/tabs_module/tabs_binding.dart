import 'package:get/get.dart';
import '../../utils/navigator_observer.dart';
import 'tabs_controller.dart';


class TabsBinding extends Binding {
  @override
  List<Bind> dependencies() {
    return [
      Bind.lazyPut(()=>CustomNavigatorObserver()),
      Bind.lazyPut<TabsController>(() => TabsController(),),
    ];
  }

}
