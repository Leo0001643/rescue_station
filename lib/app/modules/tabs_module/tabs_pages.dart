import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:lifecycle/lifecycle.dart';
import 'package:rescue_station/app/socket/socket_utils_bak.dart';
import 'package:rescue_station/app/utils/audio_utils.dart';
import 'package:rescue_station/app/utils/logger.dart';
import 'tabs_controller.dart';
import '../../utils/Icon.dart';

class TabsPage extends StatefulWidget {
  const TabsPage({super.key});

  @override
  State<StatefulWidget> createState() =>StateTabsPage();

}

class StateTabsPage extends State<TabsPage>  with LifecycleAware, LifecycleMixin {
  final controller = Get.find<TabsController>();

  @override
  void onLifecycleEvent(LifecycleEvent event) {
    loggerArray(["生命周期变化了",event]);
    switch (event) {
      case LifecycleEvent.visible:
      ///播放音乐
        AudioUtils().appForeground = true;
        if(controller.isLogin.value){
          controller.refreshMessage();
        }
        break;
      case LifecycleEvent.invisible:
        AudioUtils().appForeground = false;
        break;
      default:
        break;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      body: PageView(
        controller: controller.pageController,
        physics: const NeverScrollableScrollPhysics(), //禁止左右滑动
        children: controller.pages,
        onPageChanged: (index) {
          controller.setCurrentIndex(index);
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
          fixedColor: Colors.deepPurpleAccent,
          currentIndex: controller.currentIndex.value,
          type:BottomNavigationBarType.fixed,
          onTap: (index) {
            if ((index == 1 || index == 2 || index == 3) && !controller.isLogin.value) {
              controller.navigateToLogin();
            } else {
              controller.setCurrentIndex(index);
            }
          },
          items: [
            BottomNavigationBarItem(icon: Icon(IconFont.HOME), label: "首页"),
            BottomNavigationBarItem(
              label: "消息",
              icon: Container(
                width: 50.w,
                child: Stack(
                  children: [
                    Center(child: Icon(IconFont.MESSAGE),),
                    Obx(() {
                      return Visibility(
                        visible: controller.unReadMsg > 0,
                        child: Align(
                          alignment: Alignment.topRight,
                          child: GFBadge(
                            text: "${controller.unReadMsg.value}",
                            size: 20.sp,
                            shape: GFBadgeShape.circle,
                            border: BorderSide.none,
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
            BottomNavigationBarItem(
              label: "通讯录",
              icon: Container(
                width: 50.w,
                child: Stack(
                  children: [
                    Center(child: Icon(IconFont.CONTACTS),),
                    Obx(() {
                      return Visibility(
                        visible: controller.unReadContact > 0,
                        child: Align(
                          alignment: Alignment.topRight,
                          child: GFBadge(
                            text: "${controller.unReadContact.value}",
                            size: 20.sp,
                            shape: GFBadgeShape.circle,
                            border: BorderSide.none,
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
            BottomNavigationBarItem(icon: Icon(IconFont.MINE), label: "我的")
          ]),
    ));
  }
}

