import 'package:rescue_station/generated/json/base/json_convert_content.dart';
import 'package:rescue_station/app/db/chat_message_table.dart';
import 'package:hive/hive.dart';

import 'package:rescue_station/app/db/user_info_table.dart';


ChatMessageTable $ChatMessageTableFromJson(Map<String, dynamic> json) {
  final ChatMessageTable chatMessageTable = ChatMessageTable();
  final String? msgId = jsonConvert.convert<String>(json['msgId']);
  if (msgId != null) {
    chatMessageTable.msgId = msgId;
  }
  final String? pushType = jsonConvert.convert<String>(json['pushType']);
  if (pushType != null) {
    chatMessageTable.pushType = pushType;
  }
  final Map<String, dynamic>? msgContent =
  (json['msgContent'] as Map<String, dynamic>?)?.map(
          (k, e) => MapEntry(k, e));
  if (msgContent != null) {
    chatMessageTable.msgContent = msgContent;
  }
  final UserInfoTable? fromInfo = jsonConvert.convert<UserInfoTable>(
      json['fromInfo']);
  if (fromInfo != null) {
    chatMessageTable.fromInfo = fromInfo;
  }
  final String? createTime = jsonConvert.convert<String>(json['createTime']);
  if (createTime != null) {
    chatMessageTable.createTime = createTime;
  }
  final Map<String, dynamic>? groupInfo =
  (json['groupInfo'] as Map<String, dynamic>?)?.map(
          (k, e) => MapEntry(k, e));
  if (groupInfo != null) {
    chatMessageTable.groupInfo = groupInfo;
  }
  final String? userId = jsonConvert.convert<String>(json['userId']);
  if (userId != null) {
    chatMessageTable.userId = userId;
  }
  return chatMessageTable;
}

Map<String, dynamic> $ChatMessageTableToJson(ChatMessageTable entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['msgId'] = entity.msgId;
  data['pushType'] = entity.pushType;
  data['msgContent'] = entity.msgContent;
  data['fromInfo'] = entity.fromInfo?.toJson();
  data['createTime'] = entity.createTime;
  data['groupInfo'] = entity.groupInfo;
  data['userId'] = entity.userId;
  return data;
}

extension ChatMessageTableExtension on ChatMessageTable {
  ChatMessageTable copyWith({
    String? msgId,
    String? pushType,
    Map<String, dynamic>? msgContent,
    UserInfoTable? fromInfo,
    String? createTime,
    Map<String, dynamic>? groupInfo,
    String? userId,
  }) {
    return ChatMessageTable()
      ..msgId = msgId ?? this.msgId
      ..pushType = pushType ?? this.pushType
      ..msgContent = msgContent ?? this.msgContent
      ..fromInfo = fromInfo ?? this.fromInfo
      ..createTime = createTime ?? this.createTime
      ..groupInfo = groupInfo ?? this.groupInfo
      ..userId = userId ?? this.userId;
  }
}