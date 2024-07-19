import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lifecycle/lifecycle.dart';
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
            if ((index == 1 || index == 2 || index == 4) && !controller.isLogin.value) {
              controller.navigateToLogin();
            } else {
              controller.setCurrentIndex(index);
            }
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(IconFont.HOME), label: "首页"),
            BottomNavigationBarItem(icon: Icon(IconFont.MESSAGE), label: "消息"),
            BottomNavigationBarItem(icon: Icon(IconFont.CONTACTS), label: "通讯录"),
            BottomNavigationBarItem(icon: Icon(IconFont.MINE), label: "我的")
          ]),
    ));
  }








}

