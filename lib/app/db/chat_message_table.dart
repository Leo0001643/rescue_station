import 'package:rescue_station/app/socket/socket_message_entity.dart';
import 'package:rescue_station/app/utils/widget_utils.dart';
import 'package:rescue_station/generated/json/base/json_field.dart';
import 'dart:convert';
import 'package:rescue_station/generated/json/chat_message_table.g.dart';


///{"msgId":"1805140119376756738","pushType":"MSG","msgContent":{"msgType":"TEXT","content":"哈哈哈哈","top":"N","disturb":"N"},"fromInfo":{"nickName":"上官婉儿","portrait":"http://q3z3-im.oss-cn-beijing.aliyuncs.com/61bed1c563de173eb00e8d8c.png","userId":"1800817039510786049","userType":"self"},"createTime":"2024-06-23 23:25:20","groupInfo":{}}
@JsonSerializable()
class ChatMessageTable{
	int? id;

	String? msgId;

	String? pushType;

	String? msgContent;

	String? fromInfo;

	String? createTime;

	String? groupInfo;

	String? userId;

	ChatMessageTable({this.msgId,this.pushType,this.msgContent,this.fromInfo,this.createTime,this.groupInfo,this.userId});

	factory ChatMessageTable.fromJson(Map<String, dynamic> json) => $ChatMessageTableFromJson(json);

	factory ChatMessageTable.fromJson2(SocketMessageEntity entity){
		var chat = ChatMessageTable.fromJson(entity.toJson());
		chat.msgContent = jsonEncode(entity.msgContent?.toJson());
		chat.fromInfo = jsonEncode(entity.fromInfo?.toJson());
		chat.groupInfo = jsonEncode(entity.groupInfo?.toJson());
		return chat;
	}



	Map<String, dynamic> toJson() => $ChatMessageTableToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}

	Map<String,dynamic> getMsgContent() => jsonDecode(msgContent.em());

	Map<String,dynamic> getFromInfo() => jsonDecode(fromInfo.em());

	Map<String,dynamic> getGroupInfo() => jsonDecode(groupInfo.em());

}


