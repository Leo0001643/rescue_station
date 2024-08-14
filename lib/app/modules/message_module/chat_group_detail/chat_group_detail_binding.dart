import 'package:get/get.dart';

import 'chat_group_detail_logic.dart';

class ChatGroupDetailBinding extends Binding {
  @override
  List<Bind> dependencies() {
    return [Bind.lazyPut(()=> ChatGroupDetailLogic())];
  }



}
