import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:rescue_station/app/domains/user_info_entity.dart';
import 'package:rescue_station/app/domains/group_info_entity.dart';
import 'package:rescue_station/app/utils/widget_utils.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:easy_image_viewer/easy_image_viewer.dart' as eiv;

class BottomChatController extends GetxController {
  final textController = TextEditingController();
  final keyboardVisibilityController = KeyboardVisibilityController();
  final inputFocusNode = FocusNode();

  UserInfoEntity user = UserInfoEntity();

  UserInfoEntity friend = UserInfoEntity();
  GroupInfoEntity group = GroupInfoEntity();

  ///表情是否可见
  var emojiVisible = false.obs;

  ///更多是否可见
  var moreVisible = false.obs;
  ///被回复的消息体
  Rx<types.Message?> replyMessage = Rx<types.Message?>(null);


  void showImageViewer(BuildContext context,String path){
    eiv.showImageViewer(context, WidgetUtils.buildImageProvider(path));
  }




}
