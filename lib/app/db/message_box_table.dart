
import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:rescue_station/generated/json/base/json_field.dart';
import 'package:rescue_station/generated/json/message_box_table.g.dart';
part 'message_box_table.g.dart';

@JsonSerializable()
@HiveType(typeId: 0)
class MessageBoxTable extends HiveObject{
  @HiveField(0)
  String? boxId;

  @HiveField(1)
  String? userId;

  @HiveField(2,defaultValue: 0)
  int boxType = 0;///0 单聊 1 群聊

  @HiveField(3)
  Map<String,dynamic>? lastMessage;///最后一条消息

  @HiveField(4)
  int? lastMessageTime;///最后一条消息时间

  @HiveField(5)
  int? unreadCount;///消息未读数量

  @HiveField(6,defaultValue: false)
  bool isTop = false;///是否置顶

  @HiveField(7,defaultValue: false)
  bool isDisturb = false;///是否免打扰

  @HiveField(8,defaultValue: false)
  bool isGroup = false;///是否是群聊

  @HiveField(9)
  Map<String,dynamic>? fromInfo;///单聊好友信息

  @HiveField(11)
  bool isShow = true;///聊天框是否显示（特指消息页面的聊天框入口）

  MessageBoxTable({this.boxId,this.userId,this.lastMessage,this.lastMessageTime,this.unreadCount,this.fromInfo,});

  factory MessageBoxTable.fromJson(Map<String, dynamic> json) => $MessageBoxTableFromJson(json);

  Map<String, dynamic> toJson() => $MessageBoxTableToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }



}


