import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:rescue_station/app/domains/user_info_entity.dart';
import 'package:rescue_station/app/routes/app_pages.dart';
import 'package:rescue_station/app/theme/app_colors.dart';
import 'package:rescue_station/app/theme/app_colors_theme.dart';
import 'package:rescue_station/app/utils/widget_utils.dart';

import 'new_friend_logic.dart';

class NewFriendPage extends StatefulWidget {
  const NewFriendPage({Key? key}) : super(key: key);

  @override
  State<NewFriendPage> createState() => _NewFriendPageState();
}

class _NewFriendPageState extends State<NewFriendPage> {
  final logic = Get.find<NewFriendLogic>();
  final state = Get.find<NewFriendLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetUtils.buildAppBar("新的朋友"),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Obx(() {
          return Column(
            children: [
              ...state.data.map((apply){
                return Column(
                  children: [
                    ListTile(
                      leading: GFAvatar(
                        backgroundImage: NetworkImage(apply.portrait.em()),
                        radius: 25.r,
                        shape: GFAvatarShape.standard,
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      title: Text(apply.nickName.em(),style: TextStyle(fontSize: 16.sp,color: Colors.black,),),
                      subtitle: Text(apply.reason.em(),style: TextStyle(fontSize: 12.sp,color: Colors.black54),),
                      trailing: apply.applyStatus == "0" ? Wrap(
                        children: [
                          WidgetUtils.buildElevatedButton("忽略", 60.w, 30.h,bg: Colors.amberAccent,
                              onPressed: ()=> logic.applyIgnore(apply)),
                          SizedBox(width: 10.w,),
                          WidgetUtils.buildElevatedButton("添加", 60.w, 30.h,bg: color_703,
                              onPressed: ()=> logic.applyAgree(apply)),
                        ],
                      )
                          : (apply.applyStatus == "1" ? Text("已添加",style: TextStyle(fontSize: 14.sp,color: Colors.black54),) :
                      Text("已忽略",style: TextStyle(fontSize: 14.sp,color: Colors.black54),)),
                      onTap: (){
                        if(apply.applyStatus == '1'){
                          Get.toNamed(Routes.FRIEND_DETAIL,arguments: UserInfoEntity(userId: apply.userId));
                        }
                      },
                    ),
                    Container(
                      height: 1.h,
                      width: double.infinity,
                      color: AppStyles.lightGreyWile,
                      margin: EdgeInsets.only(left: 80.w,right: 10.w),
                    ),
                  ],
                );
              })
            ],
          );
        }),
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<NewFriendLogic>();
    super.dispose();
  }
}