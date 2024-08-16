
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:rescue_station/app/constant/api_code.dart';
import 'package:rescue_station/app/domains/api_response.dart';
import 'package:rescue_station/app/domains/user_info_entity.dart';
import 'package:rescue_station/app/event/logout_event.dart';
import 'package:rescue_station/app/routes/api_info.dart';
import 'package:rescue_station/app/routes/app_pages.dart';
import 'package:rescue_station/app/socket/socket_utils_bak.dart';
import 'package:rescue_station/app/utils/logger.dart';
import 'package:rescue_station/app/utils/widget_utils.dart';
import '../../utils/app_data.dart';
import '../../utils/dio_utils.dart';

class LoginController extends GetxController{
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  void onReady() {
    if(WidgetUtils.checkRefresh()){
      Get.toNamed(Routes.TABS);
      return;
    }
    super.onReady();
  }

  @override
  void onClose() {
    phoneController.dispose();
    passwordController.dispose();
    super.onClose();
  }


  ///会员登录
  void login() async{
    try {
      final phone = phoneController.text;
      final password = passwordController.text;
      await EasyLoading.show(status: '登录中...',maskType: EasyLoadingMaskType.black,);
      await AppData.clearUser();///登陆前先清除用户信息
      var response = await DioUtil().post(Api.MEMBER_LOGIN, data: {"phone":phone, "password": password});
      var entity = ApiResponse.fromJson(response.data);
      if(isNotEmpty(response) && entity.code == ApiCode.SUCCESS.code) {
        await AppData.setUser(UserInfoEntity.fromJson(entity.data!));
        SocketUtils().connect(callback: (result) async {
          if(result){
            eventBus.fire(LoginEvent());///发出登录成功通知
            await Future.delayed(const Duration(seconds: 2));
            await EasyLoading.dismiss();
            EasyLoading.showSuccess('登录成功!');
            Get.offNamedUntil(Routes.TABS, (route)=> route.name != Routes.TABS);
          } else {
            await EasyLoading.dismiss();
            EasyLoading.showError('登录失败!');
          }
        });
      } else {
        EasyLoading.showError(entity.msg.toString());
      }
    } catch (e) {
      logger(e);
      EasyLoading.showError("登录异常！");
    }
  }

  void forgotPassword() {
    Get.snackbar('Forgot Password', 'Password recovery process started.');
  }

  void register() {
    Get.toNamed(Routes.REGISTER);
  }
}
