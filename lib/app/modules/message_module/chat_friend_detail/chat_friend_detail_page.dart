import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rescue_station/app/theme/app_colors.dart';
import 'package:rescue_station/app/utils/Icon.dart';
import 'package:rescue_station/app/utils/widget_utils.dart';

import 'chat_friend_detail_logic.dart';

class ChatFriendDetailPage extends StatefulWidget {
  const ChatFriendDetailPage({Key? key}) : super(key: key);

  @override
  State<ChatFriendDetailPage> createState() => _ChatFriendDetailPageState();
}

class _ChatFriendDetailPageState extends State<ChatFriendDetailPage> {
  final logic = Get.find<ChatFriendDetailLogic>();
  final state = Get.find<ChatFriendDetailLogic>().state;

  @override
  void initState() {
    state.chatEvent = Get.arguments;
    state.isTop.value = state.chatEvent.messageBox.getIsTop();
    state.isDisturb.value = state.chatEvent.messageBox.getIsDisturb();
    super.initState();
  }


  @override
  void dispose() {
    Get.delete<ChatFriendDetailLogic>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetUtils.buildAppBar("聊天详情"),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 15.h,horizontal: 15.w),
            child: Row(
              children: [
                Column(
                  children: [
                    WidgetUtils.buildImage(state.chatEvent.friend.portrait.em(), 45.r, 45.r),
                    Text(state.chatEvent.friend.nickName.em(),style: TextStyle(fontSize: 12.sp,color: color_333,),),
                  ],
                ),
                // SizedBox(width: 10.w,),
                // WidgetUtils.buildImage(ImageFont.detail_add, 45.r, 45.r),
              ],
            ),
          ),
          SizedBox(height: 15.h,),
          ListTile(
            title: Text("消息免打扰",style: TextStyle(fontSize: 15.sp,color: Colors.black),),
            trailing: Obx(() {
              return Switch(
                value: state.isDisturb.value,
                onChanged: (value)=> logic.chatSetDisturb(value),
              );
            }),
            tileColor: Colors.white,
          ),
          SizedBox(height: 1.h,),
          ListTile(
            title: Text("置顶聊天",style: TextStyle(fontSize: 15.sp,color: Colors.black),),
            trailing: Obx(() {
              return Switch(
                value: state.isTop.value,
                onChanged: (value)=> logic.chatSetTop(value),
              );
            }),
            tileColor: Colors.white,
          ),
          SizedBox(height: 1.h,),
          ListTile(
            title: Text("清空聊天记录",style: TextStyle(fontSize: 15.sp,color: Colors.black),),
            tileColor: Colors.white,
            onTap: ()=> logic.messageClear(),
          ),
        ],
      ),
    );
  }





}