import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import './pwd_edit_controller.dart';
import '../../../utils/AppLayout.dart';
import '../../../utils/app_data.dart';


class PwdEditPage extends GetView<PwdEditController> {
  PwdEditPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('设置密码', style: TextStyle(fontSize: AppLayout.fontSize(18))),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: ()=>Get.back(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(AppLayout.width(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('请为您的账号 ${AppData.getUser()!.phone} 设置一个新密码',style: TextStyle(fontSize: AppLayout.fontSize(16))),
            Gap(AppLayout.heigth(20)),
            Obx(() => TextField(
              onChanged: (value){
                controller.oldPwd.value = value;
                controller.validateOldPwd(value);
              },
              obscureText: !controller.isOldPasswordVisible.value,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: '请输入旧密码',
                errorText: controller.oldPwdError.value.isNotEmpty ? controller.oldPwdError.value : null,
                suffixIcon: IconButton(
                  icon: Icon(controller.isOldPasswordVisible.value ? Icons.visibility : Icons.visibility_off),
                  onPressed: () => controller.toggleOldPasswordVisibility(),
                ),
              ),
            )),
            Gap(AppLayout.heigth(20)),
            Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  onChanged: (value) {
                    controller.password.value = value;
                    controller.validatePassword(value);
                  },
                  obscureText: !controller.isPasswordVisible.value,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: '请输入6~12位数字或字母',
                    suffixIcon: IconButton(
                      icon: Icon(controller.isPasswordVisible.value ? Icons.visibility : Icons.visibility_off),
                      onPressed: () => controller.togglePasswordVisibility(),
                    ),
                    errorText: controller.passwordError.value.isNotEmpty ? controller.passwordError.value : null
                  ),
                ),
              ],
            )),
            Gap(AppLayout.heigth(40)),
            ElevatedButton(
              onPressed: () {
                if (controller.passwordError.value.isEmpty) {
                  controller.editPwd();
                } else {
                  Get.snackbar('错误', '请修正表单中的错误');
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: Size(double.infinity, AppLayout.heigth(50)),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppLayout.heigth(12))
                ),
              ),
              child: Text('提交修改', style: TextStyle(fontSize: AppLayout.fontSize(16),color: Colors.white,fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
