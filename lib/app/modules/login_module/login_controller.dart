import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rescue_station/app/routes/app_pages.dart';

class LoginController extends GetxController{
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneNumber = ''.obs;
  var password = ''.obs;

  void login() {
    final phone = phoneController.text;
    final password = passwordController.text;
    print('Phone: $phone, Password: $password');

    Get.snackbar('Login', 'Login successful for $phone');
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
