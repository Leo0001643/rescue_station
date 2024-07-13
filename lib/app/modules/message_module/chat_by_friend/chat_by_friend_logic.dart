
import 'dart:async';
import 'dart:io';

import 'package:common_utils/common_utils.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:rescue_station/app/db/db_helper.dart';
import 'package:rescue_station/app/domains/message_type_enum.dart';
import 'package:rescue_station/app/domains/upload_file_entity.dart';
import 'package:rescue_station/app/event/new_chat_event.dart';
import 'package:rescue_station/app/domains/user_info_entity.dart';
import 'package:rescue_station/app/routes/api_info.dart';
import 'package:rescue_station/app/routes/app_pages.dart';
import 'package:rescue_station/app/socket/socket_message_entity.dart';
import 'package:rescue_station/app/socket/socket_utils.dart';
import 'package:rescue_station/app/utils/app_data.dart';
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
      if(message.boxId == chatCtl.friend.userId){
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

  void sendMessage(types.Message msg) async {
    loggerArray(["socket状态",SocketUtils().isConnect]);
    var content = "";
    var msgType = "";
    EasyLoading.show();
    if(msg is types.TextMessage){
      content = msg.text;
      msgType = MessageTypeEnum.TEXT.name;
    }else if(msg is types.ImageMessage){
      content = await DioUtil.uploadFile(msg.uri.em());
      msgType = MessageTypeEnum.IMAGE.name;
    }else if(msg is types.FileMessage){
      content = await DioUtil.uploadFile(msg.uri.em());
      msgType = MessageTypeEnum.FILE.name;
    }
    if(content.isEmpty) {
      EasyLoading.dismiss();
      return;
    }
    var params = {"userId": chatCtl.friend.userId.em(),"msgType":msgType,"content": content};
    DioUtil().post(Api.CHAT_SEND_MESSAGE,data: params).then((result){
      EasyLoading.dismiss();
      if(result.data["code"] == 200){
        if(result.data["data"]["status"] != "0"){
          Get.snackbar("提示", result.data["data"]["statusLabel"]);
          return;
        }
        state.messages.insert(0, msg);
        var socketMsg = SocketMessageEntity();
        socketMsg.msgId = result.data["data"]["msgId"];
        socketMsg.boxId = chatCtl.friend.userId.em();
        socketMsg.pushType = 'MSG';
        socketMsg.createTime = DateUtil.getNowDateStr();
        socketMsg.groupInfo = null;
        socketMsg.fromInfo = chatCtl.friend;
        var msgContent = SocketMsgContent();
        msgContent.disturb = 'N';
        msgContent.top = 'N';
        msgContent.content = content;
        msgContent.msgType = msgType;
        socketMsg.msgContent = msgContent;
        ///缓存消息到数据库
        DbHelper().messageInsertOrUpdate(true,socketMsg).then((v){
          eventBus.fire(NewChatEvent());//有新消息，需要刷新列表
        });
      } else {
        Get.snackbar('提醒', result.data["msg"]);
      }
    }).onError((e,stack){
      EasyLoading.dismiss();
      Get.snackbar('提醒', "系统异常！");
    });
  }


  void queryChatMessage() {
    DbHelper().queryChatMessageBox(AppData.getUser()!.userId.em(),chatCtl.friend.userId.em()).then((v){
      if(v.isNotEmpty){
        v.forEach((item){
          var msg = SocketMsgContent.fromJson(item.getMsgContent());
          switch(find(msg.msgType)){
            case MessageTypeEnum.TEXT:
              state.messages.insert(0, SocketUtils().buildUserText(msg.content.em(), UserInfoEntity.fromJson(item.getFromInfo()),createdAt:
              DateUtil.getDateMsByTimeStr(item.createTime.em())));
              break;
            case MessageTypeEnum.IMAGE:
              state.messages.insert(0, SocketUtils().buildUserImageUrl(msg.content.em(), UserInfoEntity.fromJson(item.getFromInfo()),createdAt:
              DateUtil.getDateMsByTimeStr(item.createTime.em())));
              break;
            case MessageTypeEnum.FILE:
              state.messages.insert(0, SocketUtils().buildUserFileUrl(msg.content.em(), UserInfoEntity.fromJson(item.getFromInfo()),createdAt:
              DateUtil.getDateMsByTimeStr(item.createTime.em())));
              break;
            default:
              break;
          }
        });
      }
    });
  }



}
