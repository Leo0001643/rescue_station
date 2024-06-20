import 'package:get/get.dart';
import 'package:rescue_station/app/db/user_info_table.dart';
import 'package:rescue_station/app/routes/api_info.dart';
import 'package:rescue_station/app/utils/dio_utils.dart';
import 'package:rescue_station/app/utils/widget_utils.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class AddFriendController extends GetxController{

  // var _obj = ''.obs;
  // set obj(value) => _obj.value = value;
  // get obj => _obj.value;
  var finds = RxList<UserInfoTable>.empty(growable: true);

  void onSearch(String text) {
    DioUtil().post(Api.FIND_FRIEND,data: {"param":text}).then((result){
      if(result.data["code"] == 200){
        var entity = UserInfoTable.fromJson(result.data["data"]);
        finds.assign(entity);
      } else {
        finds.value = [];
        Get.snackbar('添加好友提醒', result.data["msg"]);
      }
    }).onError((e,stack){
      Get.snackbar('添加好友提醒', "系统异常！");
    });
  }

  void applyAdd(UserInfoTable user){
    var params = {"userId":user.userId.em(),"reason":"想加你好友通过一下谢谢！","source":user.source.em()};
    DioUtil().post(Api.APPLY_ADD,data: params).then((result){
      if(result.data["code"] == 200){
        Get.snackbar('添加好友提醒', "申请已发送！");
      } else {
        Get.snackbar('添加好友提醒', result.data["msg"]);
      }
    }).onError((e,stack){
      Get.snackbar('添加好友提醒', "系统异常！");
    });
  }










}
