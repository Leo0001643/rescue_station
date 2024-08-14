import 'package:get/get.dart';

import 'forward_message_logic.dart';

class ForwardMessageBinding extends Binding {

  @override
  List<Bind> dependencies() {
    return [
      Bind.lazyPut(() => ForwardMessageLogic())
    ];
  }


}
