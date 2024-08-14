import 'package:get/get.dart';
import 'message_controller.dart';

class MessageBinding implements Binding {

  @override
  List<Bind> dependencies() {
    return [Bind.lazyPut(() => MessageController())];
  }

}
