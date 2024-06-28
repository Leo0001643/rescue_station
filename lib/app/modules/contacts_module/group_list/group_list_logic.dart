import 'package:get/get.dart';
import 'package:rescue_station/app/domains/user_info_entity.dart';
import 'package:rescue_station/app/routes/api_info.dart';
import 'package:rescue_station/app/utils/dio_utils.dart';
import 'package:rescue_station/generated/json/base/json_convert_content.dart';

import '../../../domains/group_info_entity.dart';
import 'group_list_state.dart';

class GroupListLogic extends GetxController {
  final GroupListState state = GroupListState();

  @override
  void onReady() {
    getGroupAll();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getGroupAll(){
    DioUtil().get(Api.GROUP_LIST).then((result){
      if(result.data["code"] == 200){
        var list = JsonConvert.fromJsonAsT<List<GroupInfoEntity>>(result.data["data"]) ?? [];
        state.data.assignAll(list);
      } else {
        Get.snackbar('提醒', "系统异常！");
      }
    }).onError((e,stack){
      Get.snackbar('提醒', "系统异常！");
    });
  }







}
