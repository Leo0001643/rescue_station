import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'chat_by_group_logic.dart';

class ChatByGroupPage extends StatefulWidget {
  const ChatByGroupPage({Key? key}) : super(key: key);

  @override
  State<ChatByGroupPage> createState() => _ChatByGroupPageState();
}

class _ChatByGroupPageState extends State<ChatByGroupPage> {
  final logic = Get.find<ChatByGroupLogic>();
  final state = Get.find<ChatByGroupLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  void dispose() {
    Get.delete<ChatByGroupLogic>();
    super.dispose();
  }
}