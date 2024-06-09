import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../tabs_module/tabs_pages.dart';
import '../../routes/app_pages.dart';
import '../tabs_module/tabs_controller.dart';
import 'login_controller.dart';
import 'package:rescue_station/app/utils/AppLayout.dart';


class LoginPage extends GetView<LoginController> {
  LoginPage({super.key}) {
    Get.put(LoginController());
  }
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: (){
            Get.find<TabsController>().setCurrentIndex(0);
            Get.off(() => const TabsPage());
          },
        ),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple, Colors.blue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/icon/logo.png', height: 100),
                Gap(AppLayout.heigth(20)),
                Obx(() => ToggleButtons(
                  borderColor: Colors.transparent,
                  fillColor: Colors.transparent,
                  selectedBorderColor: Colors.transparent,
                  selectedColor: Colors.white,
                  color: Colors.white,
                  borderWidth: 0,
                  onPressed: (int index) {
                    controller.isPasswordLogin.value = index == 0;
                  },
                  isSelected: [
                    controller.isPasswordLogin.value,
                    !controller.isPasswordLogin.value,
                  ],
                  children: const <Widget> [
                    Text('密码登录', style: TextStyle(fontSize: 16)),
                    Text('验证码登录', style: TextStyle(fontSize: 16)),
                  ],
                )),
                Gap(AppLayout.heigth(20)),
                TextField(
                  controller: controller.phoneController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.phone, color: Colors.white),
                    hintText: '请输入手机号',
                    hintStyle: const TextStyle(color: Colors.white54),
                    filled: true,
                    fillColor: Colors.white12,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                  keyboardType: TextInputType.phone,
                ),
                Gap(AppLayout.heigth(20)),
                Obx(() => controller.isPasswordLogin.value ? TextField(
                  controller: controller.passwordController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock, color: Colors.white),
                    hintText: '请输入密码',
                    hintStyle: const TextStyle(color: Colors.white54),
                    filled: true,
                    fillColor: Colors.white12,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                  obscureText: true,
                )
                    : TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.message, color: Colors.white),
                    hintText: '请输入验证码',
                    hintStyle: const TextStyle(color: Colors.white54),
                    filled: true,
                    fillColor: Colors.white12,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                  keyboardType: TextInputType.number,
                )),
                Gap(AppLayout.heigth(20)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Gap(AppLayout.heigth(20)),// Placeholder for alignment
                    GestureDetector(
                      onTap: () => controller.forgotPassword(),
                      child: const Text('忘记密码?', style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                Gap(AppLayout.heigth(20)),
                ElevatedButton(
                  onPressed: () => controller.login(),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(30.0)),
                  ),
                  child: const Text('登录'),
                ),
                Gap(AppLayout.heigth(20)),
                GestureDetector(
                  onTap: () => Get.toNamed(Routes.REGISTER),
                  child: const Text('注册',style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
