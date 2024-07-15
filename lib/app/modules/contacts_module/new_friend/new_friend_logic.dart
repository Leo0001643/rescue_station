import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rescue_station/app/event/friend_delete_event.dart';
import 'package:rescue_station/app/modules/contacts_module/new_friend/friend_apply_entity.dart';
import 'package:rescue_station/app/routes/api_info.dart';
import 'package:rescue_station/app/routes/app_pages.dart';
import 'package:rescue_station/app/utils/dio_utils.dart';
import 'package:rescue_station/app/utils/widget_utils.dart';
import 'package:rescue_station/generated/json/base/json_convert_content.dart';

import 'new_friend_state.dart';

class NewFriendLogic extends GetxController {
  final NewFriendState state = NewFriendState();

  @override
  void onReady() {
    getApplyList();
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  void getApplyList() {
    DioUtil().get(Api.APPLY_LIST,).then((result){
      if(result.data["code"] == 200){
        if(ObjectUtil.isNotEmpty(result.data['rows'])){
          var data = JsonConvert.fromJsonAsT<List<FriendApplyEntity>>(result.data['rows']) ?? [];
          state.data.assignAll(data);
        }
      } else {
        Get.snackbar('提醒', result.data["msg"]);
      }
    }).onError((e,stack){
      Get.snackbar('联系人提醒', "系统异常！");
    });
  }

  void applyAgree(FriendApplyEntity entity){
    DioUtil().post(Api.APPLY_AGREE,data: {"applyId":entity.applyId.em()}).then((result){
      if(result.data["code"] == 200){
        eventBus.fire(FriendDeleteEvent(entity.userId.em()));
        Get.snackbar('提醒', "操作成功！");
        getApplyList();
      } else {
        Get.snackbar('提醒', result.data["msg"]);
      }
    }).onError((e,stack){
      Get.snackbar('联系人提醒', "系统异常！");
    });
  }

  void applyIgnore(FriendApplyEntity entity){
    DioUtil().post(Api.APPLY_IGNORE,data: {"applyId":entity.applyId.em()}).then((result){
      if(result.data["code"] == 200){
        Get.snackbar('提醒', "操作成功！");
        getApplyList();
      } else {
        Get.snackbar('提醒', result.data["msg"]);
      }
    }).onError((e,stack){
      Get.snackbar('联系人提醒', "系统异常！");
    });
  }

}
