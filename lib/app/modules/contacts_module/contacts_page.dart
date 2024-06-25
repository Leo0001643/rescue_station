import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:rescue_station/app/routes/app_pages.dart';
import 'package:rescue_station/app/theme/app_colors.dart';
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
      body: Obx((){
        return SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                leading: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.r),
                    color: Colors.deepOrangeAccent,
                  ),
                  padding: EdgeInsets.all(5.r),
                  child: Icon(Icons.add_reaction_outlined,size: 40.r,color: Colors.white,),
                ),
                title: Text("新的朋友",style: TextStyle(fontSize: 16.sp,color: Colors.black,),),
                // onTap: () => Get.toNamed(Routes.FRIEND_DETAIL,arguments: contact),
              ),
              Container(
                height: 1.h,
                width: double.infinity,
                color: Colors.black12,
                margin: EdgeInsets.only(left: 80.w,right: 10.w),
              ),
              ListTile(
                leading: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.r),
                    color: Colors.green,
                  ),
                  padding: EdgeInsets.all(5.r),
                  child: Icon(Icons.group,size: 40.r,color: Colors.white,),
                ),
                title: Text("群聊",style: TextStyle(fontSize: 16.sp,color: Colors.black,),),
                // onTap: () => Get.toNamed(Routes.FRIEND_DETAIL,arguments: contact),
              ),
              Container(
                height: 10.h,
                width: double.infinity,
                color: Colors.black12,
              ),
              ...controller.filteredContacts.map((contact){
                return Column(
                  children: [
                    ListTile(
                      leading: GFAvatar(
                        backgroundImage: NetworkImage(contact.portrait.em()),
                        radius: 25.r,
                        shape: GFAvatarShape.standard,
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      title: Text(contact.nickName.em(),style: TextStyle(fontSize: 16.sp,color: Colors.black,),),
                      onTap: () => Get.toNamed(Routes.FRIEND_DETAIL,arguments: contact),
                    ),
                    Container(
                      height: 1.h,
                      width: double.infinity,
                      color: AppStyles.lightGreyWile,
                      margin: EdgeInsets.only(left: 80.w,right: 10.w),
                    ),
                  ],
                );
              })
            ],
          ),
        );
      }),
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
