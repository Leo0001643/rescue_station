import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:rescue_station/app/db/user_info_table.dart';
import 'package:rescue_station/app/theme/app_colors.dart';
import 'package:rescue_station/app/utils/widget_utils.dart';
import '../../utils/AppLayout.dart';
import 'add_friend_controller.dart';

class AddFriendPage extends GetView<AddFriendController> {
  const AddFriendPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetUtils.buildAppBar("添加好友"),
      backgroundColor: color_e6e,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(AppLayout.heigth(10)),
          Container(
            margin: EdgeInsets.symmetric(horizontal: AppLayout.width(20)),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.r)
            ),
            child: TextField(
              // controller: _searchController,
              textInputAction: TextInputAction.search,
              onSubmitted: (text)=> controller.onSearch(text),
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: '账号/手机号',
                prefixIcon: const Icon(Icons.search, color: Colors.black54),
                contentPadding: EdgeInsets.symmetric(vertical: AppLayout.width(8)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppLayout.width(8)),
                  borderSide: BorderSide.none,
                ),
              ),
              style: const TextStyle(color: Colors.black),
            ),
          ),
          Gap(AppLayout.heigth(10)),
          Padding(
            padding: EdgeInsets.only(left: AppLayout.width(20)),
            child: Text('搜索结果', style: TextStyle(fontSize: AppLayout.fontSize(20), fontWeight: FontWeight.bold)),
          ),
          Gap(AppLayout.heigth(10)),
          Expanded(
            child: Obx(() {
              return ListView.builder(
                itemCount: controller.finds.length,
                itemBuilder: (context,index){
                  return buildFriendItem(index, controller.finds[index]);
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget buildFriendItem(int index, UserInfoTable user) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppLayout.heigth(10)),
      ),
      color: Colors.lightBlue[100],
      margin: EdgeInsets.symmetric(horizontal: AppLayout.width(20),vertical: AppLayout.heigth(10)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppLayout.width(20), vertical: AppLayout.heigth(10)),
        child: Row(
          children: [
            GFAvatar(
              radius: 24.r,
              borderRadius: BorderRadius.circular(5.r),
              shape: GFAvatarShape.standard,
              backgroundImage: NetworkImage(user.portrait.em()),
            ),
            Gap(AppLayout.width(16)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('性别：${user.genderLabel.em()}', style: TextStyle(fontSize: AppLayout.fontSize(16))),
                  Text('地址：${user.provinces.em()}${user.city.em()}', style: TextStyle(fontSize:AppLayout.fontSize(16)),maxLines: 1, softWrap: true, overflow: TextOverflow.ellipsis,),
                  Text('昵称：${user.nickName.em()}', style: TextStyle(fontSize: AppLayout.fontSize(16))),
                ],
              ),
            ),
            Visibility(///是否添加过好友了
              visible: user.isFriend == 'N',
              child: WidgetUtils.buildElevatedButton('添加好友', 80.w, 35.h,bg: color_703, onPressed: ()=> controller.applyAdd(user)),
            ),
          ],
        ),
      ),
    );
  }

}
