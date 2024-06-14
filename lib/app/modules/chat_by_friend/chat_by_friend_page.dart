
import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/src/user.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:rescue_station/app/modules/chat_by_friend/bottom_emoji_widget.dart';
import 'package:rescue_station/app/modules/chat_by_friend/bottom_more_widget.dart';
import 'package:rescue_station/app/theme/app_colors.dart';
import 'package:rescue_station/app/utils/widget_utils.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import 'chat_by_friend_logic.dart';

class ChatByFriendPage extends StatefulWidget {
  const ChatByFriendPage({Key? key}) : super(key: key);

  @override
  State<ChatByFriendPage> createState() => _ChatByFriendPageState();
}

class _ChatByFriendPageState extends State<ChatByFriendPage> {
  final logic = Get.find<ChatByFriendLogic>();
  final state = Get.find<ChatByFriendLogic>().state;
  final textController = TextEditingController();
  final keyboardVisibilityController = KeyboardVisibilityController();
  final inputFocusNode = FocusNode();

  @override
  void initState() {
    keyboardVisibilityController.onChange.listen((visible){
      if(visible){///当虚拟键盘显示需要隐藏表情和更多
        state.moreVisible.value = false;
        state.emojiVisible.value = false;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetUtils.buildAppBar("上官婉儿"),
      body: KeyboardVisibilityProvider(
        controller: keyboardVisibilityController,
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
            onSendPressed: (text)=> logic.sendMessage(text.text),
            // onMessageTap: (context, message) => logic.addMessage(),
            user: state.user,
            showUserAvatars: true,
            bubbleBuilder: buildBubble,
            avatarBuilder: buildAvatar,
            emojiEnlargementBehavior: EmojiEnlargementBehavior.never,
            customBottomWidget: buildBottomWidget(),
            onBackgroundTap: (){
              FocusScope.of(context).unfocus();
              state.moreVisible.value = false;
              state.emojiVisible.value = false;
            },
            // textMessageBuilder: buildTextMessage,
          );
        }),
      ),
    );
  }

  @override
  void dispose() {
    inputFocusNode.dispose();
    textController.dispose();
    Get.delete<ChatByFriendLogic>();
    super.dispose();
  }

  Widget buildBubble(child, {required message,required nextMessageInGroup}) {
    if(message.author.id == state.user.id){
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
              margin: BubbleEdges.all(0),
              padding: BubbleEdges.all(0),
              child: child,
            ),
          ),
          SizedBox(width: 10.w,),
          buildAvatar(state.user),
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
        padding: BubbleEdges.all(0),
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
    if(message.author.id == state.user.id){
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

  Widget buildBottomWidget() {
    return Container(
      color: color_d2d,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  margin: EdgeInsets.all(15.r),
                  child: TextField(
                    maxLines: 10,
                    minLines: 1,
                    controller: textController,
                    textInputAction: TextInputAction.send,
                    focusNode: inputFocusNode,
                    onSubmitted: (text){
                      ///防止自动隐藏虚拟键盘
                      inputFocusNode.requestFocus();
                      logic.sendMessage(text);
                      textController.clear();
                    },
                    style: TextStyle(fontSize: 16.sp,color: Colors.black,fontWeight: FontWeight.w600),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 15.h),
                      isCollapsed: true,
                      border: InputBorder.none,
                      errorBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                  ),
                ),
              ),
              InkWell(
                child: Icon(Icons.emoji_emotions_outlined,size: 40.r,color: color_333,),
                onTap: (){
                  if(keyboardVisibilityController.isVisible){
                    FocusScope.of(context).unfocus();
                  }
                  if(state.moreVisible.value){
                    state.moreVisible.value = false;
                  }
                  state.emojiVisible.value = !state.emojiVisible.value;
                },
              ),
              SizedBox(width: 5.w,),
              Offstage(
                offstage: state.emojiVisible.value,
                child: InkWell(
                  child: Icon(Icons.add_circle_outline_outlined,size: 40.r,color: color_333,),
                  onTap: (){
                    if(keyboardVisibilityController.isVisible){
                      FocusScope.of(context).unfocus();
                    }
                    if(state.emojiVisible.value){
                      state.emojiVisible.value = false;
                    }
                    state.moreVisible.value = !state.moreVisible.value;
                  },
                ),
              ),
              Offstage(
                offstage: !state.emojiVisible.value,
                child: WidgetUtils.buildElevatedButton("发送", 60.w, 40.h, bg: color_703,onPressed: (){
                  logic.sendMessage(textController.text);
                  textController.clear();
                }),
              ),
              SizedBox(width: 5.w,),
            ],
          ),
          Obx(() {
            return Visibility(
              visible: state.emojiVisible.value || state.moreVisible.value,
              child: Container(
                color: Colors.white,
                height: 1.h,
                width: 1.sw,
              ),
            );
          }),
          SizedBox(height: 5.h,),
          Obx(() {
            return Offstage(
              offstage: !state.moreVisible.value,
              child: BottomMoreWidget(),
            );
          }),
          Obx(() {
            return Offstage(
              offstage: !state.emojiVisible.value,
              child: BottomEmojiWidget(textController),
            );
          }),
        ],
      ),
    );
  }


}