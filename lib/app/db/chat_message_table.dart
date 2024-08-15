import 'package:rescue_station/app/domains/user_info_entity.dart';
import 'package:rescue_station/app/routes/app_pages.dart';
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

	String? refMsg;

	String? boxId;///对应聊天框的boxId

	String? userId;///用于标识当前消息属于哪个登录用户

	ChatMessageTable({this.msgId,this.pushType,this.msgContent,this.fromInfo,this.createTime,this.groupInfo,this.boxId,this.userId});

	factory ChatMessageTable.fromJson(Map<String, dynamic> json) => $ChatMessageTableFromJson(json);

	factory ChatMessageTable.fromJson2(String userId,String boxId,UserInfoEntity fromInfo,SocketMessageEntity entity){
		var chat = ChatMessageTable.fromJson(entity.toJson());
		chat.userId = userId;
		chat.boxId = boxId;
		chat.msgContent = jsonEncode(entity.msgContent?.toJson());
		chat.fromInfo = jsonEncode(fromInfo.toJson());
		chat.groupInfo = jsonEncode(entity.groupInfo?.toJson());
		chat.refMsg = jsonEncode(entity.refMsg?.toJson());
		return chat;
	}



	Map<String, dynamic> toJson() => $ChatMessageTableToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}

	Map<String,dynamic> getMsgContent(){
		if(isEmpty(msgContent)){
			return {};
		}else {
			return jsonDecode(msgContent.em());
		}
	}

	Map<String,dynamic> getFromInfo() {
		if(isEmpty(fromInfo)){
			return {};
		}else {
			return jsonDecode(fromInfo.em());
		}
	}

	Map<String,dynamic> getGroupInfo(){
		if(isEmpty(groupInfo)){
			return {};
		}else {
			return jsonDecode(groupInfo.em());
		}
	}

	Map<String,dynamic> getRefMsg(){
		if(isEmpty(refMsg)){
			return {};
		}else {
			return jsonDecode(refMsg.em());
		}
	}

}


