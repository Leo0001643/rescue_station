import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../routes/app_pages.dart';

class RegisterController extends GetxController{
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var phoneController = TextEditingController();

  void register() {
    final username = usernameController.text;
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;
    final phone = phoneController.text;

    if (password == confirmPassword) {
      print('Username: $username, Password: $password, Phone: $phone');
      Get.snackbar('Register', 'Registration successful for $username');
      Get.toNamed(Routes.TABS);
    } else {
      Get.snackbar('Error', 'Passwords do not match');
    }
  }
}
