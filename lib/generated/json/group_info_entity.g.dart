import 'package:rescue_station/generated/json/base/json_convert_content.dart';
import 'package:rescue_station/app/modules/contacts_module/group_list/group_info_entity.dart';

GroupInfoEntity $GroupInfoEntityFromJson(Map<String, dynamic> json) {
  final GroupInfoEntity groupInfoEntity = GroupInfoEntity();
  final String? groupId = jsonConvert.convert<String>(json['groupId']);
  if (groupId != null) {
    groupInfoEntity.groupId = groupId;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    groupInfoEntity.name = name;
  }
  final List<String>? portrait = (json['portrait'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (portrait != null) {
    groupInfoEntity.portrait = portrait;
  }
  return groupInfoEntity;
}

Map<String, dynamic> $GroupInfoEntityToJson(GroupInfoEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['groupId'] = entity.groupId;
  data['name'] = entity.name;
  data['portrait'] = entity.portrait;
  return data;
}

extension GroupInfoEntityExtension on GroupInfoEntity {
  GroupInfoEntity copyWith({
    String? groupId,
    String? name,
    List<String>? portrait,
  }) {
    return GroupInfoEntity()
      ..groupId = groupId ?? this.groupId
      ..name = name ?? this.name
      ..portrait = portrait ?? this.portrait;
  }
}