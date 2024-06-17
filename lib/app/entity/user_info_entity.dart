import 'package:rescue_station/generated/json/base/json_field.dart';
import 'package:rescue_station/generated/json/user_info_entity.g.dart';
import 'dart:convert';
export 'package:rescue_station/generated/json/user_info_entity.g.dart';

@JsonSerializable()
class UserInfoEntity {
	String? userId;
	String? portrait;
	String? chatNo;
	String? nickName;
	String? userType;

	UserInfoEntity();

	factory UserInfoEntity.fromJson(Map<String, dynamic> json) => $UserInfoEntityFromJson(json);

	Map<String, dynamic> toJson() => $UserInfoEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}