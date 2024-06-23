import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:rescue_station/app/modules/mine_module/mine_controller.dart';


class MinePage extends GetView<MineController> {
  // const MinePage({super.key});

    final MineController userController = Get.put(MineController());
    final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Obx(() {
        var user = controller.user.value;
        return SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  _showImageSourceActionSheet(context, controller);
                },
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: controller.profileImagePath.value.isEmpty
                      ? NetworkImage('https://example.com/profile.jpg')  // Replace with actual image URL
                      : FileImage(File(controller.profileImagePath.value)) as ImageProvider,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              buildEditableRow('昵称', user.nickname, (value) => controller.updateNickname(value)),
              buildEditableRow('账号', user.accountNumber, (value) => controller.updateAccountNumber(value)),
              buildEditableRow('性别', user.gender, (value) => controller.updateGender(value)),
              buildEditableRow(
                '生日',
                DateFormat('yyyy-MM-dd').format(user.birthdate),
                    (value) async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: user.birthdate,
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null) controller.updateBirthdate(picked);
                },
              ),
              buildEditableRow('地址', user.address, (value) => controller.updateAddress(value)),
              buildEditableRow('手机号', user.phoneNumber, (value) => controller.updatePhoneNumber(value)),
              buildPasswordRow('修改密码', passwordController),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Handle logout
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
      }),
    );
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
