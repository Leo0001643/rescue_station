import 'dart:async';

import 'package:common_utils/common_utils.dart';
import 'package:get/get.dart';
import 'package:rescue_station/app/db/db_helper.dart';
import 'package:rescue_station/app/db/message_box_table.dart';
import 'package:rescue_station/app/event/friend_delete_event.dart';
import 'package:rescue_station/app/event/logout_event.dart';
import 'package:rescue_station/app/event/new_chat_event.dart';
import 'package:rescue_station/app/routes/app_pages.dart';
import 'package:rescue_station/app/utils/app_data.dart';
import 'package:rescue_station/app/utils/logger.dart';
import 'package:rescue_station/app/utils/widget_utils.dart';

class MessageController extends GetxController{

  var messages = RxList<MessageBoxTable>.empty(growable: true);
  StreamSubscription? friendDelSub;
  StreamSubscription? newChatSub;
  StreamSubscription? loginSub;

  @override
  void onReady() {
    getMessageList();
    friendDelSub = eventBus.on<FriendDeleteEvent>().listen((event) {
      ///删除好友，这里也应该删除对应的聊天记录,更新聊天列表
      getMessageList();
    });
    newChatSub = eventBus.on<NewChatEvent>().listen((event) {
      ///有新消息
      getMessageList();
    });
    loginSub = eventBus.on<LoginEvent>().listen((event) {
      ///登录成功
      getMessageList();
    });
    super.onReady();
  }

  @override
  void onClose() {
    newChatSub?.cancel();
    friendDelSub?.cancel();
    loginSub?.cancel();
    super.onClose();
  }

  void getMessageList() {
    var user = AppData.getUser();
    if(ObjectUtil.isNotEmpty(user)){
      DbHelper().queryMessageBox(user!.userId.em()).then((v){
        loggerArray(["查询消息列表结果",v]);
        messages.value = v;
      });
    }
  }

}