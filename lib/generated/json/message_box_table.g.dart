import 'package:rescue_station/generated/json/base/json_convert_content.dart';
import 'package:rescue_station/app/db/message_box_table.dart';
import 'package:hive/hive.dart';

import 'package:rescue_station/app/db/user_info_table.dart';


MessageBoxTable $MessageBoxTableFromJson(Map<String, dynamic> json) {
  final MessageBoxTable messageBoxTable = MessageBoxTable();
  final int? boxId = jsonConvert.convert<int>(json['boxId']);
  if (boxId != null) {
    messageBoxTable.boxId = boxId;
  }
  final String? userId = jsonConvert.convert<String>(json['userId']);
  if (userId != null) {
    messageBoxTable.userId = userId;
  }
  final int? boxType = jsonConvert.convert<int>(json['boxType']);
  if (boxType != null) {
    messageBoxTable.boxType = boxType;
  }
  final dynamic lastMessage = json['lastMessage'];
  if (lastMessage != null) {
    messageBoxTable.lastMessage = lastMessage;
  }
  final int? lastMessageTime = jsonConvert.convert<int>(
      json['lastMessageTime']);
  if (lastMessageTime != null) {
    messageBoxTable.lastMessageTime = lastMessageTime;
  }
  final int? unreadCount = jsonConvert.convert<int>(json['unreadCount']);
  if (unreadCount != null) {
    messageBoxTable.unreadCount = unreadCount;
  }
  final bool? isTop = jsonConvert.convert<bool>(json['isTop']);
  if (isTop != null) {
    messageBoxTable.isTop = isTop;
  }
  final bool? isDisturb = jsonConvert.convert<bool>(json['isDisturb']);
  if (isDisturb != null) {
    messageBoxTable.isDisturb = isDisturb;
  }
  final bool? isGroup = jsonConvert.convert<bool>(json['isGroup']);
  if (isGroup != null) {
    messageBoxTable.isGroup = isGroup;
  }
  final UserInfoTable? friend = jsonConvert.convert<UserInfoTable>(
      json['friend']);
  if (friend != null) {
    messageBoxTable.friend = friend;
  }
  final dynamic group = json['group'];
  if (group != null) {
    messageBoxTable.group = group;
  }
  final bool? isShow = jsonConvert.convert<bool>(json['isShow']);
  if (isShow != null) {
    messageBoxTable.isShow = isShow;
  }
  return messageBoxTable;
}

Map<String, dynamic> $MessageBoxTableToJson(MessageBoxTable entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['boxId'] = entity.boxId;
  data['userId'] = entity.userId;
  data['boxType'] = entity.boxType;
  data['lastMessage'] = entity.lastMessage;
  data['lastMessageTime'] = entity.lastMessageTime;
  data['unreadCount'] = entity.unreadCount;
  data['isTop'] = entity.isTop;
  data['isDisturb'] = entity.isDisturb;
  data['isGroup'] = entity.isGroup;
  data['friend'] = entity.friend?.toJson();
  data['group'] = entity.group;
  data['isShow'] = entity.isShow;
  return data;
}

extension MessageBoxTableExtension on MessageBoxTable {
  MessageBoxTable copyWith({
    int? boxId,
    String? userId,
    int? boxType,
    dynamic lastMessage,
    int? lastMessageTime,
    int? unreadCount,
    bool? isTop,
    bool? isDisturb,
    bool? isGroup,
    UserInfoTable? friend,
    dynamic group,
    bool? isShow,
  }) {
    return MessageBoxTable()
      ..boxId = boxId ?? this.boxId
      ..userId = userId ?? this.userId
      ..boxType = boxType ?? this.boxType
      ..lastMessage = lastMessage ?? this.lastMessage
      ..lastMessageTime = lastMessageTime ?? this.lastMessageTime
      ..unreadCount = unreadCount ?? this.unreadCount
      ..isTop = isTop ?? this.isTop
      ..isDisturb = isDisturb ?? this.isDisturb
      ..isGroup = isGroup ?? this.isGroup
      ..friend = friend ?? this.friend
      ..group = group ?? this.group
      ..isShow = isShow ?? this.isShow;
  }
}