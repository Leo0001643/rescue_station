import 'register_controller.dart';
import 'package:get/get.dart';


class RegisterBinding implements Binding {
  @override
  List<Bind> dependencies() {
    return [Bind.lazyPut(() => RegisterController())];
  }


}