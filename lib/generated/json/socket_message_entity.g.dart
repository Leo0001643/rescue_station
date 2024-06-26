import 'package:rescue_station/generated/json/base/json_convert_content.dart';
import 'package:rescue_station/app/socket/socket_message_entity.dart';
import 'package:rescue_station/app/db/user_info_table.dart';


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
  final String? userId = jsonConvert.convert<String>(json['userId']);
  if (userId != null) {
    socketMessageEntity.userId = userId;
  }
  final SocketMsgContent? msgContent = jsonConvert.convert<SocketMsgContent>(
      json['msgContent']);
  if (msgContent != null) {
    socketMessageEntity.msgContent = msgContent;
  }
  final UserInfoTable? fromInfo = jsonConvert.convert<UserInfoTable>(
      json['fromInfo']);
  if (fromInfo != null) {
    socketMessageEntity.fromInfo = fromInfo;
  }
  final String? createTime = jsonConvert.convert<String>(json['createTime']);
  if (createTime != null) {
    socketMessageEntity.createTime = createTime;
  }
  final dynamic groupInfo = json['groupInfo'];
  if (groupInfo != null) {
    socketMessageEntity.groupInfo = groupInfo;
  }
  return socketMessageEntity;
}

Map<String, dynamic> $SocketMessageEntityToJson(SocketMessageEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['msgId'] = entity.msgId;
  data['pushType'] = entity.pushType;
  data['userId'] = entity.userId;
  data['msgContent'] = entity.msgContent?.toJson();
  data['fromInfo'] = entity.fromInfo?.toJson();
  data['createTime'] = entity.createTime;
  data['groupInfo'] = entity.groupInfo;
  return data;
}

extension SocketMessageEntityExtension on SocketMessageEntity {
  SocketMessageEntity copyWith({
    String? msgId,
    String? pushType,
    String? userId,
    SocketMsgContent? msgContent,
    UserInfoTable? fromInfo,
    String? createTime,
    dynamic groupInfo,
  }) {
    return SocketMessageEntity()
      ..msgId = msgId ?? this.msgId
      ..pushType = pushType ?? this.pushType
      ..userId = userId ?? this.userId
      ..msgContent = msgContent ?? this.msgContent
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