import 'dart:async';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rescue_station/app/event/logout_event.dart';
import 'package:rescue_station/app/routes/app_pages.dart';
import 'package:rescue_station/app/socket/socket_utils.dart';
import 'package:rescue_station/app/utils/app_data.dart';
import 'package:rescue_station/app/utils/logger.dart';

import '../contacts_module/contacts_page.dart';
import '../home_module/home_page.dart';
import '../message_module/message_page.dart';
import '../mine_module/mine_page.dart';

class TabsController extends GetxController {
  RxInt currentIndex = 0.obs;
  RxBool isLogin = false.obs;
  late PageController pageController;
  late List<Widget> pages;
  StreamSubscription? logoutSub;
  StreamSubscription? loginSub;

  @override
  void dispose() {
    pageController.dispose();
    logoutSub?.cancel();
    loginSub?.cancel();
    super.dispose();
  }

  @override
  void onInit() {
    pageController = PageController(initialPage: currentIndex.value);
    pages = [
      HomePage(),
      MessagePage(),
      ContactsPage(),
      MinePage()
    ];

    super.onInit();
  }

  @override
  void onReady() {
    ifLoginInit();
    logoutSub = eventBus.on<LogoutEvent>().listen((v){
      isLogin.value = false;
    });
    loginSub = eventBus.on<LoginEvent>().listen((v){
      isLogin.value = true;
    });
    super.onReady();
  }

  void setCurrentIndex(int index) {
    currentIndex.value = index;
    pageController.jumpToPage(index);
  }

  void navigateToLogin() {
    Get.toNamed(Routes.LOGIN)?.then((result) {
      if (result == true) {
        setCurrentIndex(currentIndex.value); // 保持当前页
        ifLoginInit();
      } else {
        setCurrentIndex(0); // 登录失败返回首页
      }
      Get.until((ModalRoute.withName(Routes.TABS)));
    });
  }

  void checkLoginStatus(isLogin){
    isLogin.value = isLogin;
    update();
  }

  void ifLoginInit() {
    ///如果已经登录了，有token
    SocketUtils().connect(callback: (result){
      loggerArray(["连接结果",result]);
      isLogin.value = result;
    });
  }



}
