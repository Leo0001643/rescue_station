import 'dart:convert';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:rescue_station/app/db/db_helper.dart';
import 'package:rescue_station/app/constant/api_code.dart';
import 'package:rescue_station/app/domains/login_entity.dart';
import 'package:rescue_station/app/routes/api_info.dart';
import 'package:rescue_station/app/routes/app_pages.dart';
import 'package:rescue_station/app/utils/logger.dart';
import '../../utils/dio_utils.dart';
import '../../utils/shared_preferences_util.dart';
import '../tabs_module/tabs_controller.dart';
import '../tabs_module/tabs_pages.dart';

class LoginController extends GetxController{
  var phoneController = TextEditingController(text: "13125554441");
  var passwordController = TextEditingController(text: "123456");

  ///会员登录
  void login() async{
    try {
      final phone = phoneController.text;
      final password = passwordController.text;
      await EasyLoading.show(status: '登录中...',maskType: EasyLoadingMaskType.black,);
      var response = await DioUtil().post(Api.MEMBER_LOGIN, data: {"phone":phone, "password": password});
      LoginEntity entity = LoginEntity.fromRawJson(response.toString());
      if(ObjectUtil.isNotEmpty(response) && entity.code == ApiCode.SUCCESS.code) {
        if(ObjectUtil.isNotEmpty(entity.data)){
          (await DbHelper().getUserBox()).add(entity.data);
          await SharedPreferencesUtil.setString('userInfo', jsonEncode(entity.data!.toJson()));
        }
        await Future.delayed(const Duration(seconds: 2));
        await EasyLoading.dismiss();
        EasyLoading.showSuccess('登录成功!');
        Get.find<TabsController>().setCurrentIndex(0);
        Get.off(() => const TabsPage());
      } else {
        EasyLoading.showError(entity.msg.toString());
      }
    } catch (e) {
      // Get.snackbar('登录提醒', "系统异常！");
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
