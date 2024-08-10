import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rescue_station/app/db/db_helper.dart';
import 'package:rescue_station/app/domains/message_type_enum.dart';
import 'package:rescue_station/app/event/logout_event.dart';
import 'package:rescue_station/app/event/message_read_event.dart';
import 'package:rescue_station/app/event/new_chat_event.dart';
import 'package:rescue_station/app/routes/api_info.dart';
import 'package:rescue_station/app/routes/app_pages.dart';
import 'package:rescue_station/app/socket/socket_notice_entity.dart';
import 'package:rescue_station/app/socket/socket_utils.dart';
import 'package:rescue_station/app/utils/app_data.dart';
import 'package:rescue_station/app/utils/dio_utils.dart';
import 'package:rescue_station/app/utils/logger.dart';
import 'package:rescue_station/app/utils/widget_utils.dart';
import '../contacts_module/contacts_page.dart';
import '../home_module/home_page.dart';
import '../message_module/message_page.dart';
import '../mine_module/mine_page.dart';

class TabsController extends GetxController {
  RxInt currentIndex = 0.obs;
  RxBool isLogin = false.obs;

  var unReadMsg = 0.obs;
  var unReadContact = 0.obs;

  late PageController pageController;
  late List<Widget> pages;
  StreamSubscription? logoutSub;
  StreamSubscription? loginSub;
  StreamSubscription? friendApplySub;
  StreamSubscription? newChatSub;
  StreamSubscription? msgReadSub;

  @override
  void dispose() {
    msgReadSub?.cancel();
    pageController.dispose();
    logoutSub?.cancel();
    loginSub?.cancel();
    friendApplySub?.cancel();
    newChatSub?.cancel();
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
      unReadMsg.value = 0;
      unReadContact.value = 0;
      ///退出登录需设置当前页面在首页上
      setCurrentIndex(0);
    });
    loginSub = eventBus.on<LoginEvent>().listen((v){
      isLogin.value = true;
      findUnReadCount();
    });
    friendApplySub = eventBus.on<SocketNoticeEntity>().listen((event) {
      ///新好友添加申请
      unReadContact.value = (event.msgContent?.friendApply?.count ?? 0) + (event.msgContent?.topicReply?.count ?? 0) ;
    });
    newChatSub = eventBus.on<NewChatEvent>().listen((event) {
      ///有新消息
      findUnReadCount();
    });
    msgReadSub = eventBus.on<MessageReadEvent>().listen((event) {
      ///有新消息
      findUnReadCount();
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
      if(result){ findUnReadCount(); }
    });
  }

  void findUnReadCount() async {
    var user = AppData.getUser();
    if (isNotEmpty(user)) {
      DbHelper().queryMessageBox(user!.userId.em()).then((v) {
        loggerArray(["查询消息列表结果", v, MessageTypeEnum.TEXT.name]);
        var msgCount = 0;
        v.forEach((msg){ msgCount += (msg.unreadCount ?? 0); });
        unReadMsg.value = msgCount;
      });
    }
  }

  void refreshMessage(){
    DioUtil().get(Api.REFRESH,).then((result){
      if(result.data["code"] == 200){
      } else if(result.data["code"] == 401){
        WidgetUtils.logSqueezeOut();
      } else {
        Get.snackbar('提醒', result.data["msg"]);
      }
    }).onError((e,stack){
      Get.snackbar('提醒', "系统异常！");
    });
  }




}
