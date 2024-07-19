import 'package:common_utils/common_utils.dart';
import 'package:get/get.dart';
import 'package:rescue_station/app/db/db_helper.dart';
import 'package:rescue_station/app/event/chat_event.dart';
import 'package:rescue_station/app/event/new_chat_event.dart';
import 'package:rescue_station/app/routes/api_info.dart';
import 'package:rescue_station/app/routes/app_pages.dart';
import 'package:rescue_station/app/socket/socket_message_entity.dart';
import 'package:rescue_station/app/utils/app_data.dart';
import 'package:rescue_station/app/utils/dio_utils.dart';
import 'package:rescue_station/app/utils/widget_utils.dart';
import 'package:rescue_station/generated/json/base/json_convert_content.dart';

import '../../../domains/group_info_entity.dart';
import 'group_list_state.dart';

class GroupListLogic extends GetxController {
  final GroupListState state = GroupListState();

  @override
  void onReady() {
    getGroupAll();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getGroupAll(){
    DioUtil().get(Api.GROUP_LIST).then((result){
      if(result.data["code"] == 200){
        var list = JsonConvert.fromJsonAsT<List<GroupInfoEntity>>(result.data["data"]) ?? [];
        state.data.assignAll(list);
      } else {
        Get.snackbar('提醒', "系统异常！");
      }
    }).onError((e,stack){
      Get.snackbar('提醒', "系统异常！");
    });
  }

  void openChatBox(GroupInfoEntity groupInfo) async {
    var my = AppData.getUser();
    if(isNotEmpty(my)){
      var box = await DbHelper().findMessageBox(my!.userId.em(), groupInfo.groupId.em());
      if(box!=null){
        Get.toNamed(Routes.CHAT_BY_GROUP,arguments: ChatGroupEvent(my, groupInfo, box));
      } else {
        var socketMsg = SocketMessageEntity();
        socketMsg.groupInfo = groupInfo;
        socketMsg.pushType = "MSG";
        socketMsg.boxId = groupInfo.groupId.em();
        socketMsg.createTime = DateUtil.getNowDateStr();
        await DbHelper().messageInsertOrUpdate(true, socketMsg);
        box = await DbHelper().findMessageBox(my.userId.em(), groupInfo.groupId.em());
        ///先存储再发消息通知
        eventBus.fire(NewChatEvent());//有新消息，需要刷新列表
        Get.toNamed(Routes.CHAT_BY_GROUP,arguments: ChatGroupEvent(my, groupInfo, box!));
      }
    }
  }





}
