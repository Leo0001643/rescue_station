import 'package:rescue_station/generated/json/base/json_convert_content.dart';
import 'package:rescue_station/app/socket/socket_message_entity.dart';
import 'package:rescue_station/app/domains/group_info_entity.dart';

import 'package:rescue_station/app/domains/user_info_entity.dart';


SocketMessageEntity $SocketMessageEntityFromJson(Map<String, dynamic> json) {
  final SocketMessageEntity socketMessageEntity = SocketMessageEntity();
  final String? msgId = jsonConvert.convert<String>(json['msgId']);
  if (msgId != null) {
    socketMessageEntity.msgId = msgId;
  }
  final String? pushType = jsonConvert.convert<String>(json['pushType']);
  if (pushType != null) {
    socketMessageEntity.pushType = pushType;
  }
  final String? boxId = jsonConvert.convert<String>(json['boxId']);
  if (boxId != null) {
    socketMessageEntity.boxId = boxId;
  }
  final SocketMsgContent? msgContent = jsonConvert.convert<SocketMsgContent>(
      json['msgContent']);
  if (msgContent != null) {
    socketMessageEntity.msgContent = msgContent;
  }
  final SocketRefMsgContent? refMsg = jsonConvert.convert<SocketRefMsgContent>(
      json['refMsg']);
  if (refMsg != null) {
    socketMessageEntity.refMsg = refMsg;
  }
  final UserInfoEntity? fromInfo = jsonConvert.convert<UserInfoEntity>(
      json['fromInfo']);
  if (fromInfo != null) {
    socketMessageEntity.fromInfo = fromInfo;
  }
  final String? createTime = jsonConvert.convert<String>(json['createTime']);
  if (createTime != null) {
    socketMessageEntity.createTime = createTime;
  }
  final GroupInfoEntity? groupInfo = jsonConvert.convert<GroupInfoEntity>(
      json['groupInfo']);
  if (groupInfo != null) {
    socketMessageEntity.groupInfo = groupInfo;
  }
  return socketMessageEntity;
}

Map<String, dynamic> $SocketMessageEntityToJson(SocketMessageEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['msgId'] = entity.msgId;
  data['pushType'] = entity.pushType;
  data['boxId'] = entity.boxId;
  data['msgContent'] = entity.msgContent?.toJson();
  data['refMsg'] = entity.refMsg?.toJson();
  data['fromInfo'] = entity.fromInfo?.toJson();
  data['createTime'] = entity.createTime;
  data['groupInfo'] = entity.groupInfo?.toJson();
  return data;
}

extension SocketMessageEntityExtension on SocketMessageEntity {
  SocketMessageEntity copyWith({
    String? msgId,
    String? pushType,
    String? boxId,
    SocketMsgContent? msgContent,
    SocketRefMsgContent? refMsg,
    UserInfoEntity? fromInfo,
    String? createTime,
    GroupInfoEntity? groupInfo,
  }) {
    return SocketMessageEntity()
      ..msgId = msgId ?? this.msgId
      ..pushType = pushType ?? this.pushType
      ..boxId = boxId ?? this.boxId
      ..msgContent = msgContent ?? this.msgContent
      ..refMsg = refMsg ?? this.refMsg
      ..fromInfo = fromInfo ?? this.fromInfo
      ..createTime = createTime ?? this.createTime
      ..groupInfo = groupInfo ?? this.groupInfo;
  }
}

SocketMsgContent $SocketMsgContentFromJson(Map<String, dynamic> json) {
  final SocketMsgContent socketMsgContent = SocketMsgContent();
  final String? msgType = jsonConvert.convert<String>(json['msgType']);
  if (msgType != null) {
    socketMsgContent.msgType = msgType;
  }
  final String? content = jsonConvert.convert<String>(json['content']);
  if (content != null) {
    socketMsgContent.content = content;
  }
  final String? top = jsonConvert.convert<String>(json['top']);
  if (top != null) {
    socketMsgContent.top = top;
  }
  final String? disturb = jsonConvert.convert<String>(json['disturb']);
  if (disturb != null) {
    socketMsgContent.disturb = disturb;
  }
  return socketMsgContent;
}

Map<String, dynamic> $SocketMsgContentToJson(SocketMsgContent entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['msgType'] = entity.msgType;
  data['content'] = entity.content;
  data['top'] = entity.top;
  data['disturb'] = entity.disturb;
  return data;
}

extension SocketMsgContentExtension on SocketMsgContent {
  SocketMsgContent copyWith({
    String? msgType,
    String? content,
    String? top,
    String? disturb,
  }) {
    return SocketMsgContent()
      ..msgType = msgType ?? this.msgType
      ..content = content ?? this.content
      ..top = top ?? this.top
      ..disturb = disturb ?? this.disturb;
  }
}

SocketRefMsgContent $SocketRefMsgContentFromJson(Map<String, dynamic> json) {
  final SocketRefMsgContent socketRefMsgContent = SocketRefMsgContent();
  final String? msgType = jsonConvert.convert<String>(json['msgType']);
  if (msgType != null) {
    socketRefMsgContent.msgType = msgType;
  }
  final String? content = jsonConvert.convert<String>(json['content']);
  if (content != null) {
    socketRefMsgContent.content = content;
  }
  final String? msgId = jsonConvert.convert<String>(json['msgId']);
  if (msgId != null) {
    socketRefMsgContent.msgId = msgId;
  }
  final String? nickName = jsonConvert.convert<String>(json['nickName']);
  if (nickName != null) {
    socketRefMsgContent.nickName = nickName;
  }
  return socketRefMsgContent;
}

Map<String, dynamic> $SocketRefMsgContentToJson(SocketRefMsgContent entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['msgType'] = entity.msgType;
  data['content'] = entity.content;
  data['msgId'] = entity.msgId;
  data['nickName'] = entity.nickName;
  return data;
}

extension SocketRefMsgContentExtension on SocketRefMsgContent {
  SocketRefMsgContent copyWith({
    String? msgType,
    String? content,
    String? msgId,
    String? nickName,
  }) {
    return SocketRefMsgContent()
      ..msgType = msgType ?? this.msgType
      ..content = content ?? this.content
      ..msgId = msgId ?? this.msgId
      ..nickName = nickName ?? this.nickName;
  }
}