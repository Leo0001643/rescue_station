import 'package:rescue_station/generated/json/base/json_field.dart';
import 'package:rescue_station/generated/json/group_detail_entity.g.dart';
import 'dart:convert';
export 'package:rescue_station/generated/json/group_detail_entity.g.dart';

@JsonSerializable()
class GroupDetailEntity {
	List<GroupDetailUser>? user;
	GroupDetailGroup? group;
	GroupDetailSet? set;
	String? master;

	GroupDetailEntity();

	factory GroupDetailEntity.fromJson(Map<String, dynamic> json) => $GroupDetailEntityFromJson(json);

	Map<String, dynamic> toJson() => $GroupDetailEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}

	bool getIsMaster() => master == 'Y';


}

@JsonSerializable()
class GroupDetailUser {
	String? userId;
	String? nickName;
	String? portrait;

	GroupDetailUser();

	factory GroupDetailUser.fromJson(Map<String, dynamic> json) => $GroupDetailUserFromJson(json);

	Map<String, dynamic> toJson() => $GroupDetailUserToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GroupDetailGroup {
	String? name;
	String? notice;
	String? groupId;
	List<String>? portrait;

	GroupDetailGroup();

	factory GroupDetailGroup.fromJson(Map<String, dynamic> json) => $GroupDetailGroupFromJson(json);

	Map<String, dynamic> toJson() => $GroupDetailGroupToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GroupDetailSet {
	String? top;
	String? disturb;
	String? keepGroup;

	GroupDetailSet();

	factory GroupDetailSet.fromJson(Map<String, dynamic> json) => $GroupDetailSetFromJson(json);

	Map<String, dynamic> toJson() => $GroupDetailSetToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}