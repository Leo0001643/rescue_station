import 'package:bubble/bubble.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_ui/src/conditional/conditional.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:rescue_station/app/constant/constant.dart';
import 'package:rescue_station/app/domains/item_model.dart';
import 'package:rescue_station/app/event/chat_event.dart';
import 'package:rescue_station/app/routes/app_pages.dart';
import 'package:rescue_station/app/theme/app_colors.dart';
import 'package:rescue_station/app/theme/app_text_theme.dart';
import 'package:rescue_station/app/utils/data_utils.dart';
import 'package:rescue_station/app/utils/widget_utils.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import 'bottom_chat_controller.dart';
import 'bottom_chat_widget.dart';
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
  void initState() {
    if (Get.arguments == null) {
      Get.back();
      return;
    }
    ChatEvent event = Get.arguments;
    state.chatEvent = event;
    chatCtl.user = event.user;
    chatCtl.friend = event.friend;
    logic.queryChatMessage();
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<ChatByFriendLogic>();
    Get.delete<BottomChatController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (chatCtl.user.userId == null) {
      return Container();
    }
    return Scaffold(
      appBar: WidgetUtils.buildAppBar(chatCtl.friend.nickName.em(), actions: [
        IconButton(
          icon: Icon(
            Icons.more_vert_outlined,
            size: 30.r,
          ),
          onPressed: () => Get.toNamed(Routes.CHAT_FRIEND_DETAIL,
              arguments: state.chatEvent),
        ),
      ]),
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
            // imageMessageBuilder: buildImageMessage,
            textMessageBuilder: buildTextMessage,
            // imageProviderBuilder: buildImageProvider,
            onSendPressed: (text) {},
            // onMessageTap: (context, message) => logic.addMessage(),
            user: types.User(
                id: chatCtl.user.userId.em(),
                imageUrl: chatCtl.user.portrait.em()),
            showUserAvatars: false,
            showUserNames: false,
            dateLocale: Constant.locale.toString(),
            bubbleBuilder: buildBubble,
            // avatarBuilder: (user) => buildAvatar(user.imageUrl.em()),
            emojiEnlargementBehavior: EmojiEnlargementBehavior.never,
            customBottomWidget:
                BottomChatWidget((msg) => logic.sendMessage(msg)),
            onBackgroundTap: () {
              FocusScope.of(context).unfocus();
              chatCtl.moreVisible.value = false;
              chatCtl.emojiVisible.value = false;
            },
          );
        }),
      ),
    );
  }

  Widget buildBubble(Widget child, {required message, required nextMessageInGroup}) {
    var reply = (message as types.Message).repliedMessage;

    if (message.author.id == chatCtl.user.userId) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
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
              Visibility(
                visible: reply != null,
                child: Container(
                  decoration: BoxDecoration(
                    color: color_e6e,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  margin: EdgeInsets.only(top: 5.h,bottom: 5.h),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.w),
                    child: Text("${reply?.author.firstName.em()}：${DataUtils.getMsgContent(reply)}",
                      style: TextStyle(fontSize: 10.sp,color: color_333,overflow: TextOverflow.ellipsis),maxLines: 1,),
                  ),
                ),
              ),
            ],
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
          buildAvatar(chatCtl.friend.portrait.em()),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 230.w),
                child: message is types.ImageMessage
                    ? Padding(
                  padding: EdgeInsets.only(left: 10.w),
                  child: buildPopChild(child,message),
                ) : Bubble(
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
              Visibility(
                visible: reply != null,
                child: Container(
                  decoration: BoxDecoration(
                    color: color_e6e,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  margin: EdgeInsets.only(top: 5.h,bottom: 5.h),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.w),
                    child: Text("${reply?.author.firstName.em()}：${DataUtils.getMsgContent(reply)}",
                      style: TextStyle(fontSize: 10.sp,color: color_333,overflow: TextOverflow.ellipsis,),maxLines: 1,),
                  ),
                ),
              ),
            ],
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
    // var d = r'\\u{[0-9A-Fa-f]+}';
    // loggerArray(["是否包含表情符号",GetUtils.hasMatch(message.text, d),message.text]);
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

  ImageProvider<Object> buildImageProvider(
      {required Conditional conditional,
      required Map<String, String>? imageHeaders,
      required String uri}) {
    // loggerArray(["走这里吗第三方水电费",uri,imageHeaders,conditional]);
    return WidgetUtils.buildImageProvider(uri);
  }

  Widget buildImageMessage(types.ImageMessage p1, {required int messageWidth}) {
    return Container();
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
      pressType: PressType.longPress,
      controller: controller,
      menuBuilder: ()=>buildLongPressMenu(message),
      child: message is types.ImageMessage ?
      InkWell(child: child, onTap: ()=> chatCtl.showImageViewer(context,message.uri),) : child,
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


