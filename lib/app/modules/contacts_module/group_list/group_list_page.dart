import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rescue_station/app/modules/message_module/group_avatar_aidget.dart';
import 'package:rescue_station/app/theme/app_colors_theme.dart';
import 'package:rescue_station/app/utils/widget_utils.dart';

import 'group_list_logic.dart';

///群列表
class GroupListPage extends StatefulWidget {
  const GroupListPage({Key? key}) : super(key: key);

  @override
  State<GroupListPage> createState() => _GroupListPageState();
}

class _GroupListPageState extends State<GroupListPage> {
  final logic = Get.find<GroupListLogic>();
  final state = Get.find<GroupListLogic>().state;



  @override
  void dispose() {
    Get.delete<GroupListLogic>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetUtils.buildAppBar("群聊"),
      backgroundColor: Colors.white,
      body: Obx(() {
        return SingleChildScrollView(
          child: Column(
            children: [
              ...state.data.map((item){
                return Column(
                  children: [
                    ListTile(
                      leading: GroupAvatarWidget(item.portrait ?? []),
                      title: Text(item.name.em(),style: TextStyle(fontSize: 16.sp,color: Colors.black,),),
                      onTap: ()=> logic.openChatBox(item),
                    ),
                    Container(
                      height: 1.h,
                      width: double.infinity,
                      color: AppStyles.lightGreyWile,
                      margin: EdgeInsets.only(left: 80.w,right: 10.w),
                    ),
                  ],
                );
              }),
            ],
          ),
        );
      }),
    );
  }

}