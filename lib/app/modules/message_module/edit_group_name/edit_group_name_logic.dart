import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:rescue_station/app/db/db_helper.dart';
import 'package:rescue_station/app/event/edit_group_name_event.dart';
import 'package:rescue_station/app/event/new_chat_event.dart';
import 'package:rescue_station/app/routes/api_info.dart';
import 'package:rescue_station/app/routes/app_pages.dart';
import 'package:rescue_station/app/utils/dio_utils.dart';
import 'package:rescue_station/app/utils/widget_utils.dart';

import 'edit_group_name_state.dart';

class EditGroupNameLogic extends GetxController {
  final EditGroupNameState state = EditGroupNameState();

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }


  void editGroupName(){
    if(state.textController.text.isEmpty){
      showToasty("请输入群聊名称");
      return;
    }
    if(state.textController.text == state.groupDetail.value.group?.name){
      return;
    }
    EasyLoading.show();
    DioUtil().post(Api.EDIT_GROUP_NAME, data: {
      "groupId": state.groupDetail.value.group?.groupId,
      "name": state.textController.text ,
    }).then((result) {
      EasyLoading.dismiss();
      if (result.data["code"] == 200) {
        var groupInfo = state.chatEvent.messageBox.getFromInfo();
        groupInfo["name"] == state.textController.text;
        state.chatEvent.messageBox.fromInfo = jsonEncode(groupInfo);
        showToasty("操作成功");
        DbHelper().updateMessageBox(state.chatEvent.messageBox).then((v){
          ///刷新标题栏
          eventBus.fire(EditGroupNameEvent(state.textController.text,state.chatEvent));
          Get.back();
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
