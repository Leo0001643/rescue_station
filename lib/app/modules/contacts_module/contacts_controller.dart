import 'dart:async';
import 'dart:convert';

import 'package:common_utils/common_utils.dart';
import 'package:get/get.dart';
import 'package:rescue_station/app/db/db_helper.dart';
import 'package:rescue_station/app/event/friend_delete_event.dart';
import 'package:rescue_station/app/domains/user_info_entity.dart';
import 'package:rescue_station/app/event/logout_event.dart';
import 'package:rescue_station/app/routes/api_info.dart';
import 'package:rescue_station/app/routes/app_pages.dart';
import 'package:rescue_station/app/socket/socket_notice_entity.dart';
import 'package:rescue_station/app/utils/app_data.dart';
import 'package:rescue_station/app/utils/dio_utils.dart';
import 'package:rescue_station/app/utils/logger.dart';
import 'package:rescue_station/app/utils/shared_preferences_util.dart';
import 'package:rescue_station/generated/json/base/json_convert_content.dart';

class ContactsController extends GetxController{
  var contacts = RxList<UserInfoEntity>.empty(growable: true);
  var filteredContacts = RxList<UserInfoEntity>.empty(growable: true);
  var searchText = ''.obs;
  var applyCount = 0.obs;
  StreamSubscription? friendDelSub;
  StreamSubscription? friendApplySub;
  StreamSubscription? loginSub;
  StreamSubscription? logoutSub;

  @override
  void onReady() {
    friendDelSub = eventBus.on<FriendDeleteEvent>().listen((event) {
      ///联系人被删除，需要刷新通讯录列表
      var user = AppData.getUser();
      if(ObjectUtil.isNotEmpty(user)){
        getContactsAll(user!);
      }
    });
    friendApplySub = eventBus.on<SocketNoticeEntity>().listen((event) {
      ///新好友添加申请
      applyCount.value = event.msgContent?.friendApply?.count ?? 0;
    });
    loginSub = eventBus.on<LoginEvent>().listen((event) {
      ///登录成功
      var user = AppData.getUser();
      if(ObjectUtil.isNotEmpty(user)){
        getContactsAll(user!);
      }
    });
    logoutSub = eventBus.on<LogoutEvent>().listen((v){
      ///退出登录
      applyCount.value = 0;
    });
    ///如果已经登录了，有token
    var user = AppData.getUser();
    if(ObjectUtil.isNotEmpty(user)){
      getContactsAll(user!);
    }
    super.onReady();
  }

  @override
  void onClose() {
    friendDelSub?.cancel();
    friendApplySub?.cancel();
    loginSub?.cancel();
    logoutSub?.cancel();
    super.onClose();
  }

  ///搜索过滤
  void filterContacts(String query) {
    // searchText.value = query;
    if (query.isEmpty) {
      filteredContacts.assignAll(contacts);
    } else {
      filteredContacts.assignAll(
          contacts.where((contact) => contact.nickName?.contains(query) == true).toList()
      );
    }
  }

  void deleteContact(UserInfoEntity contact) {
    // contacts.remove(contact);
    // filterContacts(searchText.value);  // Ensure the filtered list is updated
    // Get.snackbar('删除', '$contact 已删除');
  }

  void getContactsAll(UserInfoEntity user){
    DioUtil().post(Api.FRIEND_LIST,data: {"params":""}).then((result){
      if(result.data["code"] == 200){
        var data = JsonConvert.fromJsonAsT<List<UserInfoEntity>>(result.data["data"]) ?? [];
        contacts.value = data.where((v)=> v.userId != user.userId).toList(growable: true);
        List<UserInfoEntity> data1 = JsonConvert.fromJsonAsT<List<UserInfoEntity>>(result.data["data"]) ?? [];
        filteredContacts.value = data1.where((v)=> v.userId != user.userId).toList(growable: true);
      } else {
        Get.snackbar('联系人提醒', "系统异常！");
      }
    }).onError((e,stack){
      Get.snackbar('联系人提醒', "系统异常！");
    });
  }









}
