
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:rescue_station/app/theme/app_colors.dart';
import 'package:rescue_station/app/theme/app_colors_theme.dart';
import 'package:rescue_station/app/theme/app_text_theme.dart';
import 'package:rescue_station/app/utils/AppLayout.dart';
import 'package:rescue_station/app/utils/Icon.dart';

class WidgetUtils {

  static AppBar buildAppBar(String title) {
    return AppBar(
      title: Text(title,style: TextStyle(fontSize: 16.sp,color: color_333),),
      centerTitle: true,
    );
  }


  static AppBar buildSearchAppBar(BuildContext context,String title,Widget rightIcon,{Function(String text)? onChange}){
    return AppBar(
      toolbarHeight: AppLayout.heigth(120),
      backgroundColor: color_703,
      title: Column(
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Center(
                    child: Padding(
                        padding: EdgeInsets.only(left: AppLayout.width(50)),
                        child: Text(title, style: TextStyle(color: Colors.white, fontSize: AppLayout.fontSize(20),fontWeight: FontWeight.w500))
                    ))),
                rightIcon,
              ]
          ),
          SizedBox(height: 15.h,),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
            ),
            // margin: EdgeInsets.symmetric(horizontal: 10.w),
            child: Row(
              children: [
                SizedBox(width: 8.w,),
                Icon(Icons.search,),
                Expanded(
                  child: TextField(
                    // keyboardType: TextInputType.number,
                    style: TextStyle(fontSize: 16.sp),
                    onChanged: onChange,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 10.h),
                      isCollapsed: true,
                      hintText: "搜索",
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
        ],
      ),
    );
  }



  static Widget buildElevatedButton(String text, double width, double height,
      {Color? bg,
        Color textColor = Colors.white,
        double textSize = 14,
        TextAlign? textAlign,
        VoidCallback? onPressed}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        backgroundColor: bg,
        minimumSize: Size(width, height),
        maximumSize: Size(width, height),
        padding: EdgeInsets.zero,
      ),
      child: Text(
        text,
        textAlign: textAlign,
        style: TextStyle(
            fontSize: textSize.sp,
            color: textColor,
            fontWeight: FontWeight.w700),
      ),
    );
  }





}


extension StringExtension on String? {
  ///防止字段为空报错
  String em({String aft = ""}){
    return ObjectUtil.isEmpty(this) ? aft : this!;
  }

}

