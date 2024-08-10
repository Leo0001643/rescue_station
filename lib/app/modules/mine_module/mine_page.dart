import 'dart:io';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:getwidget/getwidget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:lifecycle/lifecycle.dart';
import 'package:rescue_station/app/event/message_read_event.dart';
import 'package:rescue_station/app/routes/app_pages.dart';
import 'package:rescue_station/app/utils/app_data.dart';
import 'package:rescue_station/app/utils/logger.dart';
import '../../theme/app_text_theme.dart';
import '../mine_module/mine_controller.dart';
import '../../theme/app_colors_theme.dart';
import '../../utils/AppLayout.dart';
import '../../utils/Icon.dart';

class MinePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => StateMinePage();
}


class StateMinePage extends State<MinePage> with LifecycleAware, LifecycleMixin {
  MineController userController = Get.find<MineController>();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Obx(()=>Scaffold(
        appBar: _appBar(context),
        body: _body()
    ));
  }

  void _showImageSourceActionSheet(BuildContext context, MineController controller) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: FractionallySizedBox(
            heightFactor: 0.5,
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('选择照片'),
                  onTap: () {
                    controller.pickImage(ImageSource.gallery);
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('拍照'),
                  onTap: () {
                    controller.pickImage(ImageSource.camera);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _body(){
    return Padding(
      padding: EdgeInsets.all(AppLayout.width(12)),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(AppLayout.width(12)),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ListTile(
                  leading: Icon(IconFont.NICKE, size: AppLayout.fontSize(28),color: Colors.lightBlue),
                  title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("昵称"),
                        Obx(() {
                          return Text("${userController.userInfo.value.nickName}");
                        })
                      ]
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                  onTap: ()=> Get.toNamed(Routes.NICK_NAME_EDIT),
                ),
                
                Divider(height: 0.1,color: AppStyles.lightGreyWile),
                ListTile(
                  leading: Icon(IconFont.WECHAT, size: AppLayout.fontSize(28), color: Colors.green),
                  title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("微聊号"),
                        Obx(() {
                          return Text("${userController.userInfo.value.chatNo}", overflow: TextOverflow.ellipsis, maxLines: 1, textAlign: TextAlign.right, softWrap: false);
                        })
                      ]
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                  onTap: ()=> print("微聊号"),
                ),
                Divider(height: 0.1,color: AppStyles.lightGreyWile),
                ListTile(
                  leading: Icon(IconFont.ADDRESS, size: AppLayout.fontSize(28), color: Colors.blueAccent),
                  title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("地址"),
                        Obx(() {
                          return Text("${userController.userInfo.value.provinces} ${userController.userInfo.value.city}");
                        })
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
                        const Text("手机号"),
                        Obx(() {
                          return Text("${userController.userInfo.value.phone}");
                        })
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
                  onTap: ()=> Get.toNamed(Routes.PWD_EDIT, ),
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
                    userController.logout();
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _appBar(BuildContext context){
    return AppBar(
        toolbarHeight: AppLayout.heigth(80),
        leadingWidth: AppLayout.heigth(200),
        backgroundColor: Colors.blue,
        leading: Row(
          children: [
            Expanded(child: GestureDetector(
              onTap: (){
                _showImageSourceActionSheet(context, userController);
              },
              child: Padding(
                padding: EdgeInsets.only(left: AppLayout.width(12)),
                child: Row(children: [
                  GFAvatar(
                      radius: AppLayout.width(30),
                      shape: GFAvatarShape.standard,
                      borderRadius: BorderRadius.circular(AppLayout.width(8)),
                      backgroundImage: ((userController.profileImagePath.value.isEmpty && userController.userInfo.value.portrait == null)
                          ? const AssetImage('assets/images/icon/default_avatar.png')
                          : NetworkImage(userController.userInfo.value.portrait!)) as ImageProvider<Object>?
                  ),
                  Gap(AppLayout.width(8)),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("${userController.userInfo.value.nickName}" ,style: AppTextTheme.headLineStyle2.copyWith(color: Colors.white)),
                      Gap(AppLayout.heigth(5)),
                      Text("${userController.userInfo.value.phone}" ,style: AppTextTheme.headLineStyle5),
                    ],
                  )
                ]),
              ),
            )),
          ],
        )
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

  @override
  void onLifecycleEvent(LifecycleEvent event) {
    loggerArray(["生命周期变化了",event]);
    switch (event) {
      case LifecycleEvent.visible:
        var user = AppData.getUser();
        if(isNotEmpty(user)){
          userController.userInfo.value = user!;
        }
        eventBus.fire(MessageReadEvent());
        break;
      default:
        break;
    }
  }



}





