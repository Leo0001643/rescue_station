import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:rescue_station/app/routes/app_pages.dart';
import 'package:rescue_station/app/theme/app_text_theme.dart';
import 'package:rescue_station/app/utils/dialog_utils.dart';
import 'package:rescue_station/app/utils/widget_utils.dart';

import '../../theme/app_colors_theme.dart';
import '../../utils/AppLayout.dart';
import '../../utils/Icon.dart';
import 'azlistview/az_listview.dart';
import 'contacts_controller.dart';


class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<StatefulWidget> createState() => StateContactsPage();

}

class StateContactsPage extends State<ContactsPage> {
  final controller = Get.find<ContactsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetUtils.buildSearchAppBar(context, "通讯录",
          InkWell(
            onTap: ()=> showPopWindow(context),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 15.w),
              child: const Icon(IconFont.CONTACTS_ADD, color: Colors.white),
            ),
          ),
          onChange: (text)=> controller.filterContacts(text)
      ),
      body: Obx((){
        return Column(
          children: [
            ListTile(
              leading: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.r),
                  color: Colors.deepOrangeAccent,
                ),
                padding: EdgeInsets.all(5.r),
                child: Icon(Icons.add_reaction_outlined,size: 30.r,color: Colors.white,),
              ),
              trailing: Obx(() {
                return Visibility(
                  visible: controller.applyCount.value > 0,
                  child: GFBadge(
                    text: controller.applyCount.value.toString(),
                    shape: GFBadgeShape.circle,
                    border: BorderSide.none,
                  ),
                );
              }),
              title: Text("新的朋友",style: TextStyle(fontSize: 16.sp,color: Colors.black,),),
              onTap: () => Get.toNamed(Routes.NEW_FRIEND),
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
                child: Icon(Icons.group,size: 30.r,color: Colors.white,),
              ),
              title: Text("群聊",style: TextStyle(fontSize: 16.sp,color: Colors.black,),),
              onTap: () => Get.toNamed(Routes.GROUP_LIST),
            ),
            Container(
              height: 10.h,
              width: double.infinity,
              color: Colors.black12,
            ),
            Expanded(
              child: AzListView(
                data: controller.filteredContacts.value,
                itemCount: controller.filteredContacts.length,
                itemBuilder: (context,index){
                  var contact = controller.filteredContacts[index];
                  return Column(
                    children: [
                      Offstage(
                        offstage: contact.isShowSuspension != true,
                        child: Container(
                          // color: ColorX.appBarBg2(),
                          padding: EdgeInsets.symmetric(vertical: 8.h,horizontal: 15.w),
                          width: 1.sw,
                          child: Text(contact.tabIndex,style: TextStyle(fontSize: 14.sp,color: Colors.black),),
                        ),
                      ),
                      ListTile(
                        leading: GFAvatar(
                          backgroundImage: NetworkImage(contact.portrait.em()),
                          radius: 20.r,
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
                },
                padding: EdgeInsets.zero,
                physics: BouncingScrollPhysics(),
              ),
            ),
          ],
        );
      }),
    );
  }

  void showPopWindow(BuildContext context) {
    DialogUtils.showPopMenu(context,
        [
          PopupMenuItem(
            height: 35.h,
            padding: EdgeInsets.zero,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(IconFont.MESSAGE, color: Colors.white,size: AppLayout.fontSize(20),),
                Text("发起群聊", style: AppTextTheme.headLineStyle0.copyWith(color: Colors.white))
              ],
            ),
            onTap: ()=> Get.toNamed(Routes.CREATE_GROUP),
          ),
          const PopupMenuDivider(),
          PopupMenuItem(
            height: 35.h,
            padding: EdgeInsets.zero,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(IconFont.ADD, color: Colors.white,size: AppLayout.fontSize(20),),
                Text("添加朋友", style: AppTextTheme.headLineStyle0.copyWith(color: Colors.white))
              ],
            ),
            onTap: ()=> Get.toNamed(Routes.ADD_FRIEND),
          ),
        ]);
  }



}








