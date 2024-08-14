import 'package:rescue_station/app/modules/mine_module/mine_controller.dart';
import 'package:get/get.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class MineBinding implements Binding {
  @override
  List<Bind> dependencies() {
    return [Bind.lazyPut(() => MineController())];
  }

}