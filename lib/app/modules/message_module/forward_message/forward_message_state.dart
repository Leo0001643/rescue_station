import 'package:get/get.dart';
import 'package:rescue_station/app/db/message_box_table.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class ForwardMessageState {
  ForwardMessageState() {
    ///Initialize variables
  }

  var messages = RxList<MessageBoxTable>.empty(growable: true);

  late types.Message message;


}
