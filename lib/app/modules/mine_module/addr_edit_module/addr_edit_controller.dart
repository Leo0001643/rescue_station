import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../../constant/api_code.dart';
import '../../../domains/api_response.dart';
import '../../../domains/user_info_entity.dart';
import '../../../routes/api_info.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/app_data.dart';
import '../../../utils/dio_utils.dart';

class AddrEditController extends GetxController{
  var address = ''.obs;
  var addressError = ''.obs;

  void editAddress() async{
    try {
      await EasyLoading.show(status: '提交中...',maskType: EasyLoadingMaskType.black);
      var response = await DioUtil().post(Api.EDIT_CITY, data: {"city": address.value});
      var entity = ApiResponse.fromJson(response.data);
      if(isNotEmpty(response) && entity.code == ApiCode.SUCCESS.code) {
        UserInfoEntity? userInfoCache =  AppData.getUser();
        userInfoCache?.city = address.value;
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

  void validateAddress(String value) {
    final nickNameRegex = RegExp(r'^[0-9A-Za-z\u4E00-\u9FFF]{2,60}$');
    if (!nickNameRegex.hasMatch(value)) {
      addressError.value = '请输入正确的地址信息！';
    } else {
      addressError.value = '';  // 清除错误提示
    }
  }

}
