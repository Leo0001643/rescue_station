
import 'dart:convert';
import 'dart:math';

import 'package:get/get.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'chat_by_friend_state.dart';

class ChatByFriendLogic extends GetxController {
  final ChatByFriendState state = ChatByFriendState();

  @override
  void onReady() {
    ///延时添加消息
    Future.delayed(Duration(seconds: 1),(){
      addMessage();
    });
    Future.delayed(Duration(seconds: 2),(){
      sendMessage("红红火火恍恍惚惚哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈");
    });
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void sendMessage(String text){
    final textMessage = types.TextMessage(
      author: state.user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      text: text,
    );
    state.messages.insert(0, textMessage);
  }

  void addMessage(){
    final textMessage = types.TextMessage(
      author: state.friend,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      text: "嗯嗯",
    );
    state.messages.insert(0, textMessage);
  }


  // For the testing purposes, you should probably use https://pub.dev/packages/uuid.
  String randomString() {
    final random = Random.secure();
    final values = List<int>.generate(16, (i) => random.nextInt(255));
    return base64UrlEncode(values);
  }


}
