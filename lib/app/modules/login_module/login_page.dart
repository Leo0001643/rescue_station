import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:rescue_station/app/routes/app_pages.dart';
import 'package:rescue_station/app/theme/app_colors_theme.dart';
import 'package:rescue_station/app/utils/AppLayout.dart';
import 'package:rescue_station/app/utils/dialog_utils.dart';

import 'login_controller.dart';


class LoginPage extends GetView<LoginController> {
  final _formKey = GlobalKey<FormState>();
  LoginPage({super.key}) {
    Get.put(LoginController());
  }
  // final TextEditingController phoneController = TextEditingController();
  // final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: ()=> Get.back(result: false),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: ()=>Get.toNamed(Routes.REGISTER),
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
            Text('登录',style: TextStyle(color: Colors.white, fontSize: AppLayout.fontSize(20), fontWeight: FontWeight.w900)),
            Gap(AppLayout.heigth(30)),
            Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: AppLayout.heigth(32), vertical: AppLayout.width(12)),
                      child: TextFormField(
                        controller: controller.phoneController,
                        // keyboardType: TextInputType.phone,
                        style: const TextStyle(color: Colors.white),
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9]')),],
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person, size: AppLayout.heigth(32), color: Colors.white),
                          // prefixText: '+86 ',
                          // prefixStyle: TextStyle(fontSize: AppLayout.fontSize(18), color: Colors.white),
                          hintText: '请输入手机号/账号',
                          hintStyle: TextStyle(fontSize: AppLayout.fontSize(16), fontWeight: FontWeight.bold, color: AppStyles.lightGreyWile),
                          filled: true,
                          fillColor: Colors.white24,
                          errorStyle: TextStyle(fontSize: AppLayout.fontSize(16), fontWeight: FontWeight.w600, color: Colors.blue),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppLayout.heigth(12)),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '请输入账号!';
                          }
                          final phoneRegex = RegExp(r'^[A-Za-z\d]{4,11}$');
                          if (!phoneRegex.hasMatch(value)) {
                            return '请输入有效账号!';
                          }
                          return null;
                        },
                      ),
                    ),
                    Gap(AppLayout.heigth(20)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: AppLayout.heigth(32), vertical: AppLayout.width(8)),
                      child: TextFormField(
                        controller: controller.passwordController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock, size: AppLayout.heigth(32), color: Colors.white),
                          hintText: '请输入密码',
                          hintStyle: TextStyle(fontSize: AppLayout.fontSize(16), fontWeight: FontWeight.bold, color: AppStyles.lightGreyWile),
                          filled: true,
                          fillColor: Colors.white24,
                          errorStyle: TextStyle(fontSize: AppLayout.fontSize(16), fontWeight: FontWeight.bold, color: Colors.blue),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppLayout.heigth(12)),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        style: const TextStyle(color: Colors.white),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '请填写正确的密码!';
                          }
                          final passwordRegex = RegExp(r'^[A-Za-z\d]{6,12}$');
                          if (!passwordRegex.hasMatch(value)) {
                            return '密码至少6~12个字母或数字!';
                          }
                          return null;
                        },
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(right:  AppLayout.width(32)),
                        child: TextButton(
                          onPressed: () {
                            // 忘记密码逻辑
                            DialogUtils.showSingleDialog(context, "请联系在线客服进行处理！");
                          },
                          child: Text('忘记密码?',style: TextStyle(fontSize: AppLayout.fontSize(16), color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Gap(AppLayout.heigth(20)),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(AppLayout.width(300), AppLayout.heigth(48)),
                        backgroundColor: const Color.fromRGBO(100, 42, 248, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppLayout.heigth(12)),
                        ),
                        // padding: EdgeInsets.symmetric(horizontal: AppLayout.heigth(100), vertical: AppLayout.width(18)),
                      ),
                      child: Text('登录', style: TextStyle(color: Colors.white, fontSize: AppLayout.fontSize(18), fontWeight: FontWeight.w900)),
                      onPressed: (){
                        if (_formKey.currentState!.validate()) {
                          FocusScope.of(context).unfocus();
                          controller.login();
                        }
                      },
                    ),
                  ],
                )
            ),
          ],
        ),
      ),
    );
  }
}
