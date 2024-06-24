import 'package:common_utils/common_utils.dart';
import 'package:get/get.dart';
import 'package:rescue_station/app/db/db_helper.dart';
import 'package:rescue_station/app/event/friend_delete_event.dart';
import 'package:rescue_station/app/db/user_info_table.dart';
import 'package:rescue_station/app/routes/api_info.dart';
import 'package:rescue_station/app/routes/app_pages.dart';
import 'package:rescue_station/app/utils/dio_utils.dart';
import 'package:rescue_station/app/utils/logger.dart';
import 'package:rescue_station/app/utils/widget_utils.dart';

import 'friend_detail_state.dart';

class FriendDetailLogic extends GetxController {
  final FriendDetailState state = FriendDetailState();

  @override
  void onReady() {
    getFriendDetail(Get.arguments);
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getFriendDetail(UserInfoTable user) {

    DioUtil().get("${Api.FRIEND_INFO}${user.userId.em()}").then((result){
      if(result.data["code"] == 200){
        state.userInfo.value = UserInfoTable.fromJson(result.data["data"]);
      } else {
        Get.snackbar('联系人提醒', result.data["msg"]);
      }
    }).onError((e,stack){
      Get.snackbar('联系人提醒', "系统异常！");
    });
  }

  void delFriend(){
    if(ObjectUtil.isEmpty(state.userInfo.value.userId)) return;
    var params = {"userId":state.userInfo.value.userId.em()};
    DioUtil().post(Api.DEL_FRIEND,data: params).then((result){
      if(result.data["code"] == 200){
        eventBus.fire(FriendDeleteEvent(state.userInfo.value.userId.em()));
        Get.back();
        Get.snackbar('联系人提醒', "删除成功！");
      } else {
        Get.snackbar('联系人提醒', result.data["msg"]);
      }
    }).onError((e,stack){
      Get.snackbar('联系人提醒', "系统异常！");
    });
  }


}
