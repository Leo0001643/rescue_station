

import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:rescue_station/app/domains/message_type_enum.dart';
import 'package:rescue_station/app/domains/user_info_entity.dart';
import 'package:rescue_station/app/socket/socket_message_entity.dart';
import 'package:rescue_station/app/socket/socket_utils_bak.dart';
import 'package:rescue_station/app/utils/logger.dart';
import 'package:rescue_station/app/utils/widget_utils.dart';

class DataUtils {


  static String getMsgContent(Message? msg) {
    if(msg != null){
      switch(msg.type){
        case MessageType.text:
          return (msg as TextMessage).text;
        case MessageType.image:
          return "[图片]";
        case MessageType.video:
          return "[视频]";
        case MessageType.file:
          return "[文件]";
        default:
          return "";
      }
    }
    return "";
  }

  static Message? getRefMsg(SocketRefMsgContent? refMsg){
    if(refMsg?.msgType == null)return null;
    loggerArray(["回复信息内容是什么",refMsg!.toJson()]);
    if(refMsg.msgType == MessageTypeEnum.TEXT.name){
      return SocketUtils().buildUserText(refMsg.content.em(), UserInfoEntity(nickName: refMsg.nickName));
    }else if(refMsg.msgType == MessageTypeEnum.IMAGE.name){
      return SocketUtils().buildUserImageUrl(refMsg.content.em(), UserInfoEntity(nickName: refMsg.nickName));
    }else{
      return SocketUtils().buildUserFileUrl(refMsg.content.em(), UserInfoEntity(nickName: refMsg.nickName));
    }
  }



}










