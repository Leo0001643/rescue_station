import 'package:get/get.dart';
import 'package:rescue_station/app/utils/widget_utils.dart';

import '../../../event/new_chat_event.dart';
import '../../../routes/api_info.dart';
import '../../../routes/app_pages.dart';
import '../../../socket/socket_utils.dart';
import '../../../utils/dio_utils.dart';
import '../../../utils/logger.dart';
import '../chat_by_friend/bottom_chat_controller.dart';
import 'chat_by_group_state.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class ChatByGroupLogic extends GetxController {
  final ChatByGroupState state = ChatByGroupState();
  final chatCtl = Get.find<BottomChatController>();

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void sendMessage(types.Message msg){
    loggerArray(["socket状态",SocketUtils().isConnect]);
    var content = "";
    var msgType = "";
    if(msg is types.TextMessage){
      content = msg.text;
      msgType = "TEXT";
    }
    var params = {"groupId": chatCtl.group.groupId.em(),"msgType":msgType,"content": content};
    DioUtil().post(Api.GROUP_SEND_MSG,data: params).then((result){
      if(result.data["code"] == 200){
        state.messages.insert(0, msg);
        /*///缓存消息到数据库
        DbHelper().addChatMessageBox(ChatMessageTable.fromJson(message.toJson()));
        DbHelper().findMessageBox(chatCtl.user.userId.em()).then((v){
          if(ObjectUtil.isEmpty(v)){
            DbHelper().addMessageBox(MessageBoxTable(boxId: message.msgId,userId: chatCtl.user.userId.em(),lastMessage: message.msgContent?.toJson(),
              lastMessageTime: DateUtil.getDateMsByTimeStr(message.createTime.em()),unreadCount: 0,fromInfo: message.fromInfo?.toJson(),));
          } else {
            v!.fromInfo = message.fromInfo?.toJson();
            v.lastMessageTime = DateUtil.getDateMsByTimeStr(message.createTime.em());
            v.lastMessage = message.msgContent?.toJson();
            DbHelper().updateMessageBox(v);
          }
        });*/
        eventBus.fire(NewChatEvent());//有新消息，需要刷新列表
      } else {
        Get.snackbar('提醒', result.data["msg"]);
      }
    }).onError((e,stack){
      Get.snackbar('提醒', "系统异常！");
    });
  }




}
