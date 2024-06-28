import 'package:get/get.dart';
import 'package:rescue_station/app/domains/user_info_entity.dart';
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
  var finds = RxList<UserInfoEntity>.empty(growable: true);

  void onSearch(String text) {
    DioUtil().post(Api.FIND_FRIEND,data: {"param":text}).then((result){
      if(result.data["code"] == 200){
        var entity = UserInfoEntity.fromJson(result.data["data"]);
        finds.assign(entity);
      } else {
        finds.value = [];
        Get.snackbar('添加好友提醒', result.data["msg"]);
      }
    }).onError((e,stack){
      Get.snackbar('添加好友提醒', "系统异常！");
    });
  }











}
