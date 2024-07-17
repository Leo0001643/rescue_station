import 'package:rescue_station/generated/json/base/json_convert_content.dart';
import 'package:rescue_station/app/domains/group_detail_entity.dart';

GroupDetailEntity $GroupDetailEntityFromJson(Map<String, dynamic> json) {
  final GroupDetailEntity groupDetailEntity = GroupDetailEntity();
  final List<GroupDetailUser>? user = (json['user'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<GroupDetailUser>(e) as GroupDetailUser)
      .toList();
  if (user != null) {
    groupDetailEntity.user = user;
  }
  final GroupDetailGroup? group = jsonConvert.convert<GroupDetailGroup>(
      json['group']);
  if (group != null) {
    groupDetailEntity.group = group;
  }
  final GroupDetailSet? set = jsonConvert.convert<GroupDetailSet>(json['set']);
  if (set != null) {
    groupDetailEntity.set = set;
  }
  final String? master = jsonConvert.convert<String>(json['master']);
  if (master != null) {
    groupDetailEntity.master = master;
  }
  return groupDetailEntity;
}

Map<String, dynamic> $GroupDetailEntityToJson(GroupDetailEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['user'] = entity.user?.map((v) => v.toJson()).toList();
  data['group'] = entity.group?.toJson();
  data['set'] = entity.set?.toJson();
  data['master'] = entity.master;
  return data;
}

extension GroupDetailEntityExtension on GroupDetailEntity {
  GroupDetailEntity copyWith({
    List<GroupDetailUser>? user,
    GroupDetailGroup? group,
    GroupDetailSet? set,
    String? master,
  }) {
    return GroupDetailEntity()
      ..user = user ?? this.user
      ..group = group ?? this.group
      ..set = set ?? this.set
      ..master = master ?? this.master;
  }
}

GroupDetailUser $GroupDetailUserFromJson(Map<String, dynamic> json) {
  final GroupDetailUser groupDetailUser = GroupDetailUser();
  final String? userId = jsonConvert.convert<String>(json['userId']);
  if (userId != null) {
    groupDetailUser.userId = userId;
  }
  final String? nickName = jsonConvert.convert<String>(json['nickName']);
  if (nickName != null) {
    groupDetailUser.nickName = nickName;
  }
  final String? portrait = jsonConvert.convert<String>(json['portrait']);
  if (portrait != null) {
    groupDetailUser.portrait = portrait;
  }
  return groupDetailUser;
}

Map<String, dynamic> $GroupDetailUserToJson(GroupDetailUser entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['userId'] = entity.userId;
  data['nickName'] = entity.nickName;
  data['portrait'] = entity.portrait;
  return data;
}

extension GroupDetailUserExtension on GroupDetailUser {
  GroupDetailUser copyWith({
    String? userId,
    String? nickName,
    String? portrait,
  }) {
    return GroupDetailUser()
      ..userId = userId ?? this.userId
      ..nickName = nickName ?? this.nickName
      ..portrait = portrait ?? this.portrait;
  }
}

GroupDetailGroup $GroupDetailGroupFromJson(Map<String, dynamic> json) {
  final GroupDetailGroup groupDetailGroup = GroupDetailGroup();
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    groupDetailGroup.name = name;
  }
  final String? notice = jsonConvert.convert<String>(json['notice']);
  if (notice != null) {
    groupDetailGroup.notice = notice;
  }
  final String? groupId = jsonConvert.convert<String>(json['groupId']);
  if (groupId != null) {
    groupDetailGroup.groupId = groupId;
  }
  final List<String>? portrait = (json['portrait'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (portrait != null) {
    groupDetailGroup.portrait = portrait;
  }
  return groupDetailGroup;
}

Map<String, dynamic> $GroupDetailGroupToJson(GroupDetailGroup entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['name'] = entity.name;
  data['notice'] = entity.notice;
  data['groupId'] = entity.groupId;
  data['portrait'] = entity.portrait;
  return data;
}

extension GroupDetailGroupExtension on GroupDetailGroup {
  GroupDetailGroup copyWith({
    String? name,
    String? notice,
    String? groupId,
    List<String>? portrait,
  }) {
    return GroupDetailGroup()
      ..name = name ?? this.name
      ..notice = notice ?? this.notice
      ..groupId = groupId ?? this.groupId
      ..portrait = portrait ?? this.portrait;
  }
}

GroupDetailSet $GroupDetailSetFromJson(Map<String, dynamic> json) {
  final GroupDetailSet groupDetailSet = GroupDetailSet();
  final String? top = jsonConvert.convert<String>(json['top']);
  if (top != null) {
    groupDetailSet.top = top;
  }
  final String? disturb = jsonConvert.convert<String>(json['disturb']);
  if (disturb != null) {
    groupDetailSet.disturb = disturb;
  }
  final String? keepGroup = jsonConvert.convert<String>(json['keepGroup']);
  if (keepGroup != null) {
    groupDetailSet.keepGroup = keepGroup;
  }
  return groupDetailSet;
}

Map<String, dynamic> $GroupDetailSetToJson(GroupDetailSet entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['top'] = entity.top;
  data['disturb'] = entity.disturb;
  data['keepGroup'] = entity.keepGroup;
  return data;
}

extension GroupDetailSetExtension on GroupDetailSet {
  GroupDetailSet copyWith({
    String? top,
    String? disturb,
    String? keepGroup,
  }) {
    return GroupDetailSet()
      ..top = top ?? this.top
      ..disturb = disturb ?? this.disturb
      ..keepGroup = keepGroup ?? this.keepGroup;
  }
}