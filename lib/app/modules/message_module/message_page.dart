import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:gap/gap.dart';
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
        appBar: _appBar(context),
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

  PreferredSizeWidget _appBar(BuildContext context){
    return AppBar(
        toolbarHeight: AppLayout.heigth(120),
        backgroundColor: const Color.fromRGBO(112, 50, 255, 1),
        title: SizedBox(
          child:Column(
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Center(
                        child: Padding(
                            padding: EdgeInsets.only(left: AppLayout.width(50)),
                            child: Text("消息", style: TextStyle(color: Colors.white, fontSize: AppLayout.fontSize(20),fontWeight: FontWeight.w500))
                        ))),
                    IconButton(
                      onPressed: (){
                        showMenu(
                            context: context,
                            color: AppStyles.lightGrey,
                            position: RelativeRect.fromLTRB(AppLayout.width(600), AppLayout.heigth(108), 0, 0),
                            items:<PopupMenuEntry> [
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
                            ]
                        );
                      },
                      icon: const Icon(IconFont.ADD,color: Colors.white)),
                  ]
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                    maxHeight: AppLayout.heigth(42),
                    maxWidth: double.infinity
                ),
                child: TextField(
                  textAlign: TextAlign.start,
                  // keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(AppLayout.heigth(0)),
                    prefixIcon: const Icon(Icons.search,),
                    hintText: '搜索',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              )
            ],
          ),
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
                  leading: Stack(
                    children: [
                      // CircleAvatar(
                      //   backgroundImage: AssetImage(controller.messages[index].avatar),
                      // ),
                      Container(
                        clipBehavior: Clip.hardEdge,
                        width: AppLayout.width(48),height: AppLayout.width(48),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(AppLayout.width(5))),
                        child: Image.asset(controller.messages[index].avatar, fit: BoxFit.cover),
                      ),
                      Positioned(
                        left: AppLayout.heigth(38),
                        top: AppLayout.heigth(0),
                        right: AppLayout.heigth(0),
                        child: CircleAvatar(
                          radius: AppLayout.heigth(5),
                          backgroundColor: Colors.red,
                        ),
                      ),
                    ],
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

  void doNothing(BuildContext context) {}
}


