import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rescue_station/app/event/edit_group_event.dart';
import 'package:rescue_station/app/routes/app_pages.dart';
import 'package:rescue_station/app/theme/app_colors.dart';
import 'package:rescue_station/app/utils/Icon.dart';
import 'package:rescue_station/app/utils/dialog_utils.dart';
import 'package:rescue_station/app/utils/widget_utils.dart';

import 'chat_group_detail_logic.dart';

class ChatGroupDetailPage extends StatefulWidget {
  const ChatGroupDetailPage({Key? key}) : super(key: key);

  @override
  State<ChatGroupDetailPage> createState() => _ChatGroupDetailPageState();
}

class _ChatGroupDetailPageState extends State<ChatGroupDetailPage> {
  final logic = Get.find<ChatGroupDetailLogic>();
  final state = Get.find<ChatGroupDetailLogic>().state;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<ChatGroupDetailLogic>();
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
            padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
            child: Obx(() {
              if (isEmpty(state.groupDetail.value.user)) {
                return Container();
              }
              return Row(
                children: [
                  ...state.groupDetail.value.user!.map((item) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Column(
                        children: [
                          WidgetUtils.buildImage(
                              item.portrait.em(), 45.r, 45.r),
                          Text(
                            item.nickName.em(),
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: color_333,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                  SizedBox(width: 10.w,),
                  InkWell(
                    onTap: ()=> Get.toNamed(Routes.GROUP_ADD,arguments: state.groupDetail.value),
                    child: WidgetUtils.buildImage(ImageFont.detail_add, 45.r, 45.r),
                  ),
                ],
              );
            }),
          ),
          SizedBox(
            height: 15.h,
          ),
          ListTile(
            title: Text(
              "群聊名称",
              style: TextStyle(fontSize: 15.sp, color: Colors.black),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Obx(() {
                  if (isEmpty(state.groupDetail.value.group)) {
                    return Container();
                  }
                  return Text(state.groupDetail.value.group?.name.em() ?? "",style: TextStyle(fontSize: 14.sp,color: color_333),);
                }),
                Icon(Icons.arrow_forward_ios,color: color_d2d,size: 15.r,),
              ],
            ),
            onTap: ()=> Get.toNamed(Routes.EDIT_GROUP_NAME,arguments: EditGroupEvent(state.groupDetail.value, state.chatEvent))?.then((text){
              if(isNotEmpty(text)){
                state.groupDetail.value.group?.name = text;
                state.groupDetail.refresh();
              }
            }),
            tileColor: Colors.white,
          ),
          SizedBox(
            height: 1.h,
          ),
          ListTile(
            title: Text(
              "消息免打扰",
              style: TextStyle(fontSize: 15.sp, color: Colors.black),
            ),
            trailing: Obx(() {
              return Switch(
                value: state.isDisturb.value,
                onChanged: (value) => logic.chatSetDisturb(value),
              );
            }),
            tileColor: Colors.white,
          ),
          SizedBox(
            height: 1.h,
          ),
          ListTile(
            title: Text(
              "置顶聊天",
              style: TextStyle(fontSize: 15.sp, color: Colors.black),
            ),
            trailing: Obx(() {
              return Switch(
                value: state.isTop.value,
                onChanged: (value) => logic.chatSetTop(value),
              );
            }),
            tileColor: Colors.white,
          ),
          SizedBox(
            height: 1.h,
          ),
          ListTile(
            title: Text(
              "清空聊天记录",
              style: TextStyle(fontSize: 15.sp, color: Colors.black),
            ),
            tileColor: Colors.white,
            onTap: () => logic.messageClear(),
          ),
          SizedBox(
            height: 10.h,
          ),
          ListTile(
            title: Center(
              child: Text(
                "退出群聊",
                style: TextStyle(fontSize: 18.sp, color: Colors.red),
              ),
            ),
            tileColor: Colors.white,
            onTap: () =>
                DialogUtils.showAlertDialog(context, "确定要退出群聊吗？").then((value) {
              if (value == true) {
                logic.leaveGroup();
              }
            }),
          ),
        ],
      ),
    );
  }
}
