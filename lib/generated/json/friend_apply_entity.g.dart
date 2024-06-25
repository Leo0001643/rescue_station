import 'package:rescue_station/generated/json/base/json_convert_content.dart';
import 'package:rescue_station/app/modules/new_friend/friend_apply_entity.dart';

FriendApplyEntity $FriendApplyEntityFromJson(Map<String, dynamic> json) {
  final FriendApplyEntity friendApplyEntity = FriendApplyEntity();
  final String? applyId = jsonConvert.convert<String>(json['applyId']);
  if (applyId != null) {
    friendApplyEntity.applyId = applyId;
  }
  final String? applyStatus = jsonConvert.convert<String>(json['applyStatus']);
  if (applyStatus != null) {
    friendApplyEntity.applyStatus = applyStatus;
  }
  final String? applySource = jsonConvert.convert<String>(json['applySource']);
  if (applySource != null) {
    friendApplyEntity.applySource = applySource;
  }
  final String? applyType = jsonConvert.convert<String>(json['applyType']);
  if (applyType != null) {
    friendApplyEntity.applyType = applyType;
  }
  final String? reason = jsonConvert.convert<String>(json['reason']);
  if (reason != null) {
    friendApplyEntity.reason = reason;
  }
  final String? createTime = jsonConvert.convert<String>(json['createTime']);
  if (createTime != null) {
    friendApplyEntity.createTime = createTime;
  }
  final String? userId = jsonConvert.convert<String>(json['userId']);
  if (userId != null) {
    friendApplyEntity.userId = userId;
  }
  final String? portrait = jsonConvert.convert<String>(json['portrait']);
  if (portrait != null) {
    friendApplyEntity.portrait = portrait;
  }
  final String? nickName = jsonConvert.convert<String>(json['nickName']);
  if (nickName != null) {
    friendApplyEntity.nickName = nickName;
  }
  final String? applySourceLabel = jsonConvert.convert<String>(
      json['applySourceLabel']);
  if (applySourceLabel != null) {
    friendApplyEntity.applySourceLabel = applySourceLabel;
  }
  return friendApplyEntity;
}

Map<String, dynamic> $FriendApplyEntityToJson(FriendApplyEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['applyId'] = entity.applyId;
  data['applyStatus'] = entity.applyStatus;
  data['applySource'] = entity.applySource;
  data['applyType'] = entity.applyType;
  data['reason'] = entity.reason;
  data['createTime'] = entity.createTime;
  data['userId'] = entity.userId;
  data['portrait'] = entity.portrait;
  data['nickName'] = entity.nickName;
  data['applySourceLabel'] = entity.applySourceLabel;
  return data;
}

extension FriendApplyEntityExtension on FriendApplyEntity {
  FriendApplyEntity copyWith({
    String? applyId,
    String? applyStatus,
    String? applySource,
    String? applyType,
    String? reason,
    String? createTime,
    String? userId,
    String? portrait,
    String? nickName,
    String? applySourceLabel,
  }) {
    return FriendApplyEntity()
      ..applyId = applyId ?? this.applyId
      ..applyStatus = applyStatus ?? this.applyStatus
      ..applySource = applySource ?? this.applySource
      ..applyType = applyType ?? this.applyType
      ..reason = reason ?? this.reason
      ..createTime = createTime ?? this.createTime
      ..userId = userId ?? this.userId
      ..portrait = portrait ?? this.portrait
      ..nickName = nickName ?? this.nickName
      ..applySourceLabel = applySourceLabel ?? this.applySourceLabel;
  }
}