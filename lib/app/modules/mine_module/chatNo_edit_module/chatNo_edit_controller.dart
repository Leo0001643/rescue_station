import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../constant/api_code.dart';
import '../../../domains/api_response.dart';
import '../../../domains/user_info_entity.dart';
import '../../../routes/api_info.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/app_data.dart';
import '../../../utils/dio_utils.dart';

class ChatNoEditController extends GetxController{
  var chatNo = ''.obs;
  var chatNoError = ''.obs;

  void editChatNo() async{
    try {
      await EasyLoading.show(status: '提交中...',maskType: EasyLoadingMaskType.black);
      var response = await DioUtil().post(Api.EDIT_CHATNO, data: {"chatNo": chatNo.value});
      var entity = ApiResponse.fromJson(response.data);
      if(isNotEmpty(response) && entity.code == ApiCode.SUCCESS.code) {
        UserInfoEntity? userInfoCache =  AppData.getUser();
        userInfoCache?.chatNo = chatNo.value;
        await AppData.setUser(userInfoCache!);
        await EasyLoading.dismiss();
        EasyLoading.showSuccess('修改成功!');
        Get.back();
      } else {
        EasyLoading.showError(entity.msg.toString());
      }
    } catch (e) {
      EasyLoading.showError("服务异常,请稍后再试！");
    }
  }

  void validateChatNo(String value) {
    // 正则表达式：6-12位，包含数字、字母或中文汉字
    final nickNameRegex = RegExp(r'^[a-zA-Z\d]{6,20}$');
    if (!nickNameRegex.hasMatch(value)) {
      chatNoError.value = '请输入6~20位的数字或字母';
    } else {
      chatNoError.value = '';  // 清除错误提示
    }
  }
}
