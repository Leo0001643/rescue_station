import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PwdEditController extends GetxController{
  var password = ''.obs;
  var oldpwd = ''.obs;
  var isPasswordVisible = false.obs;
  var isOldPasswordVisible = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleOldPasswordVisibility() {
    isOldPasswordVisible.value = !isOldPasswordVisible.value;
  }

  void savePassword() {
    if (password.value.length >= 8 && password.value.length <= 20) {
      Get.defaultDialog(
        title: "成功",
        middleText: "密码已保存",
        textConfirm: "确定",
        onConfirm: () => Get.back(),
        confirmTextColor: Colors.white,
        backgroundColor: Colors.green,
      );
    } else {
      Get.defaultDialog(
        title: "错误",
        middleText: "密码长度需在8-20位之间",
        textConfirm: "确定",
        onConfirm: () => Get.back(),
        confirmTextColor: Colors.white,
        backgroundColor: Colors.red,
      );
    }
  }
}
