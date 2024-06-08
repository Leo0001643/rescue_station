import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../message_module/message_page.dart';
import '../home_module/home_page.dart';
import '../contacts_module/contacts_page.dart';
import '../customer_service_module/customer_service_page.dart';
import '../mine_module/mine_page.dart';

class TabsController extends GetxController {
  RxInt currentIndex = 0.obs;
  PageController pageController=PageController(initialPage:0);

  final List<Widget> pages = [
    HomePage(),
    MessagePage(),
    ContactsPage(),
    CustomerServicePage(),
    MinePage()
  ];

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void setCurrentIndex(index) {
    currentIndex.value = index;
    update();
  }
}
