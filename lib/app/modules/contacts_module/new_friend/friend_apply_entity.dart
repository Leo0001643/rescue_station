import 'dart:convert';

import 'package:rescue_station/generated/json/base/json_field.dart';
import 'package:rescue_station/generated/json/friend_apply_entity.g.dart';

export 'package:rescue_station/generated/json/friend_apply_entity.g.dart';

@JsonSerializable()
class FriendApplyEntity {
	String? applyId;
	String? applyStatus;
	String? applySource;
	String? applyType;
	String? reason;
	String? createTime;
	String? userId;
	String? portrait;
	String? nickName;
	String? applySourceLabel;

	FriendApplyEntity();

	factory FriendApplyEntity.fromJson(Map<String, dynamic> json) => $FriendApplyEntityFromJson(json);

	Map<String, dynamic> toJson() => $FriendApplyEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}