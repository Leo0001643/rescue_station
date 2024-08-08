import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rescue_station/app/routes/app_pages.dart';
import 'package:rescue_station/app/theme/app_colors.dart';
import 'package:rescue_station/app/utils/widget_utils.dart';

import 'apply_friend_logic.dart';

class ApplyFriendPage extends StatefulWidget {
  const ApplyFriendPage({Key? key}) : super(key: key);

  @override
  State<ApplyFriendPage> createState() => _ApplyFriendPageState();
}

class _ApplyFriendPageState extends State<ApplyFriendPage> {
  final logic = Get.find<ApplyFriendLogic>();
  final state = Get.find<ApplyFriendLogic>().state;

  @override
  void initState() {
    if(isEmpty(Get.arguments)){
      Get.until((ModalRoute.withName(Routes.TABS)));
      return;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(isEmpty(Get.arguments)){
      return Container();
    }
    return Scaffold(
      appBar: WidgetUtils.buildAppBar("申请添加朋友"),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 25.w,top: 20.h),
            child: Text("发送添加朋友申请",style: TextStyle(fontSize: 14.sp,color: Colors.black54),),
          ),
          SizedBox(height: 10.h,),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.r),
              color: Colors.black12,
            ),
            height: 100.h,
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            child: TextField(
              style: TextStyle(fontSize: 16.sp,color: Colors.black),
              controller: state.reasonCtl,
              maxLines: 10,
              maxLength: 50,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 10.h),
                isCollapsed: true,
                counterText: "",
                border: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 25.w,top: 20.h),
            child: Text("设置备注",style: TextStyle(fontSize: 14.sp,color: Colors.black54),),
          ),
          SizedBox(height: 10.h,),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.r),
              color: Colors.black12,
            ),
            height: 50.h,
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            child: TextField(
              style: TextStyle(fontSize: 16.sp,color: Colors.black),
              controller: state.remarkCtl,
              maxLength: 10,
              readOnly: true,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 10.h),
                isCollapsed: true,
                counterText: "",
                border: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
          ),
          SizedBox(height:100.h,),
          Center(
            child: WidgetUtils.buildElevatedButton("发送", 150.w, 50.h,bg: color_65d, onPressed: ()=> logic.applyAdd()),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<ApplyFriendLogic>();
    super.dispose();
  }
}