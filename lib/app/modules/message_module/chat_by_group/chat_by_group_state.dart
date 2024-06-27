import 'package:get/get.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class ChatByGroupState {
  ChatByGroupState() {
    ///Initialize variables
  }

  final RxList<types.Message> messages = RxList.empty(growable: true);



}
