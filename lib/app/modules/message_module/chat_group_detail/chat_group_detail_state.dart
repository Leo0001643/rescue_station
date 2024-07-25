import 'package:get/get.dart';
import 'package:rescue_station/app/domains/group_detail_entity.dart';
import 'package:rescue_station/app/event/chat_event.dart';

class ChatGroupDetailState {
  ChatGroupDetailState() {
    ///Initialize variables
  }

  late ChatGroupEvent chatEvent;

  ///是否免打扰
  var isDisturb = false.obs;

  ///是否置顶
  var isTop = false.obs;

  var groupDetail = GroupDetailEntity().obs;
}
