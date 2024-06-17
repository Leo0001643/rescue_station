import 'dart:convert';
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:rescue_station/app/utils/widget_utils.dart';

class BottomChatController extends GetxController {

  final textController = TextEditingController();
  final keyboardVisibilityController = KeyboardVisibilityController();
  final inputFocusNode = FocusNode();

  final user = types.User(
    id: '82091008-a484-4a89-ae75-a22bf8d6f3ac',
    imageUrl: 'https://img2.baidu.com/it/u=4282156618,2296457704&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=707',
  );

  final friend = types.User(
    id: '82091008-a484-4a89-wm32-a22bf8d6f3ac',
    imageUrl: 'https://img2.baidu.com/it/u=4282156618,2296457704&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=707',
  );

  ///表情是否可见
  var emojiVisible = false.obs;
  ///更多是否可见
  var moreVisible = false.obs;


  Message buildUserText(String text){
    return types.TextMessage(
      author: user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      text: text,
    );
  }

  Message buildFriendText(String text){
    return types.TextMessage(
      author: friend,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      text: text,
    );
  }

  Message buildUserImage(PlatformFile image){
    return types.ImageMessage(
      author: user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      uri: image.path.em(),
      size: image.size,
      name: image.name,
    );
  }

  Message buildUserFile(PlatformFile image){
    return types.FileMessage(
      author: user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      uri: image.path.em(),
      size: image.size,
      name: image.name,
    );
  }

  // For the testing purposes, you should probably use https://pub.dev/packages/uuid.
  String randomString() {
    final random = Random.secure();
    final values = List<int>.generate(16, (i) => random.nextInt(255));
    return base64UrlEncode(values);
  }


}

