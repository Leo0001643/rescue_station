import 'package:hive_flutter/adapters.dart';
import 'package:rescue_station/generated/json/base/json_field.dart';
import 'dart:convert';
import 'package:rescue_station/generated/json/user_info_table.g.dart';
part 'user_info_table.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class UserInfoTable extends HiveObject{
	@HiveField(0)
	String? userId;

	@HiveField(1)
	String? portrait;

	@HiveField(2)
	String? chatNo;

	@HiveField(3)
	String? nickName;

	@HiveField(4)
	String? userType;

	@HiveField(5)
	String? gender;

	@HiveField(6)
	String? cover;

	@HiveField(7)
	String? provinces;

	@HiveField(8)
	String? city;

	@HiveField(9)
	String? intro;

	@HiveField(10)
	String? isFriend;

	@HiveField(11)
	String? black;

	@HiveField(12)
	String? source;

	@HiveField(13)
	String? genderLabel;

	@HiveField(14)
	String? sourceLabel;

	@HiveField(15)
	String? phone;

	@HiveField(16)
	String? token;


	UserInfoTable({this.userId});

	factory UserInfoTable.fromJson(Map<String, dynamic> json) => $UserInfoTableFromJson(json);

	Map<String, dynamic> toJson() => $UserInfoTableToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}




}



