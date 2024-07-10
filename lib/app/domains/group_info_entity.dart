import 'package:common_utils/common_utils.dart';
import 'package:rescue_station/generated/json/base/json_field.dart';
import 'package:rescue_station/generated/json/group_info_entity.g.dart';
import 'dart:convert';
export 'package:rescue_station/generated/json/group_info_entity.g.dart';

@JsonSerializable()
class GroupInfoEntity {
	String? groupId;
	String? name;
	List<String>? portrait;

	GroupInfoEntity();

	factory GroupInfoEntity.fromJson(Map<String, dynamic> json) => $GroupInfoEntityFromJson(json);

	Map<String, dynamic> toJson() => $GroupInfoEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}

	
	
}