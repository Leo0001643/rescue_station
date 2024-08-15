
import 'dart:convert';
import 'package:rescue_station/app/routes/app_pages.dart';
import 'package:rescue_station/app/utils/widget_utils.dart';
import 'package:rescue_station/generated/json/base/json_field.dart';
import 'package:rescue_station/generated/json/message_box_table.g.dart';

@JsonSerializable()
class MessageBoxTable{
  int? id;

  String? userId;///当前登录用户的userId

  String? boxId;///好友id or 群组id

  int boxType = 0;///0 单聊 1 群聊

  String? lastMessage;///最后一条消息

  int? lastMessageTime;///最后一条消息时间

  int? unreadCount;///消息未读数量

  int isTop = 0;///是否置顶

  int isDisturb = 0;///是否免打扰

  String? fromInfo;///单聊好友信息 or 群聊信息

  int isShow = 0;///聊天框是否显示（特指消息页面的聊天框入口）

  MessageBoxTable({this.userId,this.boxId,this.boxType = 0, this.lastMessage,this.lastMessageTime,this.unreadCount,this.fromInfo});

  factory MessageBoxTable.fromJson(Map<String, dynamic> json) => $MessageBoxTableFromJson(json);

  Map<String, dynamic> toJson() => $MessageBoxTableToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String,dynamic> getLastMessage() {
    if(isEmpty(lastMessage)){
      return {};
    }else {
      return jsonDecode(lastMessage.em());
    }
  }

  Map<String,dynamic> getFromInfo() {
    if(isEmpty(fromInfo)){
      return {};
    }else {
      return jsonDecode(fromInfo.em());
    }
  }


  bool getIsTop() => isTop == 1;

  bool getIsDisturb() => isDisturb == 1;

  bool isGroup() => boxType == 1;

  bool getIsShow() => isShow == 1;




}


