
import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/src/user.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:rescue_station/app/modules/chat_by_friend/bottom_chat_controller.dart';
import 'package:rescue_station/app/modules/chat_by_friend/bottom_chat_widget.dart';
import 'package:rescue_station/app/modules/chat_by_friend/bottom_emoji_widget.dart';
import 'package:rescue_station/app/modules/chat_by_friend/bottom_more_widget.dart';
import 'package:rescue_station/app/theme/app_colors.dart';
import 'package:rescue_station/app/utils/widget_utils.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import 'chat_by_friend_logic.dart';

class ChatByFriendPage extends StatefulWidget {
  const ChatByFriendPage({super.key});

  @override
  State<ChatByFriendPage> createState() => _ChatByFriendPageState();
}

class _ChatByFriendPageState extends State<ChatByFriendPage> {
  final logic = Get.find<ChatByFriendLogic>();
  final chatCtl = Get.find<BottomChatController>();
  final state = Get.find<ChatByFriendLogic>().state;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetUtils.buildAppBar("上官婉儿"),
      body: KeyboardVisibilityProvider(
        controller: chatCtl.keyboardVisibilityController,
        child: Obx(() {
          return Chat(
            theme: DefaultChatTheme(
              backgroundColor: Colors.black12,
              receivedMessageBodyTextStyle: TextStyle(fontSize: 16.sp,color: Colors.black),
              sentMessageBodyTextStyle: TextStyle(fontSize: 16.sp,color: Colors.black),
              messageInsetsHorizontal: 12.r,
              messageInsetsVertical: 12.r,
              messageMaxWidth: 1.sw,
            ),
            l10n: const ChatL10nZhCN(),
            messages: state.messages.value,
            onSendPressed: (text){},
            // onMessageTap: (context, message) => logic.addMessage(),
            user: chatCtl.user,
            showUserAvatars: true,
            bubbleBuilder: buildBubble,
            avatarBuilder: buildAvatar,
            emojiEnlargementBehavior: EmojiEnlargementBehavior.never,
            customBottomWidget: BottomChatWidget((msg)=> logic.sendMessage(msg)),
            onBackgroundTap: (){
              FocusScope.of(context).unfocus();
              chatCtl.moreVisible.value = false;
              chatCtl.emojiVisible.value = false;
            },
            // textMessageBuilder: buildTextMessage,
          );
        }),
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<ChatByFriendLogic>();
    super.dispose();
  }

  Widget buildBubble(child, {required message,required nextMessageInGroup}) {
    if(message.author.id == chatCtl.user.id){
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 260.w),
            child: Bubble(
              nip: BubbleNip.rightCenter,
              nipOffset: -10,
              alignment: Alignment.bottomRight,
              color: color_65d,
              elevation: 0,
              margin: const BubbleEdges.all(0),
              padding: const BubbleEdges.all(0),
              child: child,
            ),
          ),
          SizedBox(width: 10.w,),
          buildAvatar(chatCtl.user),
        ],
      );
    } else {
      return Bubble(
        nip: BubbleNip.leftCenter,
        nipOffset: -10,
        alignment: Alignment.bottomLeft,
        color: Colors.white,
        elevation: 0,
        margin: BubbleEdges.only(left: 10.w),
        padding: const BubbleEdges.all(0),
        child: child,
      );
    }
  }

  Widget buildAvatar(User author) {
    return GFAvatar(
      radius: 30.r,
      shape: GFAvatarShape.standard,
      borderRadius: BorderRadius.circular(5.r),
      backgroundImage: NetworkImage(author.imageUrl.em()),
    );
  }

  Widget buildTextMessage(types.TextMessage message, {required int messageWidth, required bool showName}) {
    if(message.author.id == chatCtl.user.id){
      return Container(
        margin: EdgeInsets.all(12.r),
        child: TextMessageText(bodyTextStyle: TextStyle(fontSize: 16.sp,color: Colors.black), text: message.text),
      );
    } else {
      return Container(
        margin: EdgeInsets.all(12.r),
        child: TextMessageText(bodyTextStyle: TextStyle(fontSize: 16.sp,color: Colors.black), text: message.text),
      );
    }
  }



}