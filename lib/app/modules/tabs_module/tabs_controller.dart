import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rescue_station/app/modules/customer_service_module/customer_service_controller.dart';
import 'package:rescue_station/app/modules/mine_module/mine_controller.dart';
import 'package:rescue_station/app/modules/tabs_module/tabs_pages.dart';
import '../../routes/app_pages.dart';
import '../contacts_module/contacts_controller.dart';
import '../home_module/home_controller.dart';
import '../login_module/login_page.dart';
import '../message_module/message_controller.dart';
import '../message_module/message_page.dart';
import '../home_module/home_page.dart';
import '../contacts_module/contacts_page.dart';
import '../customer_service_module/customer_service_page.dart';
import '../mine_module/mine_page.dart';

class TabsController extends GetxController {
  RxInt currentIndex = 0.obs;
  RxBool isLogin = false.obs;
  late PageController pageController;

  final List<Widget> pages = [
    const HomePage(),
    const MessagePage(),
    const ContactsPage(),
    const CustomerServicePage(),
    const MinePage()
  ];


  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(initialPage: currentIndex.value);
    Get.put(HomeController());
    Get.put(MessageController());
    Get.put(ContactsController());
    Get.put(CustomerServiceController());
    Get.put(MineController());
  }

  void setCurrentIndex(int index) {
    currentIndex.value = index;
    pageController.jumpToPage(index);
  }

  void navigateToLogin() {
    Get.to(() => LoginPage())?.then((_) {
      if (isLogin.value) {
        setCurrentIndex(currentIndex.value); // 保持当前页
      } else {
        setCurrentIndex(0); // 登录失败返回首页
      }
      Get.offAll(() => const TabsPage());
    });
  }

  void checkLoginStatus(isLogin){
    isLogin.value = isLogin;
    update();
  }
}
