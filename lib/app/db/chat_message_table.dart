import 'package:hive/hive.dart';
import 'package:rescue_station/app/db/user_info_table.dart';
import 'package:rescue_station/generated/json/base/json_field.dart';
import 'dart:convert';
import 'package:rescue_station/generated/json/chat_message_table.g.dart';
part 'chat_message_table.g.dart';

///{"msgId":"1805140119376756738","pushType":"MSG","msgContent":{"msgType":"TEXT","content":"哈哈哈哈","top":"N","disturb":"N"},"fromInfo":{"nickName":"上官婉儿","portrait":"http://q3z3-im.oss-cn-beijing.aliyuncs.com/61bed1c563de173eb00e8d8c.png","userId":"1800817039510786049","userType":"self"},"createTime":"2024-06-23 23:25:20","groupInfo":{}}
@HiveType(typeId: 2)
@JsonSerializable()
class ChatMessageTable extends HiveObject{

	@HiveField(0)
	String? msgId;

	@HiveField(1)
	String? pushType;

	@HiveField(2)
	Map<String,dynamic>? msgContent;

	@HiveField(3)
	UserInfoTable? fromInfo;

	@HiveField(4)
	String? createTime;

	@HiveField(5)
	Map<String,dynamic>? groupInfo;

	@HiveField(6)
	String? userId;

	ChatMessageTable({this.msgId,this.pushType,this.msgContent,this.fromInfo,this.createTime,this.groupInfo,this.userId});

	factory ChatMessageTable.fromJson(Map<String, dynamic> json) => $ChatMessageTableFromJson(json);

	Map<String, dynamic> toJson() => $ChatMessageTableToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}



}


