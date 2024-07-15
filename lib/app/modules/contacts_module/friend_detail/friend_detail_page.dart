import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:rescue_station/app/db/db_helper.dart';
import 'package:rescue_station/app/event/chat_event.dart';
import 'package:rescue_station/app/routes/app_pages.dart';
import 'package:rescue_station/app/theme/app_colors.dart';
import 'package:rescue_station/app/utils/AppLayout.dart';
import 'package:rescue_station/app/utils/app_data.dart';
import 'package:rescue_station/app/utils/widget_utils.dart';

import 'friend_detail_logic.dart';

///Author: soushin
///Date: 2024/6/20 15:45
///Description:

class FriendDetailPage extends StatefulWidget {
  const FriendDetailPage({Key? key}) : super(key: key);

  @override
  State<FriendDetailPage> createState() => _FriendDetailPageState();
}

class _FriendDetailPageState extends State<FriendDetailPage> {
  final logic = Get.find<FriendDetailLogic>();
  final state = Get.find<FriendDetailLogic>().state;

  @override
  void dispose() {
    Get.delete<FriendDetailLogic>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetUtils.buildAppBar(""),
      backgroundColor: Colors.white,
      body: Obx(() {
        var user = state.userInfo.value;
        if(ObjectUtil.isEmpty(user.userId)) return Container();
        return Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: AppLayout.heigth(30), horizontal: AppLayout.width(20)),
              child: Row(
                children: [
                  GFAvatar(
                    radius: 30.r,
                    borderRadius: BorderRadius.circular(5.r),
                    shape: GFAvatarShape.standard,
                    backgroundImage: NetworkImage(user.portrait.em()),
                  ),
                  SizedBox(width: AppLayout.width(10),),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(user.nickName.em(),style: TextStyle(fontSize: AppLayout.fontSize(20),color: Colors.black,fontWeight: FontWeight.bold),),
                            SizedBox(width: AppLayout.width(5),),
                            if(user.gender.em() == "1")
                              Icon(Icons.male,color: Colors.blue,size: 20.r,),
                            if(user.gender.em() == "2")
                              Icon(Icons.female,color: Colors.pink,size: 20.r,),
                          ],
                        ),
                        SizedBox(height: AppLayout.heigth(5),),
                        Text("微聊号：${user.chatNo.em()}",style: TextStyle(fontSize: AppLayout.fontSize(14),color: color_333),),
                        SizedBox(height: AppLayout.heigth(5),),
                        Text("地区：${user.provinces.em()} ${user.city.em()}",style: TextStyle(fontSize: AppLayout.fontSize(14),color: color_333),),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(///跳转聊天页面
                      onTap: ()=>logic.openChatBox(),
                      child: Container(
                        padding: EdgeInsets.all(10.r),
                        child: Icon(Icons.chat_outlined,color: color_703,size: 30.r,),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Container(
            //   color: Colors.black12,
            //   height: AppLayout.heigth(1),
            //   width: double.infinity,
            // ),
            Container(
              color: color_d2d,
              height: AppLayout.heigth(10),
              width: double.infinity,
            ),
            InkWell(
              onTap: ()=> logic.delFriend(),
              child: SizedBox(
                height: AppLayout.heigth(55),
                child: Container(
                  alignment: Alignment.center,
                  child: Text('删除好友',style: TextStyle(fontSize: AppLayout.fontSize(16),color: color_ff0),),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }



}