import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../utils/AppLayout.dart';
import 'register_controller.dart';


class RegisterPage extends GetView<RegisterController> {
  RegisterPage({super.key}) {
    Get.put(RegisterController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),  // 使用GetX的返回方法
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
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
            padding: EdgeInsets.all(AppLayout.heigth(16)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/icon/logo.png', height: AppLayout.heigth(100)),
                Gap(AppLayout.heigth(20)),
                Text('会员注册', style: TextStyle(fontSize: AppLayout.fontSize(20), color: Colors.white)),
                Gap(AppLayout.heigth(20)),
                TextField(
                  controller: controller.usernameController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person, color: Colors.white),
                    hintText: '请输入用户名',
                    hintStyle: const TextStyle(color: Colors.white54),
                    filled: true,
                    fillColor: Colors.white12,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppLayout.heigth(30)),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
                Gap(AppLayout.heigth(20)),
                TextField(
                  controller: controller.passwordController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock, color: Colors.white),
                    hintText: '请输入密码',
                    hintStyle: const TextStyle(color: Colors.white54),
                    filled: true,
                    fillColor: Colors.white12,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppLayout.heigth(30)),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                  obscureText: true,
                ),
                Gap(AppLayout.heigth(20)),
                TextField(
                  controller: controller.confirmPasswordController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock, color: Colors.white),
                    hintText: '确认密码',
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
                ),
                const Gap(20),
                TextField(
                  controller: controller.phoneController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.phone, color: Colors.white),
                    hintText: '请输入手机号',
                    hintStyle: const TextStyle(color: Colors.white54),
                    filled: true,
                    fillColor: Colors.white12,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppLayout.heigth(30)),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                  keyboardType: TextInputType.phone,
                ),
                Gap(AppLayout.heigth(20)),
                ElevatedButton(
                  onPressed: () => controller.register(),
                  child: const Text('注册'),
                  style: ElevatedButton.styleFrom(
                    // primary: Colors.purple,
                    padding: EdgeInsets.symmetric(horizontal: AppLayout.heigth(50), vertical: AppLayout.width(15)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppLayout.heigth(20)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
