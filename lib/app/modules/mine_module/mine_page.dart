import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../mine_module/mine_controller.dart';
import '../../theme/app_colors_theme.dart';
import '../../utils/AppLayout.dart';
import '../../utils/Icon.dart';


class MinePage extends GetView<MineController> {
    final userController = Get.find<MineController>();
    final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            toolbarHeight: AppLayout.heigth(50),
            leadingWidth: AppLayout.heigth(200),
            backgroundColor: Colors.blue,
            leading: Row(
                children: [
                  GestureDetector(
                    onTap: (){
                      _showImageSourceActionSheet(context, userController);
                    },
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: userController.profileImagePath.value.isEmpty
                          ? const NetworkImage('https://pic.rmb.bdstatic.com/bjh/2b67e6c5784ec80eae9c5282c978115c5399.jpeg@h_1280')
                          : FileImage(File(userController.profileImagePath.value)) as ImageProvider,
                    ),
                  ),
                  Gap(AppLayout.width(8)),
                  Text("${userController.userInfo.value.nickName}" ,style: TextStyle(fontSize: AppLayout.fontSize(18), color: Colors.white, fontWeight: FontWeight.w600)),
                ],
              )
          ),
        body: Obx(() {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 12,),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Divider(height: 0.1,color: AppStyles.lightGreyWile),
                ListTile(
                    leading: Icon(IconFont.NICKE, size: AppLayout.fontSize(28),color: Colors.lightBlue),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("昵称"),
                        Text("${userController.userInfo.value.nickName}")
                      ]
                    ),
                    trailing: Icon(Icons.arrow_forward_ios),
                    contentPadding: EdgeInsets.symmetric(horizontal: 0),
                    onTap: ()=> print("昵称"),
                ),
                Divider(height: 0.1,color: AppStyles.lightGreyWile),
                ListTile(
                  leading: Icon(IconFont.WECHAT, size: AppLayout.fontSize(28), color: Colors.green),
                  title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("微聊号"),
                        Text("${userController.userInfo.value.chatNo}", overflow: TextOverflow.ellipsis, maxLines: 1, textAlign: TextAlign.right, softWrap: false)
                      ]
                  ),
                  trailing: Icon(Icons.arrow_forward_ios),
                  contentPadding: EdgeInsets.symmetric(horizontal: 0),
                  onTap: ()=> print("昵称"),
                ),
                Divider(height: 0.1,color: AppStyles.lightGreyWile),

                ListTile(
                  leading: Icon(IconFont.BIRTHDAY, size: AppLayout.fontSize(28), color: Colors.pinkAccent),
                  title: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("生日"),
                        Text("1998-01-06")
                      ]
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                  onTap: ()=> print("生日"),
                ),
                Divider(height: 0.1,color: AppStyles.lightGreyWile),

                ListTile(
                  leading: Icon(IconFont.SEX, size: AppLayout.fontSize(28), color: Colors.pink),
                  title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("性别"),
                        Text("${userController.userInfo.value.genderLabel}")
                      ]
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                  onTap: ()=> print("性别"),
                ),
                Divider(height: 0.1,color: AppStyles.lightGreyWile),

                ListTile(
                  leading: Icon(IconFont.ADDRESS, size: AppLayout.fontSize(28), color: Colors.blueAccent),
                  title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("地址"),
                        Text("${userController.userInfo.value.provinces} ${userController.userInfo.value.city}")
                      ]
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                  onTap: ()=> print("地址"),
                ),
                Divider(height: 0.1,color: AppStyles.lightGreyWile),

                ListTile(
                  leading: Icon(IconFont.PHONE, size: AppLayout.fontSize(28), color: Colors.redAccent),
                  title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("手机号"),
                        Text("${userController.userInfo.value.phone}")
                      ]
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                  onTap: ()=> print("手机号"),
                ),
                Divider(height: 0.1,color: AppStyles.lightGreyWile),

                ListTile(
                  leading: Icon(IconFont.EDITPWD, size: AppLayout.fontSize(28), color: Colors.blueAccent),
                  title: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("修改密码"),
                      ]
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                  onTap: ()=> print("修改密码"),
                ),
                Divider(height: 0.1,color: AppStyles.lightGreyWile),
                Gap(AppLayout.heigth(48)),
                InkWell(
                  child: Container(
                  height: AppLayout.heigth(48),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppStyles.buttonColor,
                    borderRadius: BorderRadius.circular(8)
                  ),
                  child: Center(
                    child: Text("退出账号", style: TextStyle(fontSize: AppLayout.fontSize(18), fontWeight: FontWeight.w700, color: Colors.white), textAlign: TextAlign.center),
                  ),
                  ),
                  onTap: (){
                    controller.logout();
                  },
                )
              ],
            ),
          );
    }));
  }

  void _showImageSourceActionSheet(BuildContext context, MineController controller) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('选择照片'),
                onTap: () {
                  controller.pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('拍照'),
                onTap: () {
                  controller.pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildEditableRow(String label, String value, Function(String) onEdit) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppLayout.heigth(8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: AppLayout.fontSize(16), color: Colors.grey)),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: value,
                border: const OutlineInputBorder(),
                isDense: true,
                contentPadding: EdgeInsets.all(AppLayout.width(8)),
              ),
              onSubmitted: onEdit,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPasswordRow(String label, TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppLayout.heigth(8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: AppLayout.fontSize(16), color: Colors.grey)),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Enter new password',
                border: const OutlineInputBorder(),
                isDense: true,
                contentPadding: EdgeInsets.all(AppLayout.width(8)),
              ),
              obscureText: true,
              onSubmitted: (value) {
                userController.updatePassword(value);
                controller.clear();
              },
            ),
          ),
        ],
      ),
    );
  }
}
