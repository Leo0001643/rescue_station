import 'package:rescue_station/app/modules/home_module/home_controller.dart';
import 'package:get/get.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class HomeBinding implements Binding {
  @override
  List<Bind> dependencies() {
    return [Bind.lazyPut(() => HomeController())];
  }

}