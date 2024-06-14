import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rescue_station/app/constant/constant.dart';
import 'package:rescue_station/app/domains/login_entity.dart';
import 'package:rescue_station/app/routes/api_info.dart';
import 'package:rescue_station/app/routes/app_pages.dart';
import '../../utils/dialog_utils.dart';
import '../../utils/dio_utils.dart';
import '../../utils/network/request_client.dart';
import '../../utils/shared_preferences_util.dart';
import '../tabs_module/tabs_controller.dart';
import '../tabs_module/tabs_pages.dart';

class LoginController extends GetxController{
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();

  ///会员登录
  void login() async{
    try {
      final phone = phoneController.text;
      final password = passwordController.text;
      var response = await DioUtil().post(Api.MEMBER_LOGIN, data: {"phone":phone, "password": password});
      LoginEntity entity = LoginEntity.fromRawJson(response.toString());
      if(ObjectUtil.isNotEmpty(response)) {
        await SharedPreferencesUtil.setString('token', entity.data!.token!);
        Get.snackbar('登录提醒', '登录成功！');
        Get.find<TabsController>().setCurrentIndex(0);
        Get.off(() => const TabsPage());
      }else{
        Get.snackbar('登录提醒', entity.msg.toString());
      }
    } catch (e) {
      Get.snackbar('登录提醒', "系统异常！");
    }
  }

/*  void login() {
    print('登录手机号: $phoneNumber, 密码: $password');
    Get.toNamed('/home');
  }*/

  void forgotPassword() {
    Get.snackbar('Forgot Password', 'Password recovery process started.');
  }

  void register() {
    Get.toNamed(Routes.REGISTER);
  }
}
