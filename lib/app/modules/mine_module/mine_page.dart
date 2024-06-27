import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rescue_station/app/modules/mine_module/mine_controller.dart';
import '../../theme/app_colors_theme.dart';


class MinePage extends GetView<MineController> {
  // const MinePage({super.key});
    final MineController userController = Get.put(MineController());
    final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(() {
          var user = userController.user.value;
          return SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    _showImageSourceActionSheet(context, userController);
                  },
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: userController.profileImagePath.value.isEmpty
                            ? NetworkImage('https://example.com/profile.jpg')  // Replace with actual image URL
                            : FileImage(File(userController.profileImagePath.value)) as ImageProvider,
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(width: 16),  // Spacing between avatar and text
                      Text("${userController.userInfo.value.nickName}" ,style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                ListTile(
                    leading: const Icon(Icons.ac_unit),
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
                  leading: const Icon(Icons.ac_unit),
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
                  leading: const Icon(Icons.ac_unit),
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
                  leading: const Icon(Icons.ac_unit),
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
                  leading: const Icon(Icons.ac_unit),
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
                  leading: const Icon(Icons.ac_unit),
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
                  leading: const Icon(Icons.ac_unit),
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
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: (){
                    controller.logout();
                  },
                  child: Text('退出账号', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                ),
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
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 16, color: Colors.grey)),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: value,
                border: OutlineInputBorder(),
                isDense: true,
                contentPadding: EdgeInsets.all(8.0),
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
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 16, color: Colors.grey)),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Enter new password',
                border: OutlineInputBorder(),
                isDense: true,
                contentPadding: EdgeInsets.all(8.0),
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
