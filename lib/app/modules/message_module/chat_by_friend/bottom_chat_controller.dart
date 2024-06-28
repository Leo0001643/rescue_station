
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:rescue_station/app/domains/user_info_entity.dart';
import 'package:rescue_station/app/domains/group_info_entity.dart';
import 'package:rescue_station/app/utils/widget_utils.dart';

class BottomChatController extends GetxController {

  final textController = TextEditingController();
  final keyboardVisibilityController = KeyboardVisibilityController();
  final inputFocusNode = FocusNode();

  late UserInfoEntity user;
  late UserInfoEntity friend;
  late GroupInfoEntity group;

  ///表情是否可见
  var emojiVisible = false.obs;
  ///更多是否可见
  var moreVisible = false.obs;


}

