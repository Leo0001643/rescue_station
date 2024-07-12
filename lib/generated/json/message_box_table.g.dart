import 'package:rescue_station/generated/json/base/json_convert_content.dart';
import 'package:rescue_station/app/db/message_box_table.dart';
import 'package:rescue_station/app/utils/widget_utils.dart';


MessageBoxTable $MessageBoxTableFromJson(Map<String, dynamic> json) {
  final MessageBoxTable messageBoxTable = MessageBoxTable();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    messageBoxTable.id = id;
  }
  final String? userId = jsonConvert.convert<String>(json['userId']);
  if (userId != null) {
    messageBoxTable.userId = userId;
  }
  final String? boxId = jsonConvert.convert<String>(json['boxId']);
  if (boxId != null) {
    messageBoxTable.boxId = boxId;
  }
  final int? boxType = jsonConvert.convert<int>(json['boxType']);
  if (boxType != null) {
    messageBoxTable.boxType = boxType;
  }
  final String? lastMessage = jsonConvert.convert<String>(json['lastMessage']);
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
  final int? isTop = jsonConvert.convert<int>(json['isTop']);
  if (isTop != null) {
    messageBoxTable.isTop = isTop;
  }
  final int? isDisturb = jsonConvert.convert<int>(json['isDisturb']);
  if (isDisturb != null) {
    messageBoxTable.isDisturb = isDisturb;
  }
  final String? fromInfo = jsonConvert.convert<String>(json['fromInfo']);
  if (fromInfo != null) {
    messageBoxTable.fromInfo = fromInfo;
  }
  final int? isShow = jsonConvert.convert<int>(json['isShow']);
  if (isShow != null) {
    messageBoxTable.isShow = isShow;
  }
  return messageBoxTable;
}

Map<String, dynamic> $MessageBoxTableToJson(MessageBoxTable entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['userId'] = entity.userId;
  data['boxId'] = entity.boxId;
  data['boxType'] = entity.boxType;
  data['lastMessage'] = entity.lastMessage;
  data['lastMessageTime'] = entity.lastMessageTime;
  data['unreadCount'] = entity.unreadCount;
  data['isTop'] = entity.isTop;
  data['isDisturb'] = entity.isDisturb;
  data['fromInfo'] = entity.fromInfo;
  data['isShow'] = entity.isShow;
  return data;
}

extension MessageBoxTableExtension on MessageBoxTable {
  MessageBoxTable copyWith({
    int? id,
    String? userId,
    String? boxId,
    int? boxType,
    String? lastMessage,
    int? lastMessageTime,
    int? unreadCount,
    int? isTop,
    int? isDisturb,
    String? fromInfo,
    int? isShow,
  }) {
    return MessageBoxTable()
      ..id = id ?? this.id
      ..userId = userId ?? this.userId
      ..boxId = boxId ?? this.boxId
      ..boxType = boxType ?? this.boxType
      ..lastMessage = lastMessage ?? this.lastMessage
      ..lastMessageTime = lastMessageTime ?? this.lastMessageTime
      ..unreadCount = unreadCount ?? this.unreadCount
      ..isTop = isTop ?? this.isTop
      ..isDisturb = isDisturb ?? this.isDisturb
      ..fromInfo = fromInfo ?? this.fromInfo
      ..isShow = isShow ?? this.isShow;
  }
}