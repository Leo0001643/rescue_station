import 'package:rescue_station/app/modules/login_module/login_controller.dart';
import 'package:get/get.dart';

class LoginBinding implements Binding {
  @override
  List<Bind> dependencies() {
    return [Bind.lazyPut(() => LoginController())];
  }

}