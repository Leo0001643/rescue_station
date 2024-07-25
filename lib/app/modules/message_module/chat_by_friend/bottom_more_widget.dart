import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rescue_station/app/socket/socket_utils.dart';
import 'package:rescue_station/app/theme/app_colors.dart';
import 'package:rescue_station/app/utils/Icon.dart';

import 'bottom_chat_controller.dart';

///聊天框下方底部更多
class BottomMoreWidget extends StatefulWidget {
  final Function(Message msg) onSendChatListener;

  const BottomMoreWidget(this.onSendChatListener, {super.key});

  @override
  State<StatefulWidget> createState() => StateBottomMoreWidget();
}

class StateBottomMoreWidget extends State<BottomMoreWidget> {
  final chatCtl = Get.find<BottomChatController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color_d2d,
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              FilePicker.platform
                  .pickFiles(type: FileType.image)
                  .then((result) {
                print("选择的图片${result?.names.toString()}");
                if (result?.count == 1) {
                  widget.onSendChatListener(SocketUtils()
                      .buildUserImage(result!.files[0], chatCtl.user));
                }
              });
              chatCtl.moreVisible.value = false;
            },
            icon: Image.asset(
              ImageFont.select_img,
              width: 60.r,
              height: 60.r,
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          IconButton(
            onPressed: () {
              FilePicker.platform.pickFiles().then((result) {
                print("选择的文件${result?.names.toString()}");
                if (result?.count == 1) {
                  widget.onSendChatListener(SocketUtils()
                      .buildUserFile(result!.files[0], chatCtl.user));
                }
              });
              chatCtl.moreVisible.value = false;
            },
            icon: Image.asset(
              ImageFont.select_file,
              width: 60.r,
              height: 60.r,
            ),
          ),
        ],
      ),
    );
  }
}
