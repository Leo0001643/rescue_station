
import 'dart:async';

import 'package:common_utils/common_utils.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:get/get.dart';
import 'package:rescue_station/app/db/chat_message_table.dart';
import 'package:rescue_station/app/db/db_helper.dart';
import 'package:rescue_station/app/event/new_chat_event.dart';
import 'package:rescue_station/app/routes/api_info.dart';
import 'package:rescue_station/app/routes/app_pages.dart';
import 'package:rescue_station/app/socket/socket_message_entity.dart';
import 'package:rescue_station/app/socket/socket_utils.dart';
import 'package:rescue_station/app/utils/dio_utils.dart';
import 'package:rescue_station/app/utils/logger.dart';
import 'package:rescue_station/app/utils/widget_utils.dart';
import 'bottom_chat_controller.dart';
import 'chat_by_friend_state.dart';

class ChatByFriendLogic extends GetxController {
  final ChatByFriendState state = ChatByFriendState();
  StreamSubscription? msgReceiveSub;
  final chatCtl = Get.find<BottomChatController>();

  @override
  void onReady() {
    queryChatMessage();
    msgReceiveSub = eventBus.on<SocketMessageEntity>().listen((message){
      if(message.fromInfo?.userType != 'self'){
        state.messages.insert(0, SocketUtils().buildUserText(message.msgContent!.content.em(), message.fromInfo!,
            createdAt: DateUtil.getDateMsByTimeStr(message.createTime.em())));
      }
    });
    super.onReady();
  }

  @override
  void onClose() {
    msgReceiveSub?.cancel();
    super.onClose();
  }

  void sendMessage(types.Message msg){
    loggerArray(["socket状态",SocketUtils().isConnect]);
    var content = "";
    var msgType = "";
    if(msg is types.TextMessage){
      content = msg.text;
      msgType = "TEXT";
    }
    var params = {"userId": chatCtl.friend.userId.em(),"msgType":msgType,"content": content};
    DioUtil().post(Api.CHAT_SEND_MESSAGE,data: params).then((result){
      if(result.data["code"] == 200){
        state.messages.insert(0, msg);
        /*///缓存消息到数据库
        DbHelper().addChatMessageBox(ChatMessageTable.fromJson(message.toJson()));
        DbHelper().findMessageBox(chatCtl.user.userId.em()).then((v){
          if(ObjectUtil.isEmpty(v)){
            DbHelper().addMessageBox(MessageBoxTable(boxId: message.msgId,userId: chatCtl.user.userId.em(),lastMessage: message.msgContent?.toJson(),
              lastMessageTime: DateUtil.getDateMsByTimeStr(message.createTime.em()),unreadCount: 0,fromInfo: message.fromInfo?.toJson(),));
          } else {
            v!.fromInfo = message.fromInfo?.toJson();
            v.lastMessageTime = DateUtil.getDateMsByTimeStr(message.createTime.em());
            v.lastMessage = message.msgContent?.toJson();
            DbHelper().updateMessageBox(v);
          }
        });*/
        eventBus.fire(NewChatEvent());//有新消息，需要刷新列表
      } else {
        Get.snackbar('提醒', result.data["msg"]);
      }
    }).onError((e,stack){
      Get.snackbar('提醒', "系统异常！");
    });
  }

  void queryChatMessage() {
    DbHelper().queryChatMessageBox(chatCtl.friend.userId.em()).then((v){
      if(v.isNotEmpty){
        v.forEach((item){
          var msg = SocketMsgContent.fromJson(item.msgContent!);
          state.messages.insert(0, SocketUtils().buildUserText(msg.content.em(), item.fromInfo!,createdAt:
          DateUtil.getDateMsByTimeStr(item.createTime.em())));
        });
      }
    });
  }

}
