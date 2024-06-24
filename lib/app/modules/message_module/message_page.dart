import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:gap/gap.dart';
import 'package:getwidget/getwidget.dart';
import 'package:rescue_station/app/domains/message.dart';
import 'package:rescue_station/app/utils/dialog_utils.dart';
import 'package:rescue_station/app/utils/widget_utils.dart';
import '../../routes/app_pages.dart';
import '../../theme/app_text_theme.dart';
import '../../theme/app_colors_theme.dart';
import '../../utils/AppLayout.dart';
import '../../utils/Icon.dart';
import 'message_controller.dart';
import 'package:get/get.dart';

class MessagePage extends GetView<MessageController> {
  const MessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: WidgetUtils.buildSearchAppBar(context,"消息",
          const InkWell(
            // onTap: ()=> showPopWindow(context),
            child: Icon(IconFont.ADD,color: Colors.white),
          ),
        ),
        body: ListView.separated(
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
        ),
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

  Widget buildMessageBox(item) {
    return Slidable(
      key: ValueKey(Random().nextInt(100000)),
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
        onTap: (){
          // Get.toNamed(Routes.CHAT_BY_FRIEND);
        },
        leading: GFAvatar(
          backgroundImage: AssetImage(item.avatar,),
          shape: GFAvatarShape.standard,
          borderRadius: BorderRadius.circular(5.r),
          radius: 25.r,
          child: Align(
            alignment: Alignment.topRight,
            child: GFBadge(
              size: 20.r,
              shape: GFBadgeShape.circle,
            ),
          ),
        ),
        title: Text(item.name,style: AppTextTheme.headLineStyle1,),
        subtitle: Text(item.preview, style: AppTextTheme.headLineStyle0,),
        trailing: Transform.translate(
            offset: Offset(AppLayout.width(18),0),
            child : Text(item.timestamp, style: AppTextTheme.headLineStyle0)
        ),
      ),
    );
  }


}


