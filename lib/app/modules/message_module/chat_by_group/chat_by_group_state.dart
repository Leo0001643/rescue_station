import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:get/get.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:rescue_station/app/domains/group_detail_entity.dart';
import 'package:rescue_station/app/event/chat_event.dart';

class ChatByGroupState {
  ChatByGroupState() {
    ///Initialize variables
  }

  final RxList<types.Message> messages = RxList.empty(growable: true);

  late ChatGroupEvent chatEvent;

  var popCtlList = List<CustomPopupMenuController>.empty(growable: true);

  var groupDetail = GroupDetailEntity().obs;

  var pageTitle = "".obs;



}
