import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../utils/AppLayout.dart';
import '../../../utils/app_data.dart';
import './nick_name_edit_controller.dart';

class NickNameEditPage extends GetView<NickNameEditController> {
  const NickNameEditPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('设置昵称'),
      ),
      body: Padding(
        padding: EdgeInsets.all(AppLayout.width(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('请为您的账号 ${AppData.getUser()!.phone} 修改昵称',style: TextStyle(fontSize: AppLayout.fontSize(16))),
            Gap(AppLayout.heigth(20)),
            Obx(() => TextField(
              onChanged: (value){
                controller.nickName.value = value;
              },
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: '请填写您的昵称',
                errorText: controller.nickName.value.isNotEmpty ? controller.nickNameError.value : null,
              ),
            )),

            Gap(AppLayout.heigth(40)),
            ElevatedButton(
              onPressed: () {
                if (controller.nickNameError.value.isEmpty) {
                  controller.editNickName();
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
