import 'package:common_utils/common_utils.dart';
import 'package:get/get.dart';
import 'package:rescue_station/app/db/db_helper.dart';
import 'package:rescue_station/app/db/user_info_table.dart';
import 'package:rescue_station/app/routes/api_info.dart';
import 'package:rescue_station/app/utils/dio_utils.dart';
import 'package:rescue_station/generated/json/base/json_convert_content.dart';

class CreateGroupController extends GetxController{

  var contacts = RxList<UserInfoTable>.empty(growable: true);

  @override
  void onReady() {
    ///如果已经登录了，有token
    DbHelper().getUser().then((user){
      if(ObjectUtil.isNotEmpty(user)){
        getContactsAll(user!);
      }
    });
    super.onReady();
  }


  void getContactsAll(UserInfoTable user){
    DioUtil().post(Api.FRIEND_LIST,data: {"params":""}).then((result){
      if(result.data["code"] == 200){
        var data = JsonConvert.fromJsonAsT<List<UserInfoTable>>(result.data["data"]) ?? [];
        contacts.value = data.where((v)=> v.userId != user.userId).toList(growable: true);
      } else {
        Get.snackbar('联系人提醒', "系统异常！");
      }
    }).onError((e,stack){
      Get.snackbar('联系人提醒', "系统异常！");
    });
  }

  void createGroup(){

  }





}
