import 'package:bubble/bubble.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:rescue_station/app/domains/item_model.dart';
import 'package:rescue_station/app/event/chat_event.dart';
import 'package:rescue_station/app/routes/app_pages.dart';
import 'package:rescue_station/app/theme/app_colors.dart';
import 'package:rescue_station/app/theme/app_text_theme.dart';
import 'package:rescue_station/app/utils/widget_utils.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import '../../../constant/constant.dart';
import '../chat_by_friend/bottom_chat_controller.dart';
import '../chat_by_friend/bottom_chat_widget.dart';
import 'chat_by_group_logic.dart';

class ChatByGroupPage extends StatefulWidget {
  const ChatByGroupPage({Key? key}) : super(key: key);

  @override
  State<ChatByGroupPage> createState() => _ChatByGroupPageState();
}

class _ChatByGroupPageState extends State<ChatByGroupPage> {
  final logic = Get.find<ChatByGroupLogic>();
  final chatCtl = Get.find<BottomChatController>();
  final state = Get.find<ChatByGroupLogic>().state;

  @override
  void initState() {
    if (Get.arguments == null) {
      Get.back();
      return;
    }
    ChatGroupEvent event = Get.arguments;
    state.chatEvent = event;
    chatCtl.group = event.group;
    chatCtl.user = event.user;
    logic.queryChatMessage();
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<ChatByGroupLogic>();
    Get.delete<BottomChatController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (chatCtl.user.userId == null) {
      return Container();
    }
    return Scaffold(
      appBar: WidgetUtils.buildAppBar(chatCtl.group.name.em(), actions: [
        IconButton(
          icon: Icon(
            Icons.more_vert_outlined,
            size: 30.r,
          ),
          onPressed: () =>
              Get.toNamed(Routes.CHAT_GROUP_DETAIL, arguments: state.chatEvent),
        ),
      ]),
      backgroundColor: Colors.white,
      body: KeyboardVisibilityProvider(
        controller: chatCtl.keyboardVisibilityController,
        child: Obx(() {
          return Chat(
            theme: DefaultChatTheme(
              backgroundColor: Colors.black12,
              receivedMessageBodyTextStyle:
                  TextStyle(fontSize: 16.sp, color: Colors.black),
              sentMessageBodyTextStyle:
                  TextStyle(fontSize: 16.sp, color: Colors.black),
              messageInsetsHorizontal: 12.r,
              messageInsetsVertical: 12.r,
              messageMaxWidth: 1.sw,
            ),
            l10n: const ChatL10nZhCN(),
            messages: state.messages.value,
            onSendPressed: (text) {},
            // onMessageTap: (context, message) => logic.addMessage(),
            textMessageBuilder: buildTextMessage,
            user: types.User(
                id: chatCtl.user.userId.em(),
                imageUrl: chatCtl.user.portrait.em()),
            showUserAvatars: false,
            showUserNames: false,
            dateLocale: Constant.locale.toString(),
            bubbleBuilder: buildBubble,
            avatarBuilder: (user) => buildAvatar(user.imageUrl.em()),
            emojiEnlargementBehavior: EmojiEnlargementBehavior.never,
            customBottomWidget:
                BottomChatWidget((msg) => logic.sendMessage(msg)),
            onBackgroundTap: () {
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

  Widget buildBubble(child, {required message, required nextMessageInGroup}) {
    if (message.author.id == chatCtl.user.userId) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 230.w),
            child: message is types.ImageMessage
                ? buildPopChild(child,message)
                : Bubble(
                    nip: GetPlatform.isWeb ? BubbleNip.no:BubbleNip.rightCenter,
                    nipOffset: -10,
                    alignment: Alignment.bottomRight,
                    color: color_65d,
                    elevation: 0,
                    margin: const BubbleEdges.all(0),
                    padding: const BubbleEdges.all(0),
                    child: buildPopChild(child,message),
                  ),
          ),
          SizedBox(
            width: 10.w,
          ),
          buildAvatar(chatCtl.user.portrait.em()),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          buildAvatar(chatCtl.user.portrait.em()),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 230.w),
            child: message is types.ImageMessage
                ? Padding(
                    padding: EdgeInsets.only(left: 10.w),
                    child: buildPopChild(child,message),
                  )
                : Bubble(
                    nip: GetPlatform.isWeb ? BubbleNip.no:BubbleNip.leftCenter,
                    nipOffset: -10,
                    alignment: Alignment.bottomLeft,
                    color: Colors.white,
                    elevation: 0,
                    margin: BubbleEdges.only(left: 10.w),
                    padding: const BubbleEdges.all(0),
                    child: buildPopChild(child,message),
                  ),
          ),
        ],
      );
    }
  }

  Widget buildAvatar(String image) {
    return GFAvatar(
      radius: 25.r,
      shape: GFAvatarShape.standard,
      borderRadius: BorderRadius.circular(5.r),
      backgroundImage: NetworkImage(image),
    );
  }

  Widget buildTextMessage(types.TextMessage message,
      {required int messageWidth, required bool showName}) {
    if (message.author.id == chatCtl.user.userId) {
      return Container(
        margin: EdgeInsets.all(12.r),
        child: TextMessageText(
          bodyTextStyle: TextStyle(
              fontSize: 16.sp,
              color: Colors.black,
              fontFamilyFallback: AppTextTheme.fontFamily),
          text: message.text,
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.all(12.r),
        child: TextMessageText(
          bodyTextStyle: TextStyle(
              fontSize: 16.sp,
              color: Colors.black,
              fontFamilyFallback: AppTextTheme.fontFamily),
          text: message.text,
        ),
      );
    }
  }



  List<ItemModel> menuItems = [
    ItemModel('复制', Icons.content_copy,0),
    ItemModel('转发', Icons.send,1),
    // ItemModel('收藏', Icons.collections),
    // ItemModel('删除', Icons.delete),
    // ItemModel('多选', Icons.playlist_add_check),
    ItemModel('引用', Icons.format_quote,2),
    // ItemModel('提醒', Icons.add_alert),
    // ItemModel('搜一搜', Icons.search),
  ];

  Widget buildPopChild(Widget child,types.Message message) {
    var controller = CustomPopupMenuController();
    state.popCtlList.add(controller);
    return CustomPopupMenu(
      pressType: PressType.singleClick,
      controller: controller,
      menuBuilder: ()=>buildLongPressMenu(message),
      child: child,
    );
  }


  Widget buildLongPressMenu(types.Message message) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Container(
        color: const Color(0xFF4C4C4C),
        padding: EdgeInsets.all(5.r),
        child: Wrap(
          children: menuItems.map((item) => Container(
            margin: EdgeInsets.symmetric(horizontal: 5.w),
            child: InkWell(
              onTap: ()=> logic.clickMessage(message,item),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(item.icon, size: 15.r, color: Colors.white,),
                  Container(
                    margin: EdgeInsets.only(top: 2.h),
                    child: Text(
                      item.title,
                      style: TextStyle(color: Colors.white, fontSize: 10.sp),
                    ),
                  ),
                ],
              ),
            ),
          )).toList(),
        ),
      ),
    );
  }


}
