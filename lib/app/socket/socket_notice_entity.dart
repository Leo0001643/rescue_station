import 'package:rescue_station/generated/json/base/json_field.dart';
import 'package:rescue_station/generated/json/socket_notice_entity.g.dart';
import 'dart:convert';
export 'package:rescue_station/generated/json/socket_notice_entity.g.dart';

@JsonSerializable()
class SocketNoticeEntity {
	String? msgId;
	String? pushType;
	SocketNoticeMsgContent? msgContent;
	String? createTime;
	dynamic groupInfo;

	SocketNoticeEntity();

	factory SocketNoticeEntity.fromJson(Map<String, dynamic> json) => $SocketNoticeEntityFromJson(json);

	Map<String, dynamic> toJson() => $SocketNoticeEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

///{"msgId":"1806598850434293761","pushType":"NOTICE","msgContent":{"friendApply":{"count":1},"topicRed":{},"topicReply":{}},"createTime":"2024-06-28 00:01:45","groupInfo":{}}
@JsonSerializable()
class SocketNoticeMsgContent {
	SocketNoticeMsgContentFriendApply? friendApply;
	SocketNoticeMsgContentTopicRed? topicRed;
	SocketNoticeMsgContentTopicReply? topicReply;

	SocketNoticeMsgContent();

	factory SocketNoticeMsgContent.fromJson(Map<String, dynamic> json) => $SocketNoticeMsgContentFromJson(json);

	Map<String, dynamic> toJson() => $SocketNoticeMsgContentToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class SocketNoticeMsgContentFriendApply {
	int? count;

	SocketNoticeMsgContentFriendApply();

	factory SocketNoticeMsgContentFriendApply.fromJson(Map<String, dynamic> json) => $SocketNoticeMsgContentFriendApplyFromJson(json);

	Map<String, dynamic> toJson() => $SocketNoticeMsgContentFriendApplyToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class SocketNoticeMsgContentTopicRed {

	SocketNoticeMsgContentTopicRed();

	factory SocketNoticeMsgContentTopicRed.fromJson(Map<String, dynamic> json) => $SocketNoticeMsgContentTopicRedFromJson(json);

	Map<String, dynamic> toJson() => $SocketNoticeMsgContentTopicRedToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class SocketNoticeMsgContentTopicReply {

	SocketNoticeMsgContentTopicReply();

	factory SocketNoticeMsgContentTopicReply.fromJson(Map<String, dynamic> json) => $SocketNoticeMsgContentTopicReplyFromJson(json);

	Map<String, dynamic> toJson() => $SocketNoticeMsgContentTopicReplyToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}
