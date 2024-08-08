import 'package:get/get.dart';
import 'package:rescue_station/app/event/add_group_event.dart';
import 'package:rescue_station/app/routes/api_info.dart';
import 'package:rescue_station/app/routes/app_pages.dart';
import 'package:rescue_station/app/utils/dio_utils.dart';
import 'package:rescue_station/app/utils/widget_utils.dart';

import 'group_reduce_state.dart';

class GroupReduceLogic extends GetxController {
  final GroupReduceState state = GroupReduceState();

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }


  void reduceGroup(){
    if(state.selectList.isEmpty){
      Get.snackbar('提醒', "请选择移出成员！");
      return;
    }
    var list = state.selectList.map((v)=> v.userId).toList(growable: true);
    var params = {"groupId": state.groupDetail.group?.groupId,"list":list};
    DioUtil().postAny(Api.KICKED_GROUP,data: params).then((result){
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
