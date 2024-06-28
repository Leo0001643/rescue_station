import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:rescue_station/app/domains/api_response.dart';
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
      if (password != confirmPassword) {Get.snackbar('Register', '两次输入密码不一致！');}
      var data = {"phone": phone, "password": password, "confirmPassword": confirmPassword, "email": email, "nickName": nickName};
      await EasyLoading.show(status: '提交注册中...',maskType: EasyLoadingMaskType.black,);
      var response = await DioUtil().post(Api.MEMBER_REGISTER, data: data);
      await Future.delayed(const Duration(seconds: 2));
      await EasyLoading.dismiss();
      var entity = ApiResponse.fromJson(response.data);
      if (ObjectUtil.isNotEmpty(entity) && entity.code == 200) {
        EasyLoading.showSuccess('请前往登录...');
        Get.toNamed(Routes.LOGIN);
      } else {
        EasyLoading.showError(entity.msg.toString());
      }
    } catch (e) {
      EasyLoading.showError("提交注册异常！");
    }
  }
}
