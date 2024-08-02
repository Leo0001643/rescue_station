import 'package:common_utils/common_utils.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:rescue_station/app/db/db_helper.dart';
import 'package:rescue_station/app/domains/message_type_enum.dart';
import 'package:rescue_station/app/domains/upload_file_entity.dart';
import 'package:rescue_station/app/event/chat_event.dart';
import 'package:rescue_station/app/event/new_chat_event.dart';
import 'package:rescue_station/app/routes/api_info.dart';
import 'package:rescue_station/app/routes/app_pages.dart';
import 'package:rescue_station/app/socket/socket_message_entity.dart';
import 'package:rescue_station/app/socket/socket_utils.dart';
import 'package:rescue_station/app/utils/app_data.dart';
import 'package:rescue_station/app/utils/dio_utils.dart';
import 'package:rescue_station/app/utils/logger.dart';
import 'package:rescue_station/app/utils/widget_utils.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import 'forward_message_state.dart';

class ForwardMessageLogic extends GetxController {
  final ForwardMessageState state = ForwardMessageState();

  @override
  void onReady() {
    getMessageList();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getMessageList() {
    var user = AppData.getUser();
    if (isNotEmpty(user)) {
      DbHelper().queryMessageBox(user!.userId.em()).then((v) {
        loggerArray(["查询消息列表结果", v, MessageTypeEnum.TEXT.name]);
        state.messages.value = v;
      });
    }
  }


  void sendFriend(ChatEvent event,types.Message msg) async {
    loggerArray(["socket状态", SocketUtils().isConnect]);
    var content = "";
    var msgType = "";
    UploadFileEntity? uploadFile;
    EasyLoading.show();
    if (msg is types.TextMessage) {
      content = msg.text;
      msgType = MessageTypeEnum.TEXT.name;
    } else if (msg is types.ImageMessage) {
      uploadFile = UploadFileEntity(fullPath: msg.uri, fileName: msg.name,
          fileSize: SocketUtils().parseFileSize(msg.size.toDouble()),fileType: msg.uri.split(".").last);
      content = uploadFile.fullPath ?? '';
      msgType = MessageTypeEnum.IMAGE.name;
    } else if (msg is types.FileMessage) {
      uploadFile = UploadFileEntity(fullPath: msg.uri, fileName: msg.name,
          fileSize: SocketUtils().parseFileSize(msg.size.toDouble()),fileType: msg.uri.split(".").last);
      content = uploadFile.fullPath ?? '';
      msgType = MessageTypeEnum.FILE.name;
    }
    if (content.isEmpty) {
      EasyLoading.dismiss();
      return;
    }
    var params = {
      "userId": event.friend.userId.em(),
      "msgType": msgType,
      "content": content
    };
    DioUtil().post(Api.CHAT_SEND_MESSAGE, data: params).then((result) {
      EasyLoading.dismiss();
      if (result.data["code"] == 200) {
        if (result.data["data"]["status"] != "0") {
          Get.snackbar("提示", result.data["data"]["statusLabel"]);
          return;
        }
        var socketMsg = SocketMessageEntity();
        socketMsg.msgId = result.data["data"]["msgId"];
        socketMsg.boxId = event.friend.userId.em();
        socketMsg.pushType = 'MSG';
        socketMsg.createTime = DateUtil.getNowDateStr();
        socketMsg.groupInfo = null;
        socketMsg.fromInfo = event.friend;
        var msgContent = SocketMsgContent();
        msgContent.disturb = 'N';
        msgContent.top = 'N';
        msgContent.content = uploadFile == null
            ? content
            : JsonUtil.encodeObj(uploadFile.toJson());
        msgContent.msgType = msgType;
        socketMsg.msgContent = msgContent;
        // insertMessageList(
        //     msgContent, chatCtl.user.toJson(), socketMsg.createTime.em());

        ///缓存消息到数据库
        DbHelper().messageInsertOrUpdate(true, socketMsg).then((v) {
          eventBus.fire(NewChatEvent()); //有新消息，需要刷新列表
          Get.back(result: true);
        });
      } else if(result.data["code"] == 401){
        WidgetUtils.logSqueezeOut();
      } else {
        Get.snackbar('提醒', result.data["msg"]);
      }
    }).onError((e, stack) {
      EasyLoading.dismiss();
      Get.snackbar('提醒', "系统异常！");
    });
  }

  void sendGroup(ChatGroupEvent event,types.Message msg) async {
    loggerArray(["socket状态", SocketUtils().isConnect]);
    EasyLoading.show();
    var content = "";
    var msgType = "";
    UploadFileEntity? uploadFile;
    if (msg is types.TextMessage) {
      content = msg.text;
      msgType = MessageTypeEnum.TEXT.name;
    } else if (msg is types.ImageMessage) {
      uploadFile = UploadFileEntity(fullPath: msg.uri, fileName: msg.name,
          fileSize: SocketUtils().parseFileSize(msg.size.toDouble()),fileType: msg.uri.split(".").last);
      content = uploadFile.fullPath ?? '';
      msgType = MessageTypeEnum.IMAGE.name;
    } else if (msg is types.FileMessage) {
      uploadFile = UploadFileEntity(fullPath: msg.uri, fileName: msg.name,
          fileSize: SocketUtils().parseFileSize(msg.size.toDouble()),fileType: msg.uri.split(".").last);
      content = uploadFile.fullPath ?? '';
      msgType = MessageTypeEnum.FILE.name;
    }
    if (content.isEmpty) {
      EasyLoading.dismiss();
      return;
    }
    var params = {
      "groupId": event.group.groupId.em(),
      "msgType": msgType,
      "content": content
    };
    DioUtil().post(Api.GROUP_SEND_MSG, data: params).then((result) {
      EasyLoading.dismiss();
      if (result.data["code"] == 200) {
        if (result.data["data"]["status"] != "0") {
          Get.snackbar("提示", result.data["data"]["statusLabel"]);
          return;
        }
        // state.messages.insert(0, msg);
        var socketMsg = SocketMessageEntity();
        socketMsg.msgId = result.data["msgId"];
        socketMsg.boxId = event.group.groupId.em();
        socketMsg.pushType = 'MSG';
        socketMsg.createTime = DateUtil.getNowDateStr();
        socketMsg.fromInfo = null;
        // socketMsg.groupInfo = null;
        socketMsg.groupInfo = event.group;
        var msgContent = SocketMsgContent();
        msgContent.disturb = 'N';
        msgContent.top = 'N';
        msgContent.content = uploadFile == null
            ? content
            : JsonUtil.encodeObj(uploadFile.toJson());
        msgContent.msgType = msgType;
        socketMsg.msgContent = msgContent;
        // insertMessageList(
        //     msgContent, chatCtl.user.toJson(), socketMsg.createTime.em());

        ///缓存消息到数据库
        DbHelper().messageInsertOrUpdate(true, socketMsg).then((v) {
          eventBus.fire(NewChatEvent()); //有新消息，需要刷新列表
          Get.back(result: true);
        });
      } else if(result.data["code"] == 401){
        WidgetUtils.logSqueezeOut();
      } else {
        Get.snackbar('提醒', result.data["msg"]);
      }
    }).onError((e, stack) {
      EasyLoading.dismiss();
      Get.snackbar('提醒', "系统异常！");
    });
  }



}
