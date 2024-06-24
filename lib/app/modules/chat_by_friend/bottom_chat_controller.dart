
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:rescue_station/app/db/user_info_table.dart';
import 'package:rescue_station/app/utils/widget_utils.dart';

class BottomChatController extends GetxController {

  final textController = TextEditingController();
  final keyboardVisibilityController = KeyboardVisibilityController();
  final inputFocusNode = FocusNode();

  late UserInfoTable user;
  late UserInfoTable friend;

  ///表情是否可见
  var emojiVisible = false.obs;
  ///更多是否可见
  var moreVisible = false.obs;


}

