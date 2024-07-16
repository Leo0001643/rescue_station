import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rescue_station/app/db/db_helper.dart';
import 'package:rescue_station/app/domains/user_info_entity.dart';
import 'package:rescue_station/app/routes/api_info.dart';
import 'package:rescue_station/app/routes/app_pages.dart';
import 'package:rescue_station/app/utils/app_data.dart';
import 'package:rescue_station/app/utils/dio_utils.dart';
import 'package:rescue_station/app/utils/widget_utils.dart';

import 'apply_friend_state.dart';

class ApplyFriendLogic extends GetxController {
  final ApplyFriendState state = ApplyFriendState();

  @override
  void onReady() {
    var user = AppData.getUser();
    if(isNotEmpty(user)){
      state.user = Get.arguments;
      state.reasonCtl.text = "我是${user?.nickName}";
      state.remarkCtl.text = state.user?.nickName ?? "";
    }
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  void applyAdd(){
    if(isEmpty(state.user)) return;
    if(isEmpty(state.reasonCtl.text)) {
      Get.snackbar("添加好友提醒", "请输入申请原因！");
      return;
    }
    if(isEmpty(state.remarkCtl.text)) {
      Get.snackbar("添加好友提醒", "请输入好友昵称！");
      return;
    }

    var params = {"userId":state.user!.userId.em(),"reason": state.reasonCtl.text,"source":state.user!.source.em()};
    DioUtil().post(Api.APPLY_ADD,data: params).then((result){
      if(result.data["code"] == 200){
        Get.snackbar('添加好友提醒', "申请已发送！");
        Get.until((ModalRoute.withName(Routes.TABS)));
      } else {
        Get.snackbar('添加好友提醒', result.data["msg"]);
      }
    }).onError((e,stack){
      Get.snackbar('添加好友提醒', "系统异常！");
    });
  }









}
