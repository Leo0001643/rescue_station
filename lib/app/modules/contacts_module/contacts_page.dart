import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:rescue_station/app/routes/app_pages.dart';
import 'package:rescue_station/app/theme/app_text_theme.dart';
import 'package:rescue_station/app/utils/dialog_utils.dart';
import 'package:rescue_station/app/utils/widget_utils.dart';
import '../../utils/Icon.dart';
import '../../utils/AppLayout.dart';
import '../../theme/app_colors_theme.dart';
import 'contacts_controller.dart';


class ContactsPage extends GetView<ContactsController> {
  const ContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetUtils.buildSearchAppBar(context, "通讯录",
        InkWell(
          onTap: ()=> showPopWindow(context),
          child: const Icon(IconFont.CONTACTS_ADD, color: Colors.white),
        ),
        onChange: (text)=> controller.filterContacts(text)
      ),
      body: Obx(() => ListView.separated(
        itemCount: controller.filteredContacts.length,
        separatorBuilder: (context, index) {
          return Padding(
              padding: EdgeInsets.only(left: AppLayout.width(80)),
              child: Divider(height: AppLayout.heigth(0),color: AppStyles.lightGreyWile)
          );
        },
        itemBuilder: (context, index) {
          final contact = controller.filteredContacts[index];
          return ListTile(
            leading: GFAvatar(
              backgroundImage: NetworkImage(contact.portrait.em()),
              radius: 25.r,
              shape: GFAvatarShape.standard,
              borderRadius: BorderRadius.circular(5.r),
            ),
            title: Text(contact.nickName.em()),
            onTap: () => Get.toNamed(Routes.FRIEND_DETAIL,arguments: contact),
          );
          // return Dismissible(
          //   key: Key(contact.userId.em()),
          //   direction: DismissDirection.endToStart,
          //   onDismissed: (direction) {
          //     controller.deleteContact(contact);
          //   },
          //   background: Container(
          //     color: Colors.red,
          //     alignment: Alignment.centerRight,
          //     padding: EdgeInsets.symmetric(horizontal: 20),
          //     child: Icon(Icons.delete, color: Colors.white),
          //   ),
          //   child: ListTile(
          //     leading: GFAvatar(
          //       backgroundImage: NetworkImage(contact.portrait.em()),
          //       radius: 25.r,
          //       shape: GFAvatarShape.standard,
          //       borderRadius: BorderRadius.circular(5.r),
          //     ),
          //     title: Text(contact.nickName.em()),
          //     onTap: () {
          //       // Handle contact tap
          //     },
          //   ),
          // );
        },
      )),
    );
  }

  void showPopWindow(BuildContext context) {
    DialogUtils.showPopMenu(context,
        [
          PopupMenuItem(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Icon(IconFont.MESSAGE, color: Colors.white),
                Gap(AppLayout.width(6)),
                Text("发起群聊", style: AppTextTheme.headLineStyle0.copyWith(color: Colors.white))
              ],
            ),
            onTap: ()=> Get.toNamed(Routes.CREATE_GROUP),
          ),
          const PopupMenuDivider(),
          PopupMenuItem(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Icon(IconFont.ADD, color: Colors.white),
                Gap(AppLayout.width(6)),
                Text("添加朋友", style: AppTextTheme.headLineStyle0.copyWith(color: Colors.white))
              ],
            ),
            onTap: ()=> Get.toNamed(Routes.ADD_FRIEND),
          ),
        ]);
  }




}
