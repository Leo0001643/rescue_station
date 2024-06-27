import 'dart:async';

import 'package:common_utils/common_utils.dart';
import 'package:get/get.dart';
import 'package:rescue_station/app/db/db_helper.dart';
import 'package:rescue_station/app/db/message_box_table.dart';
import 'package:rescue_station/app/event/friend_delete_event.dart';
import 'package:rescue_station/app/event/new_chat_event.dart';
import 'package:rescue_station/app/routes/app_pages.dart';
import 'package:rescue_station/app/utils/logger.dart';
import 'package:rescue_station/app/utils/widget_utils.dart';
import '../../domains/Message.dart';


class MessageController extends GetxController{

  var messages = RxList<MessageBoxTable>.empty(growable: true);
  StreamSubscription? friendDelSub;
  StreamSubscription? newChatSub;

  @override
  void onInit() {
    super.onInit();
    friendDelSub = eventBus.on<FriendDeleteEvent>().listen((event) {
      ///删除好友，这里也应该删除对应的聊天记录,更新聊天列表
      getMessageList();
    });
    newChatSub = eventBus.on<NewChatEvent>().listen((event) {
      ///有新消息
      getMessageList();
    });
  }

  @override
  void onReady() {
    getMessageList();
    super.onReady();
  }

  @override
  void onClose() {
    newChatSub?.cancel();
    friendDelSub?.cancel();
    super.onClose();
  }

  void getMessageList() {
    DbHelper().getUser().then((v){
      if(ObjectUtil.isNotEmpty(v)){
        DbHelper().queryMessageBox(v!.userId.em()).then((v){
          loggerArray(["查询消息列表结果",v]);
          messages.value = v;
        });
      }
    });
  }

}