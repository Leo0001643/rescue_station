import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:get/get.dart';

class ChatByFriendState {
  ChatByFriendState() {
    ///Initialize variables
  }

  final RxList<types.Message> messages = RxList.empty(growable: true);
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


}
