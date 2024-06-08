import 'dart:convert';

class MarqueeEntity {
	String? msg;
	int? code;
	Data? data;

	MarqueeEntity({
		this.msg,
		this.code,
		this.data,
	});

	factory MarqueeEntity.fromRawJson(String str) => MarqueeEntity.fromJson(json.decode(str));

	String toRawJson() => json.encode(toJson());

	factory MarqueeEntity.fromJson(Map<String, dynamic> json) => MarqueeEntity(
		msg: json["msg"],
		code: json["code"],
		data: json["data"] == null ? null : Data.fromJson(json["data"]),
	);

	Map<String, dynamic> toJson() => {
		"msg": msg,
		"code": code,
		"data": data?.toJson(),
	};
}

class Data {
	String? id;
	String? content;
	DateTime? createTime;

	Data({
		this.id,
		this.content,
		this.createTime,
	});

	factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

	String toRawJson() => json.encode(toJson());

	factory Data.fromJson(Map<String, dynamic> json) => Data(
		id: json["id"],
		content: json["content"],
		createTime: json["createTime"] == null ? null : DateTime.parse(json["createTime"]),
	);

	Map<String, dynamic> toJson() => {
		"id": id,
		"content": content,
		"createTime": createTime?.toIso8601String(),
	};
}
