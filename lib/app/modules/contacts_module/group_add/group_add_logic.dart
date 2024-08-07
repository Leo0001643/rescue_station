import 'package:get/get.dart';
import 'package:rescue_station/app/domains/group_detail_entity.dart';
import 'package:rescue_station/app/domains/user_info_entity.dart';
import 'package:rescue_station/app/event/add_group_event.dart';
import 'package:rescue_station/app/routes/api_info.dart';
import 'package:rescue_station/app/routes/app_pages.dart';
import 'package:rescue_station/app/utils/app_data.dart';
import 'package:rescue_station/app/utils/dio_utils.dart';
import 'package:rescue_station/app/utils/widget_utils.dart';
import 'package:rescue_station/generated/json/base/json_convert_content.dart';

import 'group_add_state.dart';

class GroupAddLogic extends GetxController {
  final GroupAddState state = GroupAddState();

  @override
  void onReady() {
    ///如果已经登录了，有token
    var user = AppData.getUser();
    if(isNotEmpty(user)){
      getContactsAll(user!);
    }
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }


  void getContactsAll(UserInfoEntity user){
    DioUtil().post(Api.FRIEND_LIST,data: {"params":""}).then((result){
      if(result.data["code"] == 200){
        var data = JsonConvert.fromJsonAsT<List<UserInfoEntity>>(result.data["data"]) ?? [];
        state.contacts.value = data.where((v)=> state.groupDetail.user?.where((u)=> v.userId == u.userId).isEmpty ==  true).toList(growable: true);
      } else {
        Get.snackbar('提醒', "系统异常！");
      }
    }).onError((e,stack){
      Get.snackbar('提醒', "系统异常！");
    });
  }

  void addGroup(){
    if(state.selectList.isEmpty){
      Get.snackbar('提醒', "请选择联系人！");
      return;
    }
    var list = state.selectList.map((v)=> v.userId).toList(growable: true);
    var params = {"groupId": state.groupDetail.group?.groupId,"list":list};
    DioUtil().postAny(Api.INVITATION_GROUP,data: params).then((result){
      ///[log] [返回响应, /group/createGroup, 200, ["10003","1800813200611135490"]
      if(result.data["code"] == 200){
        showToasty("操作成功");
        eventBus.fire(AddGroupEvent());
        Get.back();
      } else if(result.data["code"] == 401){
        WidgetUtils.logSqueezeOut();
      } else {
        Get.snackbar('提醒', "系统异常！");
      }
    }).onError((e,stack){
      Get.snackbar('提醒', "系统异常！");
    });
  }


}
