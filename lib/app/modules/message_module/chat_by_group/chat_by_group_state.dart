import 'package:get/get.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:rescue_station/app/event/chat_event.dart';

class ChatByGroupState {
  ChatByGroupState() {
    ///Initialize variables
  }

  final RxList<types.Message> messages = RxList.empty(growable: true);

  late ChatGroupEvent chatEvent;


}
