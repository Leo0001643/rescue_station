import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rescue_station/app/theme/app_text_theme.dart';

///聊天框下方底部表情包
class BottomEmojiWidget extends StatefulWidget {

  final TextEditingController editController;

  BottomEmojiWidget(this.editController,{super.key});


  @override
  State<StatefulWidget> createState()=>StateBottomEmojiWidget();

}

class StateBottomEmojiWidget extends State<BottomEmojiWidget> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return EmojiPicker(
      textEditingController: widget.editController,
      scrollController: _scrollController,
      config: Config(
        height: 300.h,
        checkPlatformCompatibility: true,
        emojiViewConfig: EmojiViewConfig(
          // Issue: https://github.com/flutter/flutter/issues/28894
          emojiSizeMax: 28 *
              (foundation.defaultTargetPlatform == TargetPlatform.iOS ? 1.2 : 1.0),
        ),
        emojiTextStyle: TextStyle(fontFamilyFallback: AppTextTheme.fontFamily),
        swapCategoryAndBottomBar: false,
        skinToneConfig: const SkinToneConfig(),
        categoryViewConfig: const CategoryViewConfig(),
        bottomActionBarConfig: const BottomActionBarConfig(
          showSearchViewButton: false,
          backgroundColor: Colors.transparent,
          buttonIconColor: Colors.black,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

}
