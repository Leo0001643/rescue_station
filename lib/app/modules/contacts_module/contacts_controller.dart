import 'dart:async';

import 'package:common_utils/common_utils.dart';
import 'package:get/get.dart';
import 'package:rescue_station/app/db/db_helper.dart';
import 'package:rescue_station/app/event/friend_delete_event.dart';
import 'package:rescue_station/app/db/user_info_table.dart';
import 'package:rescue_station/app/routes/api_info.dart';
import 'package:rescue_station/app/routes/app_pages.dart';
import 'package:rescue_station/app/utils/dio_utils.dart';
import 'package:rescue_station/app/utils/shared_preferences_util.dart';

class ContactsController extends GetxController{
  var contacts = RxList<UserInfoTable>.empty(growable: true);
  var filteredContacts = RxList<UserInfoTable>.empty(growable: true);
  var searchText = ''.obs;
  StreamSubscription? friendDelSub;

  @override
  void onInit() {
    super.onInit();
    friendDelSub = eventBus.on<FriendDeleteEvent>().listen((event) {
      getContactsAll();///联系人被删除，需要刷新通讯录列表
    });
    ///如果已经登录了，有token
    DbHelper().getUser().then((user){
      if(ObjectUtil.isNotEmpty(user)){
        getContactsAll();
      }
    });

  }

  @override
  void onClose() {
    friendDelSub?.cancel();
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

  void deleteContact(UserInfoTable contact) {
    // contacts.remove(contact);
    // filterContacts(searchText.value);  // Ensure the filtered list is updated
    // Get.snackbar('删除', '$contact 已删除');
  }

  void getContactsAll(){
    DioUtil().post(Api.FRIEND_LIST,data: {"params":""}).then((result){
      if(result.data["code"] == 200){
        contacts.value = JsonUtil.getObjList(JsonUtil.encodeObj(result.data["data"]), (map)=> UserInfoTable.fromJson(map as Map<String,dynamic>)) ?? [];
        filteredContacts.value = JsonUtil.getObjList(JsonUtil.encodeObj(result.data["data"]), (map)=> UserInfoTable.fromJson(map as Map<String,dynamic>)) ?? [];
      } else {
        Get.snackbar('联系人提醒', "系统异常！");
      }
    }).onError((e,stack){
      Get.snackbar('联系人提醒', "系统异常！");
    });
  }









}
