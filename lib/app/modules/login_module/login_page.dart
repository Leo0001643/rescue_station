import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:rescue_station/app/theme/app_colors_theme.dart';
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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: (){
            Get.find<TabsController>().setCurrentIndex(0);
            Get.off(() => const TabsPage());
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: ()=>Get.toNamed('/register'),
            child: Text('注册',style: TextStyle(color: Colors.white, fontSize: AppLayout.fontSize(16), fontWeight: FontWeight.w900)),
          ),
        ],
      ),

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF8A2387), Color(0xFFE94057), Color(0xFFF27121)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/icon/logo.png', height: AppLayout.heigth(100)),
            Gap(AppLayout.heigth(20)),
            Text('登录',style: TextStyle(color: Colors.white, fontSize: AppLayout.fontSize(26), fontWeight: FontWeight.w900)),
            Gap(AppLayout.heigth(40)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppLayout.heigth(32), vertical: AppLayout.width(12)),
              child: TextField(
                controller: controller.phoneController,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white),
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person, size: AppLayout.heigth(36), color: Colors.white),
                  prefixText: '+86 ',
                  prefixStyle: TextStyle(fontSize: AppLayout.fontSize(18), color: Colors.white),
                  hintText: '请输入手机号/账号',
                  hintStyle: TextStyle(fontSize: AppLayout.fontSize(18), color: AppStyles.lightGreyWile),
                  filled: true,
                  fillColor: Colors.white24,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppLayout.heigth(12)),
                    borderSide: BorderSide.none,
                  ),
                ),

              ),
            ),
            Gap(AppLayout.heigth(20)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppLayout.heigth(32), vertical: AppLayout.width(8)),
              child: TextField(
                controller: controller.passwordController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock, size: AppLayout.heigth(36), color: Colors.white),
                  hintText: '请输入密码',
                  hintStyle: TextStyle(fontSize: AppLayout.fontSize(18), color: AppStyles.lightGreyWile),
                  filled: true,
                  fillColor: Colors.white24,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppLayout.heigth(12)),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: const TextStyle(color: Colors.white),
                obscureText: true,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(right:  AppLayout.width(32)),
                child: TextButton(
                  onPressed: () {
                    // 忘记密码逻辑
                  },
                  child: Text('忘记密码?',style: TextStyle(fontSize: AppLayout.fontSize(16), color: Colors.white),
                  ),
                ),
              ),
            ),
            Gap(AppLayout.heigth(20)),
            ElevatedButton(
              onPressed: () => controller.login(),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(AppLayout.width(366), AppLayout.heigth(60)),
                backgroundColor: const Color.fromRGBO(100, 42, 248, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppLayout.heigth(12)),
                ),
                padding: EdgeInsets.symmetric(horizontal: AppLayout.heigth(100), vertical: AppLayout.width(18)),
              ),
              child: Text('登录', style: TextStyle(color: Colors.white, fontSize: AppLayout.fontSize(18), fontWeight: FontWeight.w900)),
            ),
          ],
        ),
      ),
    );
  }
}
