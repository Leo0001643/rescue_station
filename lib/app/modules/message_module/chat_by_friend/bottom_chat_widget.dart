import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rescue_station/app/routes/app_pages.dart';
import 'package:rescue_station/app/socket/socket_utils.dart';
import 'package:rescue_station/app/theme/app_colors.dart';
import 'package:rescue_station/app/theme/app_text_theme.dart';
import 'package:rescue_station/app/utils/logger.dart';
import 'package:rescue_station/app/utils/widget_utils.dart';

import 'bottom_chat_controller.dart';
import 'bottom_emoji_widget.dart';
import 'bottom_more_widget.dart';

class BottomChatWidget extends StatefulWidget {
  final Function(Message msg) onSendChatListener;

  const BottomChatWidget(this.onSendChatListener, {super.key});

  @override
  State<StatefulWidget> createState() => StateBottomChatWidget();
}

class StateBottomChatWidget extends State<BottomChatWidget> {
  final chatCtl = Get.find<BottomChatController>();

  @override
  void initState() {
    chatCtl.keyboardVisibilityController.onChange.listen((visible) {
      if (visible) {
        ///当虚拟键盘显示需要隐藏表情和更多
        chatCtl.moreVisible.value = false;
        chatCtl.emojiVisible.value = false;
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    chatCtl.inputFocusNode.dispose();
    chatCtl.textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                    controller: chatCtl.textController,
                    textInputAction: TextInputAction.send,
                    focusNode: chatCtl.inputFocusNode,
                    onChanged: (text){
                      if(text.endsWith("\n")){
                        chatCtl.textController.text = text.replaceRange(text.length - "\n".length, text.length, "");
                      }
                    },
                    onSubmitted: (text) {
                      ///防止自动隐藏虚拟键盘
                      chatCtl.inputFocusNode.requestFocus();
                      if (isNotEmpty(text)) {
                        widget.onSendChatListener(SocketUtils().buildUserText(text, chatCtl.user));
                      }
                      chatCtl.textController.clear();
                    },
                    style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontFamilyFallback: AppTextTheme.fontFamily,
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
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
                child: Icon(
                  Icons.emoji_emotions_outlined,
                  size: 40.r,
                  color: color_333,
                ),
                onTap: () {
                  if (chatCtl.keyboardVisibilityController.isVisible) {
                    FocusScope.of(context).unfocus();
                  }
                  if (chatCtl.moreVisible.value) {
                    chatCtl.moreVisible.value = false;
                  }
                  chatCtl.emojiVisible.value = !chatCtl.emojiVisible.value;
                },
              ),
              SizedBox(width: 5.w,),
              Obx(() {
                return Offstage(
                  offstage: chatCtl.emojiVisible.value,
                  child: InkWell(
                    child: Icon(
                      Icons.add_circle_outline_outlined,
                      size: 40.r,
                      color: color_333,
                    ),
                    onTap: () {
                      if (chatCtl.keyboardVisibilityController.isVisible) {
                        FocusScope.of(context).unfocus();
                      }
                      if (chatCtl.emojiVisible.value) {
                        chatCtl.emojiVisible.value = false;
                      }
                      chatCtl.moreVisible.value = !chatCtl.moreVisible.value;
                    },
                  ),
                );
              }),
              Obx(() {
                return Offstage(
                  offstage: !chatCtl.emojiVisible.value,
                  child: WidgetUtils.buildElevatedButton("发送", 60.w, 50.h,
                      textSize: 10, bg: color_703, onPressed: () {
                    if (isNotEmpty(chatCtl.textController.text)) {
                      widget.onSendChatListener(SocketUtils().buildUserText(
                          chatCtl.textController.text, chatCtl.user));
                    }
                    chatCtl.textController.clear();
                  }),
                );
              }),
              SizedBox(
                width: 5.w,
              ),
            ],
          ),
          Obx(() {
            return Visibility(
              visible: chatCtl.emojiVisible.value || chatCtl.moreVisible.value,
              child: Container(
                color: Colors.white,
                height: 1.h,
                width: 1.sw,
              ),
            );
          }),
          SizedBox(
            height: 5.h,
          ),
          Obx(() {
            return Offstage(
              offstage: !chatCtl.moreVisible.value,
              child: BottomMoreWidget(widget.onSendChatListener),
            );
          }),
          Obx(() {
            return Offstage(
              offstage: !chatCtl.emojiVisible.value,
              child: BottomEmojiWidget(chatCtl.textController),
            );
          }),
        ],
      ),
    );
  }
}
