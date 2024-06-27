import 'dart:math';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:gap/gap.dart';
import 'package:getwidget/getwidget.dart';
import 'package:rescue_station/app/db/db_helper.dart';
import 'package:rescue_station/app/db/message_box_table.dart';
import 'package:rescue_station/app/db/user_info_table.dart';
import 'package:rescue_station/app/domains/message.dart';
import 'package:rescue_station/app/event/chat_event.dart';
import 'package:rescue_station/app/socket/socket_message_entity.dart';
import 'package:rescue_station/app/utils/dialog_utils.dart';
import 'package:rescue_station/app/utils/logger.dart';
import 'package:rescue_station/app/utils/widget_utils.dart';
import '../../routes/app_pages.dart';
import '../../theme/app_text_theme.dart';
import '../../theme/app_colors_theme.dart';
import '../../utils/AppLayout.dart';
import '../../utils/Icon.dart';
import 'message_controller.dart';
import 'package:get/get.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<StatefulWidget> createState() =>StateMessagePage();

}

class StateMessagePage extends State<MessagePage>{
  final controller = Get.find<MessageController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetUtils.buildSearchAppBar(context,"消息",Container()),
      body: Obx(() {
        return ListView.separated(
          itemCount: controller.messages.length,
          separatorBuilder: (context, index) {
            return Padding(
                padding: EdgeInsets.only(left: AppLayout.width(80)),
                child: Divider(height: AppLayout.heigth(0),color: AppStyles.lightGreyWile)
            );
          },
          itemBuilder: (context, index) {
            var item = controller.messages[index];
            return buildMessageBox(item);
          },
        );
      }),
    );
  }

  Widget buildMessageBox(MessageBoxTable item) {
    var user = UserInfoTable.fromJson(item.fromInfo!);
    var msg = SocketMsgContent.fromJson(item.lastMessage!);
    return Slidable(
      key: ValueKey(item.boxId.em()),
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        // dismissible: DismissiblePane(onDismissed: () {}),
        children: [
          SlidableAction(
            onPressed: (context){},
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: '删除',
          ),
          SlidableAction(
            onPressed: (context){},
            backgroundColor: Colors.lightGreen,
            foregroundColor: Colors.white,
            icon: Icons.share,
            label: '置顶',
          ),
        ],
      ),
      child: ListTile(
        onTap: ()=> DbHelper().getUser().then((value) {
          if(ObjectUtil.isNotEmpty(value)){
            Get.toNamed(Routes.CHAT_BY_FRIEND,arguments: ChatEvent(value!, user));
          }
        }),
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
              ),
            ),
          ),
        ),
        title: Text(user.nickName.em(),style: AppTextTheme.headLineStyle1,),
        subtitle: Text(msg.content.em(), style: AppTextTheme.headLineStyle0,),
        trailing: Transform.translate(
            offset: Offset(AppLayout.width(18),0),
            child : Text(DateUtil.formatDateMs(item.lastMessageTime ?? 0), style: AppTextTheme.headLineStyle0)
        ),
      ),
    );
  }


}




