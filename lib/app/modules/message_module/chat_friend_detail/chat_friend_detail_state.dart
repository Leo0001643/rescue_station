import 'package:get/get.dart';
import 'package:rescue_station/app/event/chat_event.dart';

class ChatFriendDetailState {
  ChatFriendDetailState() {
    ///Initialize variables
  }

  late ChatEvent chatEvent;

  ///是否免打扰
  var isDisturb = false.obs;
  ///是否置顶
  var isTop = false.obs;




}
