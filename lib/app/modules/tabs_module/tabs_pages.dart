import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'tabs_controller.dart';
import '../../utils/Icon.dart';

class TabsPage extends GetView<TabsController> {
  const TabsPage({super.key});
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
                controller.setCurrentIndex(index);
                controller.pageController.jumpToPage(index);
              },
              items: const [
                BottomNavigationBarItem(icon: Icon(IconFont.HOME), label: "首页"),
                BottomNavigationBarItem(icon: Icon(IconFont.MESSAGE), label: "消息"),
                BottomNavigationBarItem(icon: Icon(IconFont.CONTACTS), label: "通讯录"),
                BottomNavigationBarItem(icon: Icon(IconFont.CUSTOMER), label: "客服"),
                BottomNavigationBarItem(icon: Icon(IconFont.MINE), label: "我的")
              ]),
        ));
  }
}
