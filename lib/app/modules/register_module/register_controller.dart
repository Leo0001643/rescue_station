import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rescue_station/app/domains/register_entity.dart';
import '../../routes/api_info.dart';
import '../../routes/app_pages.dart';
import '../../utils/dio_utils.dart';

class RegisterController extends GetxController {
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var nickNameController = TextEditingController();

  void register() async {
    try {
      final phone = phoneController.text;
      final password = passwordController.text;
      final confirmPassword = confirmPasswordController.text;
      final nickName = nickNameController.text;
      final email = emailController.text;

      if (password != confirmPassword) {
        Get.snackbar('Register', '两次输入密码不一致！');
      }
      var data = {"phone": phone, "password": password, "confirmPassword": confirmPassword, "email": email, "nickName": nickName};
      var response = await DioUtil().post(Api.MEMBER_REGISTER, data: data);
      RegisterEntity entity = RegisterEntity.fromRawJson(response.toString());
      if (ObjectUtil.isNotEmpty(entity) && entity.code == 200) {
        Get.snackbar('提交注册成功!', "请前往登录");
        Get.toNamed(Routes.LOGIN);
      } else {
        Get.snackbar('注册提醒', entity.msg.toString());
      }
    } catch (e) {
      Get.snackbar('注册提醒', "系统异常！");
    }
  }
}
