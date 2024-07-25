import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:getwidget/getwidget.dart';
import 'package:rescue_station/app/db/message_box_table.dart';
import 'package:rescue_station/app/domains/group_info_entity.dart';
import 'package:rescue_station/app/domains/message_type_enum.dart';
import 'package:rescue_station/app/domains/user_info_entity.dart';
import 'package:rescue_station/app/event/chat_event.dart';
import 'package:rescue_station/app/modules/message_module/group_avatar_aidget.dart';
import 'package:rescue_station/app/socket/socket_message_entity.dart';
import 'package:rescue_station/app/socket/socket_utils.dart';
import 'package:rescue_station/app/utils/app_data.dart';
import 'package:rescue_station/app/utils/dialog_utils.dart';
import 'package:rescue_station/app/utils/logger.dart';
import 'package:rescue_station/app/utils/widget_utils.dart';
import '../../routes/app_pages.dart';
import '../../theme/app_text_theme.dart';
import '../../theme/app_colors_theme.dart';
import '../../utils/AppLayout.dart';
import 'message_controller.dart';
import 'package:get/get.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<StatefulWidget> createState() => StateMessagePage();
}

class StateMessagePage extends State<MessagePage> {
  final controller = Get.find<MessageController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetUtils.buildSearchAppBar(context, "消息", Container()),
      body: Obx(() {
        return ListView.separated(
          itemCount: controller.messages.length,
          separatorBuilder: (context, index) {
            return Padding(
                padding: EdgeInsets.only(left: AppLayout.width(80)),
                child: Divider(
                    height: AppLayout.heigth(0),
                    color: AppStyles.lightGreyWile));
          },
          itemBuilder: (context, index) {
            var item = controller.messages[index];
            if (item.boxType == 0) {
              return buildMessageBox(item);
            } else {
              return buildGroupMessageBox(item);
            }
          },
        );
      }),
    );
  }

  Widget buildMessageBox(MessageBoxTable item) {
    // loggerArray(["水电费手动蝶阀撒的说法",item.lastMessage == 'null']);
    var user = UserInfoEntity.fromJson(item.getFromInfo());
    var msg = SocketMsgContent.fromJson(item.getLastMessage());
    return Slidable(
      key: ValueKey(item.boxId.em()),
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        // dismissible: DismissiblePane(onDismissed: () {}),
        children: [
          SlidableAction(
            onPressed: (context) =>
                DialogUtils.showAlertDialog(context, "确定要删除该对话吗？")
                    .then((value) {
              if (value == true) {
                controller.chatDelete(item);
              }
            }),
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            flex: 2,
            icon: Icons.delete,
            label: '删除',
          ),
          SlidableAction(
            onPressed: (context) => controller.chatSetTop(item),
            backgroundColor: Colors.lightGreen,
            foregroundColor: Colors.white,
            flex: 3,
            icon: Icons.share,
            label: item.getIsTop() ? "取消置顶" : "置顶",
          ),
        ],
      ),
      child: ListTile(
        onTap: () {
          var my = AppData.getUser();
          if (isNotEmpty(my)) {
            Get.toNamed(Routes.CHAT_BY_FRIEND,
                arguments: ChatEvent(my!, user, item));
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
              ),
            ),
          ),
        ),
        title: Text(
          user.nickName.em(),
          style: AppTextTheme.headLineStyle1,
        ),
        subtitle: buildLastMessage(msg),
        trailing: Text(DateUtil.formatDateMs(item.lastMessageTime ?? 0),
            style: AppTextTheme.headLineStyle0),
      ),
    );
  }

  Widget buildGroupMessageBox(MessageBoxTable item) {
    var group = GroupInfoEntity.fromJson(item.getFromInfo());
    var msg = SocketMsgContent.fromJson(item.getLastMessage());
    return Slidable(
      key: ValueKey(item.boxId.em()),
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        // dismissible: DismissiblePane(onDismissed: () {}),
        children: [
          SlidableAction(
            onPressed: (context) =>
                DialogUtils.showAlertDialog(context, "确定要删除该对话吗？")
                    .then((value) {
              if (value == true) {
                controller.chatDelete(item);
              }
            }),
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            padding: EdgeInsets.zero,
            flex: 2,
            icon: Icons.delete,
            label: '删除',
          ),
          SlidableAction(
            onPressed: (context) => controller.chatSetTop(item),
            backgroundColor: Colors.lightGreen,
            foregroundColor: Colors.white,
            padding: EdgeInsets.zero,
            flex: 3,
            icon: Icons.share,
            label: item.getIsTop() ? "取消置顶" : "置顶",
          ),
        ],
      ),
      child: ListTile(
        onTap: () {
          var my = AppData.getUser();
          if (isNotEmpty(my)) {
            Get.toNamed(Routes.CHAT_BY_GROUP,
                arguments: ChatGroupEvent(my!, group, item));
          }
        },
        leading: GroupAvatarWidget(group.portrait ?? []),
        title: Text(
          group.name.em(),
          style: AppTextTheme.headLineStyle1,
        ),
        subtitle: buildLastMessage(msg),
        trailing: Text(DateUtil.formatDateMs(item.lastMessageTime ?? 0),
            style: AppTextTheme.headLineStyle0),
      ),
    );
  }

  Widget buildLastMessage(SocketMsgContent msg) {
    // loggerArray(["没走这里吗",msg.msgType]);
    if (msg.msgType == MessageTypeEnum.TEXT.name) {
      return Text(
        msg.content.em(),
        style: TextStyle(
            color: AppStyles.lightGrey,
            fontSize: AppLayout.fontSize(14),
            fontFamilyFallback: AppTextTheme.fontFamily),
      );
    } else if (msg.msgType == MessageTypeEnum.IMAGE.name) {
      return Text(
        "[图片]",
        style: AppTextTheme.headLineStyle0,
      );
    } else if (msg.msgType == MessageTypeEnum.VOICE.name) {
      return Text(
        "[语音]",
        style: AppTextTheme.headLineStyle0,
      );
    } else if (msg.msgType == MessageTypeEnum.VIDEO.name) {
      return Text(
        "[视频]",
        style: AppTextTheme.headLineStyle0,
      );
    } else if (msg.msgType == MessageTypeEnum.FILE.name) {
      return Text(
        "[文件]",
        style: AppTextTheme.headLineStyle0,
      );
    } else {
      return Container();
    }
  }
}
