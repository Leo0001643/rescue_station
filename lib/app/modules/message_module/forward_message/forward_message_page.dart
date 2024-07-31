import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:rescue_station/app/db/message_box_table.dart';
import 'package:rescue_station/app/domains/group_info_entity.dart';
import 'package:rescue_station/app/domains/user_info_entity.dart';
import 'package:rescue_station/app/event/chat_event.dart';
import 'package:rescue_station/app/modules/message_module/group_avatar_aidget.dart';
import 'package:rescue_station/app/routes/app_pages.dart';
import 'package:rescue_station/app/theme/app_colors_theme.dart';
import 'package:rescue_station/app/theme/app_text_theme.dart';
import 'package:rescue_station/app/utils/AppLayout.dart';
import 'package:rescue_station/app/utils/app_data.dart';
import 'package:rescue_station/app/utils/widget_utils.dart';

import 'forward_message_logic.dart';

class ForwardMessagePage extends StatefulWidget {
  const ForwardMessagePage({Key? key}) : super(key: key);

  @override
  State<ForwardMessagePage> createState() => _ForwardMessagePageState();
}

class _ForwardMessagePageState extends State<ForwardMessagePage> {
  final logic = Get.find<ForwardMessageLogic>();
  final state = Get.find<ForwardMessageLogic>().state;

  @override
  void initState() {
    state.message = Get.arguments;
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<ForwardMessageLogic>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetUtils.buildAppBar("选择聊天"),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 20.h),
                child: Text("最近聊天",style: TextStyle(fontSize: 10.sp,color: Colors.black,),),
              ),
            ],
          ),
          Expanded(
            child: Obx(() {
              return ListView.separated(
                itemCount: state.messages.length,
                separatorBuilder: (context, index) {
                  return Padding(
                      padding: EdgeInsets.only(left: AppLayout.width(80)),
                      child: Divider(
                          height: AppLayout.heigth(0),
                          color: AppStyles.lightGreyWile));
                },
                itemBuilder: (context, index) {
                  var item = state.messages[index];
                  if (item.boxType == 0) {
                    return buildMessageBox(item);
                  } else {
                    return buildGroupMessageBox(item);
                  }
                },
              );
            }),
          )
        ],
      ),
    );
  }


  Widget buildMessageBox(MessageBoxTable item) {
    // loggerArray(["水电费手动蝶阀撒的说法",item.lastMessage == 'null']);
    var user = UserInfoEntity.fromJson(item.getFromInfo());
    // var msg = SocketMsgContent.fromJson(item.getLastMessage());
    return ListTile(
      onTap: () {
        var my = AppData.getUser();
        if (isNotEmpty(my)) {
          logic.sendFriend(ChatEvent(my!, user, item),state.message);
        }
      },
      leading: GFAvatar(
        backgroundImage: NetworkImage(user.portrait.em()),
        shape: GFAvatarShape.standard,
        borderRadius: BorderRadius.circular(5.r),
        radius: 25.r,
        child: Align(
          alignment: Alignment.topRight,
          child: Visibility(
            visible: (item.unreadCount ?? 0) > 0,
            child: GFBadge(
              size: 20.r,
              shape: GFBadgeShape.circle,
              border: BorderSide.none,
            ),
          ),
        ),
      ),
      title: Text(
        user.nickName.em(),
        style: AppTextTheme.headLineStyle1,
      ),
      // trailing: Text(DateUtil.formatDateMs(item.lastMessageTime ?? 0),
      //     style: AppTextTheme.headLineStyle0),
    );
  }

  Widget buildGroupMessageBox(MessageBoxTable item) {
    var group = GroupInfoEntity.fromJson(item.getFromInfo());
    // var msg = SocketMsgContent.fromJson(item.getLastMessage());
    return ListTile(
      onTap: () {
        var my = AppData.getUser();
        if (isNotEmpty(my)) {
          logic.sendGroup(ChatGroupEvent(my!, group, item),state.message);
        }
      },
      leading: GroupAvatarWidget(group.portrait ?? [],unreadCount: item.unreadCount ?? 0,),
      title: Text(
        group.name.em(),
        style: AppTextTheme.headLineStyle1,
      ),
      // trailing: Text(DateUtil.formatDateMs(item.lastMessageTime ?? 0),
      //     style: AppTextTheme.headLineStyle0),
    );
  }



}