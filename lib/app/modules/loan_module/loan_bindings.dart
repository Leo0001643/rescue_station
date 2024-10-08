import 'package:rescue_station/app/modules/loan_module/loan_controller.dart';
import 'package:get/get.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class LoanBinding implements Binding {
  @override
  List<Bind> dependencies() {
    return [Bind.lazyPut(() => LoanController())];
  }

}