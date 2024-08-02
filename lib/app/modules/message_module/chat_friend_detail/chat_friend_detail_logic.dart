import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:rescue_station/app/db/db_helper.dart';
import 'package:rescue_station/app/event/chat_event.dart';
import 'package:rescue_station/app/routes/api_info.dart';
import 'package:rescue_station/app/routes/app_pages.dart';
import 'package:rescue_station/app/utils/app_data.dart';
import 'package:rescue_station/app/utils/dio_utils.dart';
import 'package:rescue_station/app/utils/widget_utils.dart';

import '../../../event/new_chat_event.dart';
import 'chat_friend_detail_state.dart';

class ChatFriendDetailLogic extends GetxController {
  final ChatFriendDetailState state = ChatFriendDetailState();

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  ///聊天置顶
  void chatSetTop(bool value) {
    EasyLoading.show();
    state.chatEvent.messageBox.isTop = value ? 1 : 0;
    var group = state.chatEvent.messageBox;
    DioUtil().post(Api.CHAT_FRIEND_TOP,
        data: {"userId": group.boxId, "top": value ? "Y" : "N"}).then((result) {
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
    DbHelper().updateMessageBox(state.chatEvent.messageBox).then((v) {
      state.isDisturb.value = value;
      EasyLoading.dismiss();
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
}
