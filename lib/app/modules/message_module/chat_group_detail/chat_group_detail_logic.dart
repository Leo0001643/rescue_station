import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:rescue_station/app/db/db_helper.dart';
import 'package:rescue_station/app/domains/group_detail_entity.dart';
import 'package:rescue_station/app/event/add_group_event.dart';
import 'package:rescue_station/app/event/chat_event.dart';
import 'package:rescue_station/app/event/edit_group_event.dart';
import 'package:rescue_station/app/event/edit_group_name_event.dart';
import 'package:rescue_station/app/event/new_chat_event.dart';
import 'package:rescue_station/app/routes/api_info.dart';
import 'package:rescue_station/app/routes/app_pages.dart';
import 'package:rescue_station/app/utils/app_data.dart';
import 'package:rescue_station/app/utils/dio_utils.dart';
import 'package:rescue_station/app/utils/logger.dart';
import 'package:rescue_station/app/utils/widget_utils.dart';

import 'chat_group_detail_state.dart';

class ChatGroupDetailLogic extends GetxController {
  final ChatGroupDetailState state = ChatGroupDetailState();

  StreamSubscription? editNameSub;
  StreamSubscription? addGroupSub;


  @override
  void onReady() {
    if(isNotEmpty(Get.arguments)){
      EditGroupEvent event = Get.arguments;
      state.groupDetail.value = event.group;
      state.chatEvent = event.event;
      state.isTop.value = state.chatEvent.messageBox.getIsTop();
      state.isDisturb.value = state.chatEvent.messageBox.getIsDisturb();
      // getGroupDetail();
    }
    editNameSub = eventBus.on<EditGroupNameEvent>().listen((event){
      state.groupDetail.value.group?.name = event.name;
      state.groupDetail.refresh();
    });
    addGroupSub = eventBus.on<AddGroupEvent>().listen((event){
      getGroupDetail();
    });
    super.onReady();
  }

  @override
  void onClose() {
    addGroupSub?.cancel();
    editNameSub?.cancel();
    super.onClose();
  }

  void getGroupDetail() {
    EasyLoading.show();
    loggerArray(["群详情", state.chatEvent.messageBox.toJson()]);
    DioUtil().get(Api.GET_GROUP_INFO + state.chatEvent.messageBox.boxId.em(),).then((result) {
      EasyLoading.dismiss();
      if (result.data["code"] == 200) {
        state.groupDetail.value = GroupDetailEntity.fromJson(result.data['data']);
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

  ///聊天置顶
  void chatSetTop(bool value) {
    EasyLoading.show();
    state.chatEvent.messageBox.isTop = value ? 1 : 0;
    var group = state.chatEvent.messageBox;
    DioUtil().post(Api.EDIT_TOP, data: {
      "groupId": group.boxId,
      "top": value ? "Y" : "N"
    }).then((result) {
      if (result.data["code"] == 200) {
        DbHelper().updateMessageBox(state.chatEvent.messageBox).then((v) {
          state.isTop.value = value;
          //聊天列表信息变更，需要刷新列表
          eventBus.fire(NewChatEvent());
          EasyLoading.dismiss();
        });
      } else if(result.data["code"] == 401){
        WidgetUtils.logSqueezeOut();
      } else {
        EasyLoading.dismiss();
        Get.snackbar('提醒', result.data["msg"]);
      }
    }).onError((e, stack) {
      EasyLoading.dismiss();
      Get.snackbar('提醒', "系统异常！");
    });
  }

  ///免打扰
  void chatSetDisturb(bool value) {
    EasyLoading.show();
    state.chatEvent.messageBox.isDisturb = value ? 1 : 0;
    var group = state.chatEvent.messageBox;
    DioUtil().post(Api.EDIT_DISTURB, data: {
      "groupId": group.boxId,
      "disturb": value ? "Y" : "N"
    }).then((result) {
      if (result.data["code"] == 200) {
        DbHelper().updateMessageBox(state.chatEvent.messageBox).then((v) {
          state.isDisturb.value = value;
          EasyLoading.dismiss();
        });
      } else if(result.data["code"] == 401){
        WidgetUtils.logSqueezeOut();
      } else {
        EasyLoading.dismiss();
        Get.snackbar('提醒', result.data["msg"]);
      }
    }).onError((e, stack) {
      EasyLoading.dismiss();
      Get.snackbar('提醒', "系统异常！");
    });
  }

  ///清空消息
  void messageClear() {
    EasyLoading.show();
    DbHelper()
        .deleteHistoryMessage(AppData.getUser()!.userId.em(),
            state.chatEvent.messageBox.boxId.em())
        .then((v) {
      eventBus.fire(ChartHistoryClearEvent());
      //聊天列表信息变更，需要刷新列表
      eventBus.fire(NewChatEvent());
      EasyLoading.dismiss();
      showToasty("已清空");
    });
  }

  ///退出群聊
  void leaveGroup() {
    EasyLoading.show();
    var group = state.chatEvent.messageBox;
    DioUtil().get(Api.LOGOUT_GROUP + group.boxId.em(),).then((result) {
      if (result.data["code"] == 200) {
        DbHelper()
            .deleteMessageBox(AppData.getUser()!.userId.em(), group.boxId.em())
            .then((v) {
          //聊天列表信息变更，需要刷新列表
          eventBus.fire(NewChatEvent());
          EasyLoading.dismiss();
          Get.offNamedUntil(Routes.TABS, (route)=> route.name != Routes.TABS);
        });
      } else if(result.data["code"] == 401){
        WidgetUtils.logSqueezeOut();
      } else {
        EasyLoading.dismiss();
        Get.snackbar('提醒', result.data["msg"]);
      }
    }).onError((e, stack) {
      EasyLoading.dismiss();
      Get.snackbar('提醒', "系统异常！");
    });
  }
}
