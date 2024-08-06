import 'package:rescue_station/app/modules/contacts_module/azlistview/az_common.dart';
import 'package:rescue_station/generated/json/base/json_field.dart';
import 'dart:convert';
import '../../generated/json/user_info_entity.g.dart';

@JsonSerializable()
class UserInfoEntity  extends ISuspensionBean {
	String? userId;

	String? portrait;

	String? chatNo;

	String? nickName;

	String? userType;

	String? gender;

	String? cover;

	String? provinces;

	String? city;

	String? intro;

	String? isFriend;

	String? black;

	String? source;

	String? genderLabel;

	String? sourceLabel;

	String? phone;

	String? token;

	bool select = false;

	UserInfoEntity({this.userId,this.nickName});

	factory UserInfoEntity.fromJson(Map<String, dynamic> json) => $UserInfoEntityFromJson(json);

	Map<String, dynamic> toJson() => $UserInfoEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
	String tabIndex = "";

	@override
	String getSuspensionTag() => tabIndex;

}



