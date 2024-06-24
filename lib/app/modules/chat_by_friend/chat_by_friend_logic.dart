
import 'dart:async';

import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:get/get.dart';
import 'package:rescue_station/app/routes/api_info.dart';
import 'package:rescue_station/app/routes/app_pages.dart';
import 'package:rescue_station/app/socket/socket_message_entity.dart';
import 'package:rescue_station/app/socket/socket_utils.dart';
import 'package:rescue_station/app/utils/dio_utils.dart';
import 'package:rescue_station/app/utils/widget_utils.dart';
import 'chat_by_friend_state.dart';

class ChatByFriendLogic extends GetxController {
  final ChatByFriendState state = ChatByFriendState();
  StreamSubscription? msgReceiveSub;

  @override
  void onReady() {
    msgReceiveSub = eventBus.on<SocketMessageEntity>().listen((message){
      if(message.fromInfo?.userType != 'self'){
        state.messages.insert(0, SocketUtils().buildUserText(message.msgContent!.content.em(), message.fromInfo!));
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
    var content = "";
    var msgType = "";
    if(msg is types.TextMessage){
      content = msg.text;
      msgType = "TEXT";
    }
    var params = {"userId": msg.author.id,"msgType":msgType,"content": content};
    DioUtil().post(Api.CHAT_SEND_MSG,data: params).then((result){
      if(result.data["code"] == 200){
        state.messages.insert(0, msg);
      } else {
        Get.snackbar('提醒', result.data["msg"]);
      }
    }).onError((e,stack){
      Get.snackbar('提醒', "系统异常！");
    });
  }

}
