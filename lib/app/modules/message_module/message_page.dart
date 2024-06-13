import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:gap/gap.dart';
import 'package:getwidget/getwidget.dart';
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
          InkWell(
            onTap: ()=> showPopWindow(context),
            child: const Icon(IconFont.ADD,color: Colors.white),
          ),
        ),
        body: EasyRefresh.builder(
          header: const MaterialHeader(
            clamping: true,
          ),
          onRefresh: () async {
            print("上拉刷新。。。。。。");
          },
          onLoad: () async {
            print("下拉刷新。。。。。。");
          },
          childBuilder: (context, physics) {
            return NestedScrollView(
              physics: physics,
              body: _message(physics),
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                return const [/*SliverAppBar(title: Text("导航测试"),)*/];
              },
            );
          },
        )
    );
  }


  Widget _message(ScrollPhysics physics){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: ListView.separated(
            physics: physics,
            itemCount: controller.messages.length,
            separatorBuilder: (context, index) {
              return Padding(
                  padding: EdgeInsets.only(left: AppLayout.width(80)),
                  child: Divider(height: AppLayout.heigth(0),color: AppStyles.lightGreyWile)
              );
            },
            itemBuilder: (context, index) {
              return Slidable(
                key: ValueKey(index),
                endActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  dismissible: DismissiblePane(onDismissed: () {}),
                  children: [
                    SlidableAction(
                      onPressed: doNothing,
                      backgroundColor: const Color(0xFFFE4A49),
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: '删除',
                    ),
                    SlidableAction(
                      onPressed: doNothing,
                      backgroundColor: Colors.lightGreen,
                      foregroundColor: Colors.white,
                      icon: Icons.share,
                      label: '置顶',
                    ),
                  ],
                ),
                child: ListTile(
                  onTap: (){
                    Get.toNamed(Routes.CHAT_BY_FRIEND);
                  },
                  leading: GFAvatar(
                    backgroundImage: AssetImage(controller.messages[index].avatar,),
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
                  title: Text(controller.messages[index].name,style: AppTextTheme.headLineStyle1,),
                  subtitle: Text(controller.messages[index].preview, style: AppTextTheme.headLineStyle0,),
                  trailing: Transform.translate(
                      offset: Offset(AppLayout.width(18),0),
                      child : Text(controller.messages[index].timestamp, style: AppTextTheme.headLineStyle0)
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void doNothing(BuildContext context) {

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


