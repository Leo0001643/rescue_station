import 'package:common_utils/common_utils.dart';
import 'package:get/get.dart';
import 'package:rescue_station/app/db/db_helper.dart';
import 'package:rescue_station/app/domains/user_info_entity.dart';
import 'package:rescue_station/app/event/chat_event.dart';
import 'package:rescue_station/app/event/friend_delete_event.dart';
import 'package:rescue_station/app/event/new_chat_event.dart';
import 'package:rescue_station/app/routes/api_info.dart';
import 'package:rescue_station/app/routes/app_pages.dart';
import 'package:rescue_station/app/socket/socket_message_entity.dart';
import 'package:rescue_station/app/utils/app_data.dart';
import 'package:rescue_station/app/utils/dio_utils.dart';
import 'package:rescue_station/app/utils/widget_utils.dart';

import 'friend_detail_state.dart';

class FriendDetailLogic extends GetxController {
  final FriendDetailState state = FriendDetailState();

  @override
  void onReady() {
    // DbHelper().queryChatMessageAll().then((v){
    //   loggerArray(['来听课',v]);
    // });
    // DbHelper().queryMessageAll().then((v){
    //   loggerArray(['信息列表',v]);
    // });
    if(isNotEmpty(Get.arguments)){
      getFriendDetail(Get.arguments);
    }
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getFriendDetail(UserInfoEntity user) {
    DioUtil().get("${Api.FRIEND_INFO}${user.userId.em()}").then((result){
      if(result.data["code"] == 200){
        state.userInfo.value = UserInfoEntity.fromJson(result.data["data"]);
      } else if(result.data["code"] == 401){
        WidgetUtils.logSqueezeOut();
      } else {
        Get.snackbar('联系人提醒', result.data["msg"]);
      }
    }).onError((e,stack){
      Get.snackbar('联系人提醒', "系统异常！");
    });
  }

  void delFriend(){
    if(isEmpty(state.userInfo.value.userId)) return;
    var params = {"userId":state.userInfo.value.userId.em()};
    DioUtil().post(Api.DEL_FRIEND,data: params).then((result){
      if(result.data["code"] == 200){
        DbHelper().deleteMessageBox(AppData.getUser()!.userId.em(),state.userInfo.value.userId!).then((v){
          eventBus.fire(FriendDeleteEvent(state.userInfo.value.userId.em()));
          Get.back();
          Get.snackbar('联系人提醒', "删除成功！");
        });
      } else if(result.data["code"] == 401){
        WidgetUtils.logSqueezeOut();
      } else {
        Get.snackbar('联系人提醒', result.data["msg"]);
      }
    }).onError((e,stack){
      Get.snackbar('联系人提醒', "系统异常！");
    });
  }

  void openChatBox() async {
    var my = AppData.getUser();
    if(isNotEmpty(my)){
      var box = await DbHelper().findMessageBox(my!.userId.em(), state.userInfo.value.userId.em());
      if(box!=null){
        Get.toNamed(Routes.CHAT_BY_FRIEND,arguments: ChatEvent(my, state.userInfo.value,box));
      } else {
        var socketMsg = SocketMessageEntity();
        socketMsg.fromInfo = state.userInfo.value;
        socketMsg.pushType = "MSG";
        socketMsg.boxId = state.userInfo.value.userId.em();
        socketMsg.createTime = DateUtil.getNowDateStr();
        await DbHelper().messageInsertOrUpdate(true, socketMsg);
        ///先存储再发消息通知
        box = await DbHelper().findMessageBox(my.userId.em(), state.userInfo.value.userId.em());
        eventBus.fire(NewChatEvent());//有新消息，需要刷新列表
        Get.toNamed(Routes.CHAT_BY_FRIEND,arguments: ChatEvent(my, state.userInfo.value,box!));
      }
    }
  }



}
