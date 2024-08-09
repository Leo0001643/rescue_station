import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:rescue_station/app/utils/AppLayout.dart';
import 'package:rescue_station/app/modules/mine_module/pwd_edit_page/pwd_edit_controller.dart';


class PwdEditPage extends GetView<PwdEditController> {
  final PwdEditController controller = Get.put(PwdEditController());
  PwdEditPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('设置登录密码'),
      ),
      body: Padding(
        padding: EdgeInsets.all(AppLayout.width(16)),
        child: Column(
          children: [
            Text('请为您的账号 130******58 设置一个新密码', style: TextStyle(fontSize: AppLayout.fontSize(16))),
            Gap(AppLayout.heigth(20)),
            Obx(() => TextField(
              onChanged: (value) => controller.oldpwd.value = value,
              obscureText: !controller.isPasswordVisible.value,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: '请输入旧密码',
                suffixIcon: IconButton(
                  icon: Icon(controller.isOldPasswordVisible.value ? Icons.visibility : Icons.visibility_off),
                  onPressed: () => controller.togglePasswordVisibility(),
                ),
              ),
            )),
            Gap(AppLayout.heigth(20)),
            Obx(() => TextField(
              onChanged: (value) => controller.password.value = value,
              obscureText: !controller.isPasswordVisible.value,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: '6-12位数字字母组合',
                suffixIcon: IconButton(
                  icon: Icon(controller.isPasswordVisible.value ? Icons.visibility : Icons.visibility_off),
                  onPressed: () => controller.togglePasswordVisibility(),
                ),
              ),
            )),
            Gap(AppLayout.heigth(40)),
            ElevatedButton(
              onPressed: () => controller.savePassword(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: Size(double.infinity, AppLayout.heigth(50)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppLayout.heigth(12))
                ),
              ),
              child: Text('保存新密码', style: TextStyle(fontSize: AppLayout.fontSize(20), color: Colors.white, fontWeight: FontWeight.w700)),
            ),
          ],
        ),
      ),
    );
  }
}
