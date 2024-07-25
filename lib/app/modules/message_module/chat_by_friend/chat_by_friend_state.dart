import 'package:flutter/widgets.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:rescue_station/app/event/chat_event.dart';

class ChatByFriendState {
  ChatByFriendState() {
    ///Initialize variables
  }

  final RxList<types.Message> messages = RxList.empty(growable: true);

  late ChatEvent chatEvent;
}
