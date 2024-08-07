import 'dart:async';

import 'package:common_utils/common_utils.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:rescue_station/app/db/db_helper.dart';
import 'package:rescue_station/app/domains/group_detail_entity.dart';
import 'package:rescue_station/app/domains/item_model.dart';
import 'package:rescue_station/app/domains/message_type_enum.dart';
import 'package:rescue_station/app/domains/upload_file_entity.dart';
import 'package:rescue_station/app/domains/user_info_entity.dart';
import 'package:rescue_station/app/event/add_group_event.dart';
import 'package:rescue_station/app/event/chat_event.dart';
import 'package:rescue_station/app/event/edit_group_name_event.dart';
import 'package:rescue_station/app/socket/socket_message_entity.dart';
import 'package:rescue_station/app/utils/app_data.dart';
import 'package:rescue_station/app/utils/data_utils.dart';
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
  StreamSubscription? msgReceiveSub;
  StreamSubscription? msgClearSub;
  StreamSubscription? editNameSub;
  StreamSubscription? addGroupSub;

  @override
  void onReady() {
    msgReceiveSub = eventBus.on<SocketMessageEntity>().listen((message) {
      if (message.boxId == chatCtl.group.groupId) {
        insertMessageList(message, message.fromInfo!.toJson(), message.createTime.em(),replied: DataUtils.getRefMsg(message.refMsg));
      }
    });
    msgClearSub = eventBus.on<ChartHistoryClearEvent>().listen((event) {
      ///刷新消息列表
      queryChatMessage();
    });
    editNameSub = eventBus.on<EditGroupNameEvent>().listen((event){
      chatCtl.group.name = event.name;
      state.groupDetail.value.group?.name = event.name;
      state.pageTitle.value = event.name;
    });
    addGroupSub = eventBus.on<AddGroupEvent>().listen((event){
      loadGroupDetail();
    });
    super.onReady();
  }

  @override
  void onClose() {
    addGroupSub?.cancel();
    editNameSub?.cancel();
    msgReceiveSub?.cancel();
    msgClearSub?.cancel();
    state.popCtlList.forEach((v)=> v.dispose());
    state.popCtlList.clear();
    super.onClose();
  }

  void sendMessage(types.Message msg) async {
    loggerArray(["socket状态", SocketUtils().isConnect]);
    EasyLoading.show();
    var content = "";
    var msgType = "";
    UploadFileEntity? uploadFile;
    if (msg is types.TextMessage) {
      content = msg.text;
      msgType = MessageTypeEnum.TEXT.name;
    } else if (msg is types.ImageMessage) {
      if (GetPlatform.isWeb) {
        var bytes = msg.metadata!["file"];
        uploadFile = await DioUtil.uploadWebFile(msg.name, bytes);
      } else {
        uploadFile = await DioUtil.uploadFile(msg.name, msg.uri.em());
      }
      content = uploadFile?.fullPath ?? '';
      msgType = MessageTypeEnum.IMAGE.name;
    } else if (msg is types.FileMessage) {
      if (GetPlatform.isWeb) {
        var bytes = msg.metadata!["file"];
        uploadFile = await DioUtil.uploadWebFile(msg.name, bytes);
      } else {
        uploadFile = await DioUtil.uploadFile(msg.name, msg.uri.em());
      }
      content = uploadFile?.fullPath ?? '';
      msgType = MessageTypeEnum.FILE.name;
    }
    if (content.isEmpty) {
      EasyLoading.dismiss();
      return;
    }
    var params = {
      "groupId": chatCtl.group.groupId.em(),
      "msgType": msgType,
      "content": content,
    };
    if(chatCtl.replyMessage.value !=null){
      params["refMsgId"] = chatCtl.replyMessage.value!.metadata?["msgId"] ?? "";
    }
    DioUtil().post(Api.GROUP_SEND_MSG, data: params).then((result) {
      EasyLoading.dismiss();
      if (result.data["code"] == 200) {
        if (result.data["data"]["status"] != "0") {
          Get.snackbar("提示", result.data["data"]["statusLabel"]);
          return;
        }
        // state.messages.insert(0, msg);
        var socketMsg = SocketMessageEntity();
        socketMsg.msgId = result.data["data"]["msgId"];
        socketMsg.boxId = chatCtl.group.groupId.em();
        socketMsg.pushType = 'MSG';
        socketMsg.createTime = DateUtil.getNowDateStr();
        socketMsg.fromInfo = null;
        // socketMsg.groupInfo = null;
        socketMsg.groupInfo = chatCtl.group;
        var msgContent = SocketMsgContent();
        msgContent.disturb = 'N';
        msgContent.top = 'N';
        msgContent.content = uploadFile == null ? content : JsonUtil.encodeObj(uploadFile.toJson());
        msgContent.msgType = msgType;
        if(chatCtl.replyMessage.value != null){
          socketMsg.refMsg = buildRefMessage(socketMsg.msgId.em(),chatCtl.replyMessage.value!);
        }
        socketMsg.msgContent = msgContent;
        insertMessageList(socketMsg, chatCtl.user.toJson(), socketMsg.createTime.em(),replied: DataUtils.getRefMsg(socketMsg.refMsg));
        chatCtl.replyMessage.value = null;
        ///缓存消息到数据库
        DbHelper().messageInsertOrUpdate(true, socketMsg).then((v) {
          eventBus.fire(NewChatEvent()); //有新消息，需要刷新列表
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

  void loadGroupDetail(){
    loggerArray(["群详情", state.chatEvent.messageBox.toJson()]);
    DioUtil().get(Api.GET_GROUP_INFO + state.chatEvent.messageBox.boxId.em(),).then((result) {
      if (result.data["code"] == 200) {
        state.groupDetail.value = GroupDetailEntity.fromJson(result.data['data']);
      } else if(result.data["code"] == 401){
        WidgetUtils.logSqueezeOut();
      } else {
        Get.snackbar('提醒', result.data["msg"]);
      }
    }).onError((e, stack) {
      Get.snackbar('提醒', "系统异常！");
    });
  }

  void queryChatMessage() {
    DbHelper().queryChatMessageBox(AppData.getUser()!.userId.em(), chatCtl.group.groupId.em()).then((v) {
      if (v.isNotEmpty) {
        for (var item in v) {
          // loggerArray(["输出一下消息id",item.msgId]);
          var msg = SocketMsgContent.fromJson(item.getMsgContent());
          var socketMsg = SocketMessageEntity();
          socketMsg.msgContent = msg;
          socketMsg.msgId = item.msgId;
          if(item.refMsg != null){
            socketMsg.refMsg = SocketRefMsgContent.fromJson(item.getRefMsg());
          }
          insertMessageList(socketMsg, item.getFromInfo(), item.createTime.em(),replied: DataUtils.getRefMsg(socketMsg.refMsg));
        }
      }
    });
    ///消息标记已读
    DbHelper().setMessageRead(state.chatEvent.messageBox).then((v){
      loggerArray(["消息标记已读",v]);
      if(v){
        eventBus.fire(NewChatEvent()); //消息未读数变更，需要刷新列表
      }
    });
  }

  void insertMessageList(SocketMessageEntity socketMsg, Map<String, dynamic> fromInfo, String createTime,{types.Message? replied}) {
    switch (find(socketMsg.msgContent?.msgType)) {
      case MessageTypeEnum.TEXT:
        state.messages.insert(0, SocketUtils().buildUserText(
            socketMsg.msgContent!.content.em(), UserInfoEntity.fromJson(fromInfo),
            createdAt: DateUtil.getDateMsByTimeStr(createTime),msgId: socketMsg.msgId,replied: replied),);
        break;
      case MessageTypeEnum.IMAGE:
        state.messages.insert(0, SocketUtils().buildUserImageUrl(
            socketMsg.msgContent!.content.em(), UserInfoEntity.fromJson(fromInfo),
            createdAt: DateUtil.getDateMsByTimeStr(createTime),msgId: socketMsg.msgId,replied: replied));
        break;
      case MessageTypeEnum.FILE:
        state.messages.insert(0, SocketUtils().buildUserFileUrl(
            socketMsg.msgContent!.content.em(), UserInfoEntity.fromJson(fromInfo),
            createdAt: DateUtil.getDateMsByTimeStr(createTime),msgId: socketMsg.msgId,replied: replied));
        break;
      case MessageTypeEnum.ALERT:
        state.messages.insert(0, SocketUtils().buildSystemText(
            socketMsg.msgContent!.content.em(), UserInfoEntity.fromJson(fromInfo),
            createdAt: DateUtil.getDateMsByTimeStr(createTime),msgId: socketMsg.msgId,replied: replied),);
        break;
      default:
        break;
    }
  }


  void clickMessage(types.Message message,ItemModel item){
    state.popCtlList.forEach((v)=> v.hideMenu());
    switch(item.index){
      case 0:
        if(message is types.TextMessage){
          WidgetUtils.clickCopy(message.text);
        }else if(message is types.ImageMessage){
          WidgetUtils.clickCopy(message.uri);
        }else if(message is types.FileMessage){
          WidgetUtils.clickCopy(message.uri);
        }
        break;
      case 1:
        Get.toNamed(Routes.FORWARD_MESSAGE,arguments: message)?.then((v){
          if(v == true){ showToasty("转发成功"); }
        });
        break;
      case 2:
        chatCtl.replyMessage.value = message;
        break;
    }
  }

  SocketRefMsgContent buildRefMessage(String msgId,types.Message msg) {
    if (msg is types.TextMessage) {
      return SocketRefMsgContent(msgId: msgId,content: msg.text,msgType: MessageTypeEnum.TEXT.name,nickName: msg.author.firstName);
    } else if (msg is types.ImageMessage) {
      return SocketRefMsgContent(msgId: msgId,content: msg.uri,msgType: MessageTypeEnum.IMAGE.name,nickName: msg.author.firstName);
    } else if (msg is types.FileMessage) {
      return SocketRefMsgContent(msgId: msgId,content: msg.uri,msgType: MessageTypeEnum.FILE.name,nickName: msg.author.firstName);
    }else {
      return SocketRefMsgContent();
    }
  }


}
