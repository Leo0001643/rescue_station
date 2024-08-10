import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../utils/AppLayout.dart';
import '../../../utils/app_data.dart';
import './chatNo_edit_controller.dart';

class ChatNoEditPage extends GetView<ChatNoEditController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('设置微聊账号', style: TextStyle(fontSize: AppLayout.fontSize(18))),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: ()=>Get.back()
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(AppLayout.width(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('请为您的账号 ${AppData.getUser()!.phone} 修改微聊账号',style: TextStyle(fontSize: AppLayout.fontSize(16))),
            Gap(AppLayout.heigth(20)),
            Obx(() => TextField(
              onChanged: (value) {
                controller.chatNo.value = value;
                controller.validateChatNo(value);
              },
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: '请填写6~20位数字或字母',
                errorText: controller.chatNoError.value.isNotEmpty ? controller.chatNoError.value : null,
              ),
            )),

            Gap(AppLayout.heigth(40)),
            ElevatedButton(
              onPressed: () {
                if (controller.chatNoError.value.isEmpty) {
                  controller.editChatNo();
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
