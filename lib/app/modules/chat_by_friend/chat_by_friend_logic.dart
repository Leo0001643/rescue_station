
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:get/get.dart';
import 'chat_by_friend_state.dart';

class ChatByFriendLogic extends GetxController {
  final ChatByFriendState state = ChatByFriendState();

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void sendMessage(Message msg){
    state.messages.insert(0, msg);
  }

}
