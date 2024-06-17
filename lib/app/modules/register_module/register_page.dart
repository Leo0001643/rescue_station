import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../utils/AppLayout.dart';
import 'register_controller.dart';

class RegisterPage extends GetView<RegisterController> {
  final _formKey = GlobalKey<FormState>();

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
          onPressed: () => Get.back(), // 使用GetX的返回方法
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
            padding: EdgeInsets.all(AppLayout.heigth(32)),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/icon/logo.png', height: AppLayout.heigth(100)),
                  Gap(AppLayout.heigth(20)),
                  Text('会员注册', style: TextStyle(fontSize: AppLayout.fontSize(20), color: Colors.white, fontWeight:FontWeight.w900)),
                  Gap(AppLayout.heigth(40)),
                  TextFormField(
                    controller: controller.phoneController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.phone_iphone, color: Colors.white),
                      prefixText: '+86 ',
                      hintText: '请输入手机号',
                      hintStyle: const TextStyle(color: Colors.white54),
                      filled: true,
                      fillColor: Colors.white12,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                      errorStyle: TextStyle(fontSize: AppLayout.fontSize(14), color: Colors.redAccent),
                    ),
                    style: const TextStyle(color: Colors.white),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '请输入手机号!';
                      }
                      // Regex for phone validation
                      final phoneRegex = RegExp(r'^\d{11}$');
                      if (!phoneRegex.hasMatch(value)) {
                        return '请输入有效的手机号!';
                      }
                      return null;
                    },
                  ),
                  Gap(AppLayout.heigth(20)),
                  TextFormField(
                    controller: controller.nickNameController,  // Set random nickname
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person, color: Colors.white),
                      hintText: '请输入昵称',
                      hintStyle: const TextStyle(color: Colors.white54),
                      filled: true,
                      fillColor: Colors.white12,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppLayout.heigth(12)),
                        borderSide: BorderSide.none,
                      ),
                      errorStyle: const TextStyle(fontSize: 14),
                    ),
                    style: const TextStyle(color: Colors.white),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '请输入昵称';
                      }
                      return null;
                    },
                  ),
                  Gap(AppLayout.heigth(20)),
                  TextFormField(
                    controller: controller.passwordController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock, color: Colors.white),
                      hintText: '请输入密码',
                      hintStyle: const TextStyle(color: Colors.white54),
                      filled: true,
                      fillColor: Colors.white12,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppLayout.heigth(12)),
                        borderSide: BorderSide.none,
                      ),
                      errorStyle: TextStyle(fontSize: AppLayout.fontSize(14), color: Colors.redAccent),
                    ),
                    style: const TextStyle(color: Colors.white),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '请输入密码!';
                      }
                      // Regex for password validation
                      // final passwordRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$'); 密码至少8个字符，并且包含字母和数字!
                      final passwordRegex = RegExp(r'^[A-Za-z\d]{6,12}$');
                      if (!passwordRegex.hasMatch(value)) {
                        return '密码至少6~12个字母或数字!';
                      }
                      return null;
                    },
                  ),
                  Gap(AppLayout.heigth(20)),
                  TextFormField(
                    controller: controller.confirmPasswordController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock, color: Colors.white),
                      hintText: '确认密码',
                      hintStyle: const TextStyle(color: Colors.white54),
                      filled: true,
                      fillColor: Colors.white12,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      errorStyle: TextStyle(fontSize: AppLayout.fontSize(14), color: Colors.redAccent),
                    ),
                    style: const TextStyle(color: Colors.white),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '请确认密码!';
                      }
                      if (value != controller.passwordController.text) {
                        return '密码不匹配!';
                      }
                      return null;
                    },
                  ),
                  Gap(AppLayout.heigth(20)),
                  TextFormField(
                    controller: controller.emailController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.email, color: Colors.white),
                      hintText: '请输入邮箱',
                      hintStyle: const TextStyle(color: Colors.white54),
                      filled: true,
                      fillColor: Colors.white12,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppLayout.heigth(12)),
                        borderSide: BorderSide.none,
                      ),
                      errorStyle: TextStyle(fontSize: AppLayout.fontSize(14), color: Colors.redAccent),
                    ),
                    style: const TextStyle(color: Colors.white),
                    keyboardType: TextInputType.emailAddress,
                    /* validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '请输入邮箱!';
                      }
                      // Regex for email validation
                      final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
                      if (!emailRegex.hasMatch(value)) {
                        return '请输入有效的邮箱!';
                      }
                      return null;
                    },*/
                  ),
                  Gap(AppLayout.heigth(40)),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        controller.register();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(AppLayout.width(366), AppLayout.heigth(60)),
                      backgroundColor: const Color(0xFFC249EC),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppLayout.heigth(12)),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: AppLayout.heigth(100), vertical: AppLayout.width(18)),
                    ),
                    child: Text('提交注册', style: TextStyle(color: Colors.white, fontSize: AppLayout.fontSize(18), fontWeight: FontWeight.w900)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
