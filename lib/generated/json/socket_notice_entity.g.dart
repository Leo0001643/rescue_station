import 'package:rescue_station/generated/json/base/json_convert_content.dart';
import 'package:rescue_station/app/socket/socket_notice_entity.dart';

SocketNoticeEntity $SocketNoticeEntityFromJson(Map<String, dynamic> json) {
  final SocketNoticeEntity socketNoticeEntity = SocketNoticeEntity();
  final String? msgId = jsonConvert.convert<String>(json['msgId']);
  if (msgId != null) {
    socketNoticeEntity.msgId = msgId;
  }
  final String? pushType = jsonConvert.convert<String>(json['pushType']);
  if (pushType != null) {
    socketNoticeEntity.pushType = pushType;
  }
  final SocketNoticeMsgContent? msgContent = jsonConvert.convert<
      SocketNoticeMsgContent>(json['msgContent']);
  if (msgContent != null) {
    socketNoticeEntity.msgContent = msgContent;
  }
  final String? createTime = jsonConvert.convert<String>(json['createTime']);
  if (createTime != null) {
    socketNoticeEntity.createTime = createTime;
  }
  final dynamic groupInfo = json['groupInfo'];
  if (groupInfo != null) {
    socketNoticeEntity.groupInfo = groupInfo;
  }
  return socketNoticeEntity;
}

Map<String, dynamic> $SocketNoticeEntityToJson(SocketNoticeEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['msgId'] = entity.msgId;
  data['pushType'] = entity.pushType;
  data['msgContent'] = entity.msgContent?.toJson();
  data['createTime'] = entity.createTime;
  data['groupInfo'] = entity.groupInfo;
  return data;
}

extension SocketNoticeEntityExtension on SocketNoticeEntity {
  SocketNoticeEntity copyWith({
    String? msgId,
    String? pushType,
    SocketNoticeMsgContent? msgContent,
    String? createTime,
    dynamic groupInfo,
  }) {
    return SocketNoticeEntity()
      ..msgId = msgId ?? this.msgId
      ..pushType = pushType ?? this.pushType
      ..msgContent = msgContent ?? this.msgContent
      ..createTime = createTime ?? this.createTime
      ..groupInfo = groupInfo ?? this.groupInfo;
  }
}

SocketNoticeMsgContent $SocketNoticeMsgContentFromJson(
    Map<String, dynamic> json) {
  final SocketNoticeMsgContent socketNoticeMsgContent = SocketNoticeMsgContent();
  final SocketNoticeMsgContentFriendApply? friendApply = jsonConvert.convert<
      SocketNoticeMsgContentFriendApply>(json['friendApply']);
  if (friendApply != null) {
    socketNoticeMsgContent.friendApply = friendApply;
  }
  final SocketNoticeMsgContentTopicRed? topicRed = jsonConvert.convert<
      SocketNoticeMsgContentTopicRed>(json['topicRed']);
  if (topicRed != null) {
    socketNoticeMsgContent.topicRed = topicRed;
  }
  final SocketNoticeMsgContentTopicReply? topicReply = jsonConvert.convert<
      SocketNoticeMsgContentTopicReply>(json['topicReply']);
  if (topicReply != null) {
    socketNoticeMsgContent.topicReply = topicReply;
  }
  return socketNoticeMsgContent;
}

Map<String, dynamic> $SocketNoticeMsgContentToJson(
    SocketNoticeMsgContent entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['friendApply'] = entity.friendApply?.toJson();
  data['topicRed'] = entity.topicRed?.toJson();
  data['topicReply'] = entity.topicReply?.toJson();
  return data;
}

extension SocketNoticeMsgContentExtension on SocketNoticeMsgContent {
  SocketNoticeMsgContent copyWith({
    SocketNoticeMsgContentFriendApply? friendApply,
    SocketNoticeMsgContentTopicRed? topicRed,
    SocketNoticeMsgContentTopicReply? topicReply,
  }) {
    return SocketNoticeMsgContent()
      ..friendApply = friendApply ?? this.friendApply
      ..topicRed = topicRed ?? this.topicRed
      ..topicReply = topicReply ?? this.topicReply;
  }
}

SocketNoticeMsgContentFriendApply $SocketNoticeMsgContentFriendApplyFromJson(
    Map<String, dynamic> json) {
  final SocketNoticeMsgContentFriendApply socketNoticeMsgContentFriendApply = SocketNoticeMsgContentFriendApply();
  final int? count = jsonConvert.convert<int>(json['count']);
  if (count != null) {
    socketNoticeMsgContentFriendApply.count = count;
  }
  return socketNoticeMsgContentFriendApply;
}

Map<String, dynamic> $SocketNoticeMsgContentFriendApplyToJson(
    SocketNoticeMsgContentFriendApply entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['count'] = entity.count;
  return data;
}

extension SocketNoticeMsgContentFriendApplyExtension on SocketNoticeMsgContentFriendApply {
  SocketNoticeMsgContentFriendApply copyWith({
    int? count,
  }) {
    return SocketNoticeMsgContentFriendApply()
      ..count = count ?? this.count;
  }
}

SocketNoticeMsgContentTopicRed $SocketNoticeMsgContentTopicRedFromJson(
    Map<String, dynamic> json) {
  final SocketNoticeMsgContentTopicRed socketNoticeMsgContentTopicRed = SocketNoticeMsgContentTopicRed();
  return socketNoticeMsgContentTopicRed;
}

Map<String, dynamic> $SocketNoticeMsgContentTopicRedToJson(
    SocketNoticeMsgContentTopicRed entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  return data;
}

extension SocketNoticeMsgContentTopicRedExtension on SocketNoticeMsgContentTopicRed {
}

SocketNoticeMsgContentTopicReply $SocketNoticeMsgContentTopicReplyFromJson(
    Map<String, dynamic> json) {
  final SocketNoticeMsgContentTopicReply socketNoticeMsgContentTopicReply = SocketNoticeMsgContentTopicReply();
  return socketNoticeMsgContentTopicReply;
}

Map<String, dynamic> $SocketNoticeMsgContentTopicReplyToJson(
    SocketNoticeMsgContentTopicReply entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  return data;
}

extension SocketNoticeMsgContentTopicReplyExtension on SocketNoticeMsgContentTopicReply {
}