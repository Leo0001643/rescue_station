import 'package:rescue_station/app/domains/group_info_entity.dart';
import 'package:rescue_station/app/domains/user_info_entity.dart';
import 'package:rescue_station/generated/json/base/json_field.dart';
import 'dart:convert';

import 'package:rescue_station/generated/json/socket_message_entity.g.dart';

///{"msgId":"1805140119376756738","pushType":"MSG","msgContent":{"msgType":"TEXT","content":"哈哈哈哈","top":"N","disturb":"N"},"fromInfo":{"nickName":"上官婉儿","portrait":"http://q3z3-im.oss-cn-beijing.aliyuncs.com/61bed1c563de173eb00e8d8c.png","userId":"1800817039510786049","userType":"self"},"createTime":"2024-06-23 23:25:20","groupInfo":{}}

@JsonSerializable()
class SocketMessageEntity {
	String? msgId;
	String? pushType;
	String? boxId;///用于在聊天窗口区分消息来自哪个群组或好友
	SocketMsgContent? msgContent;
	SocketRefMsgContent? refMsg;
	UserInfoEntity? fromInfo;
	String? createTime;
	GroupInfoEntity? groupInfo;

	SocketMessageEntity();

	factory SocketMessageEntity.fromJson(Map<String, dynamic> json) => $SocketMessageEntityFromJson(json);

	Map<String, dynamic> toJson() => $SocketMessageEntityToJson(this);


	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class SocketMsgContent {
	String? msgType;
	String? content;
	String? top;
	String? disturb;

	SocketMsgContent();

	factory SocketMsgContent.fromJson(Map<String, dynamic> json) => $SocketMsgContentFromJson(json);

	Map<String, dynamic> toJson() => $SocketMsgContentToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class SocketRefMsgContent {
	String? msgType;
	String? content;
	String? msgId;
	String? nickName;

	SocketRefMsgContent({this.msgType,this.content,this.msgId,this.nickName});

	factory SocketRefMsgContent.fromJson(Map<String, dynamic> json) => $SocketRefMsgContentFromJson(json);

	Map<String, dynamic> toJson() => $SocketRefMsgContentToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}



}