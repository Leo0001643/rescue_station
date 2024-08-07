import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rescue_station/app/event/edit_group_event.dart';
import 'package:rescue_station/app/modules/message_module/group_avatar_aidget.dart';
import 'package:rescue_station/app/routes/app_pages.dart';
import 'package:rescue_station/app/theme/app_colors.dart';
import 'package:rescue_station/app/utils/widget_utils.dart';

import 'edit_group_name_logic.dart';

class EditGroupNamePage extends StatefulWidget {
  const EditGroupNamePage({Key? key}) : super(key: key);

  @override
  State<EditGroupNamePage> createState() => _EditGroupNamePageState();
}

class _EditGroupNamePageState extends State<EditGroupNamePage> {
  final logic = Get.find<EditGroupNameLogic>();
  final state = Get.find<EditGroupNameLogic>().state;

  @override
  void initState() {
    if(isNotEmpty(Get.arguments)){
      EditGroupEvent event = Get.arguments;
      state.groupDetail.value = event.group;
      state.chatEvent = event.event;
      state.textController = TextEditingController(text: state.groupDetail.value.group?.name);
    }
    super.initState();
  }

  @override
  void dispose() {
    state.textController.dispose();
    Get.delete<EditGroupNameLogic>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetUtils.buildAppBar("修改群聊名称"),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: 20.h,),
          Divider(color: color_e6e,endIndent: 0.12.sw,indent: 0.12.sw,),
          Container(
            width: 0.75.sw,
            child: Row(
              children: [
                GroupAvatarWidget(state.groupDetail.value.group?.portrait ?? []),
                SizedBox(width: 5.w,),
                Expanded(
                  child: TextField(
                    controller: state.textController,
                    style: TextStyle(fontSize: 12.sp),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 10.h),
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
              ],
            ),
          ),
          Divider(color: color_e6e,endIndent: 0.12.sw,indent: 0.12.sw,),
          Expanded(
            child: Center(
              child: WidgetUtils.buildElevatedButton("确定", 150.w, 40.h,bg: color_703, onPressed: (){
                logic.editGroupName();
              }),
            ),
          ),
        ],
      ),
    );
  }




}