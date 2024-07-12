import 'package:rescue_station/generated/json/base/json_convert_content.dart';
import 'package:rescue_station/app/db/chat_message_table.dart';
import 'package:rescue_station/app/domains/user_info_entity.dart';

import 'package:rescue_station/app/socket/socket_message_entity.dart';

import 'package:rescue_station/app/utils/widget_utils.dart';


ChatMessageTable $ChatMessageTableFromJson(Map<String, dynamic> json) {
  final ChatMessageTable chatMessageTable = ChatMessageTable();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    chatMessageTable.id = id;
  }
  final String? msgId = jsonConvert.convert<String>(json['msgId']);
  if (msgId != null) {
    chatMessageTable.msgId = msgId;
  }
  final String? pushType = jsonConvert.convert<String>(json['pushType']);
  if (pushType != null) {
    chatMessageTable.pushType = pushType;
  }
  final String? msgContent = jsonConvert.convert<String>(json['msgContent']);
  if (msgContent != null) {
    chatMessageTable.msgContent = msgContent;
  }
  final String? fromInfo = jsonConvert.convert<String>(json['fromInfo']);
  if (fromInfo != null) {
    chatMessageTable.fromInfo = fromInfo;
  }
  final String? createTime = jsonConvert.convert<String>(json['createTime']);
  if (createTime != null) {
    chatMessageTable.createTime = createTime;
  }
  final String? groupInfo = jsonConvert.convert<String>(json['groupInfo']);
  if (groupInfo != null) {
    chatMessageTable.groupInfo = groupInfo;
  }
  final String? boxId = jsonConvert.convert<String>(json['boxId']);
  if (boxId != null) {
    chatMessageTable.boxId = boxId;
  }
  final String? userId = jsonConvert.convert<String>(json['userId']);
  if (userId != null) {
    chatMessageTable.userId = userId;
  }
  return chatMessageTable;
}

Map<String, dynamic> $ChatMessageTableToJson(ChatMessageTable entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['msgId'] = entity.msgId;
  data['pushType'] = entity.pushType;
  data['msgContent'] = entity.msgContent;
  data['fromInfo'] = entity.fromInfo;
  data['createTime'] = entity.createTime;
  data['groupInfo'] = entity.groupInfo;
  data['boxId'] = entity.boxId;
  data['userId'] = entity.userId;
  return data;
}

extension ChatMessageTableExtension on ChatMessageTable {
  ChatMessageTable copyWith({
    int? id,
    String? msgId,
    String? pushType,
    String? msgContent,
    String? fromInfo,
    String? createTime,
    String? groupInfo,
    String? boxId,
    String? userId,
  }) {
    return ChatMessageTable()
      ..id = id ?? this.id
      ..msgId = msgId ?? this.msgId
      ..pushType = pushType ?? this.pushType
      ..msgContent = msgContent ?? this.msgContent
      ..fromInfo = fromInfo ?? this.fromInfo
      ..createTime = createTime ?? this.createTime
      ..groupInfo = groupInfo ?? this.groupInfo
      ..boxId = boxId ?? this.boxId
      ..userId = userId ?? this.userId;
  }
}