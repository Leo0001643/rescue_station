import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rescue_station/app/routes/app_pages.dart';

class LoginController extends GetxController{
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var isPasswordLogin = true.obs;


  void toggleLoginMethod() {
    isPasswordLogin.value = !isPasswordLogin.value;
  }

  void login() {
    final phone = phoneController.text;
    final password = passwordController.text;
    print('Phone: $phone, Password: $password');

    Get.snackbar('Login', 'Login successful for $phone');
  }

  void forgotPassword() {
    Get.snackbar('Forgot Password', 'Password recovery process started.');
  }

  void register() {
    Get.toNamed(Routes.REGISTER);
  }
}
