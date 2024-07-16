import 'package:common_utils/common_utils.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:rescue_station/app/db/db_helper.dart';
import 'package:rescue_station/app/domains/user_info_entity.dart';
import 'package:rescue_station/app/routes/api_info.dart';
import 'package:rescue_station/app/routes/app_pages.dart';
import 'package:rescue_station/app/utils/app_data.dart';
import 'package:rescue_station/app/utils/dio_utils.dart';
import 'package:rescue_station/generated/json/base/json_convert_content.dart';

class CreateGroupController extends GetxController{

  var contacts = RxList<UserInfoEntity>.empty(growable: true);

  var selectList = RxList<UserInfoEntity>.empty(growable: true);

  @override
  void onReady() {
    ///如果已经登录了，有token
    var user = AppData.getUser();
    if(isNotEmpty(user)){
      getContactsAll(user!);
    }
    super.onReady();
  }


  void getContactsAll(UserInfoEntity user){
    DioUtil().post(Api.FRIEND_LIST,data: {"params":""}).then((result){
      if(result.data["code"] == 200){
        var data = JsonConvert.fromJsonAsT<List<UserInfoEntity>>(result.data["data"]) ?? [];
        contacts.value = data.where((v)=> v.userId != user.userId).toList(growable: true);
      } else {
        Get.snackbar('提醒', "系统异常！");
      }
    }).onError((e,stack){
      Get.snackbar('提醒', "系统异常！");
    });
  }

  void createGroup(){
    if(selectList.isEmpty){
      Get.snackbar('提醒', "请选择联系人！");
      return;
    }
    var params = selectList.map((v)=> v.userId).toList(growable: true);
    DioUtil().postAny(Api.CREATE_GROUP,data: params).then((result){
      ///[log] [返回响应, /group/createGroup, 200, ["10003","1800813200611135490"]
      if(result.data["code"] == 200){
        Get.back();
      } else {
        Get.snackbar('提醒', "系统异常！");
      }
    }).onError((e,stack){
      Get.snackbar('提醒', "系统异常！");
    });
  }





}
