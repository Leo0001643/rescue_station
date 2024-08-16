import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../../constant/api_code.dart';
import '../../../domains/api_response.dart';
import '../../../event/logout_event.dart';
import '../../../routes/api_info.dart';
import '../../../routes/app_pages.dart';
import '../../../socket/socket_utils_bak.dart';
import '../../../utils/app_data.dart';
import '../../../utils/dio_utils.dart';

class PwdEditController extends GetxController{
  var oldPwd = ''.obs;
  var oldPwdError = ''.obs;
  var isOldPasswordVisible = false.obs;

  var password = ''.obs;
  var passwordError = ''.obs;
  var isPasswordVisible = false.obs;


  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleOldPasswordVisibility() {
    isOldPasswordVisible.value = !isOldPasswordVisible.value;
  }

  void validatePassword(String value) {
    // 正则表达式：6-12位，包含数字、字母或特殊字符
    final passwordRegex = RegExp(r'^[a-zA-Z\d]{6,12}$');
    if (!passwordRegex.hasMatch(value)) {
      passwordError.value = '请输入6~12位数字或字母';
    } else {
      passwordError.value = '';  // 清除错误提示
    }
  }

  void validateOldPwd(String value) {
    final passwordRegex = RegExp(r'^[a-zA-Z\d]{6,12}$');
    if (!passwordRegex.hasMatch(value)) {
      oldPwdError.value = '请输入6~12位数字或字母';
    } else {
      oldPwdError.value = '';  // 清除错误提示
    }
  }

  void editPwd() async{
    try {
      await EasyLoading.show(status: '提交中...',maskType: EasyLoadingMaskType.black);
      var response = await DioUtil().post(Api.EDIT_PASS, data: {"password": oldPwd.value, "pwd": password.value});
      var entity = ApiResponse.fromJson(response.data);
      if(isNotEmpty(response) && entity.code == ApiCode.SUCCESS.code) {
        ///登出操作
        await DioUtil().get(Api.LOGOUT);
        await AppData.clearUser();
        await SocketUtils().destroy();
        eventBus.fire(LogoutEvent());
        await EasyLoading.dismiss();
        EasyLoading.showSuccess('修改成功!');
        Get.offAllNamed(Routes.LOGIN);
      } else {
        EasyLoading.showError(entity.msg.toString());
      }
    } catch (e) {
      EasyLoading.showError("服务异常,请稍后再试！");
    }
    // DialogUtils.showCustomDialog(
    //     title: "修改成功",
    //     message: "前往登陆...",
    //     backgroundColor: Colors.green,
    //     icon: Icons.check_circle
    // );
    // Future.delayed(const Duration(milliseconds: 200), () {
    //   Get.toNamed('/login');  // 跳转到登录页面
    // });
  }
}
