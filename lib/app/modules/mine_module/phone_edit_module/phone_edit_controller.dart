import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../constant/api_code.dart';
import '../../../domains/api_response.dart';
import '../../../domains/user_info_entity.dart';
import '../../../routes/api_info.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/app_data.dart';
import '../../../utils/dio_utils.dart';

class PhoneEditController extends GetxController{
  var phone = ''.obs;
  var phoneError = ''.obs;

  void editPhone() async{
    try {
      await EasyLoading.show(status: '提交中...',maskType: EasyLoadingMaskType.black);
      var response = await DioUtil().post(Api.EDIT_PHONE, data: {"phone": phone.value});
      var entity = ApiResponse.fromJson(response.data);
      if(isNotEmpty(response) && entity.code == ApiCode.SUCCESS.code) {
        UserInfoEntity? userInfoCache =  AppData.getUser();
        userInfoCache?.phone = maskPhoneNumber(phone.value);
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

  void validatePhone(String value) {
    final nickNameRegex = RegExp(r'^[0-9]{11}$');
    if (!nickNameRegex.hasMatch(value)) {
      phoneError.value = '请输入正确的手机号！';
    } else {
      phoneError.value = '';  // 清除错误提示
    }
  }

  String maskPhoneNumber(String number) {
    final RegExp regExp = RegExp(r'^(\d{3})\d{6}(\d{2})$');
    return number.replaceAllMapped(regExp, (match) {
      return '${match.group(1)}****${match.group(2)}';
    });
  }

}
