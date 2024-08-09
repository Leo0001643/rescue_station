
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:rescue_station/app/theme/app_colors.dart';
import 'package:rescue_station/app/theme/app_colors_theme.dart';
import 'package:rescue_station/app/utils/AppLayout.dart';
import 'package:rescue_station/app/utils/widget_utils.dart';

class DialogUtils{

  static void showPopMenu(BuildContext context,List<PopupMenuEntry> items){
    showMenu(
        context: context,
        color: AppStyles.lightGrey,
        position: RelativeRect.fromLTRB(AppLayout.width(600), AppLayout.heigth(90), 0, 0),
        items: items,
    );
  }

  ///消息提示
  static Future<bool?> showAlertDialog(BuildContext context,String title) {
    return showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
            titlePadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.symmetric(horizontal: 15.w),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 70.h,
                  alignment: Alignment.center,
                  child: Text(title, style: TextStyle(fontSize: 16.sp,),),
                ),
                Divider(height: 1.h,color: color_e6e,),
                Align(
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 10.h),
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        WidgetUtils.buildElevatedButton(
                            "取消", 116.w, 40.h,
                            bg: Colors.white,
                            textColor: Colors.black, onPressed: () {
                          Navigator.of(context).pop(false);
                        }),
                        SizedBox(
                          width: 10.w,
                        ),
                        WidgetUtils.buildElevatedButton(
                            "确定", 116.w, 40.h,
                            bg: color_703,
                            textColor: Colors.white, onPressed: () {
                          Navigator.of(context).pop(true);
                        })
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }

  ///消息提示
  static Future<bool?> showSingleDialog(BuildContext context,String title) {
    return showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
            titlePadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.symmetric(horizontal: 15.w),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 70.h,
                  alignment: Alignment.center,
                  child: Text(title, style: TextStyle(fontSize: 16.sp,),),
                ),
                Divider(height: 1.h,color: color_e6e,),
                Center(
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 10.h),
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: WidgetUtils.buildElevatedButton(
                        "确定", 116.w, 40.h,
                        bg: color_703,
                        textColor: Colors.white, onPressed: () {
                      Navigator.of(context).pop(true);
                    }),
                  ),
                )
              ],
            ),
          );
        });
  }


  static void showCustomDialog({
    required String title,
    required String message,
    required Color backgroundColor,
    required IconData icon,
    int displayDuration = 500,  // 设置默认显示时长为500毫秒
  }) {
    Get.defaultDialog(
      title: '',
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: backgroundColor, size: AppLayout.fontSize(40)),
              SizedBox(width: AppLayout.width(12)),
              Text(
                title,
                style: TextStyle(
                  fontSize: AppLayout.fontSize(16),
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          Gap(AppLayout.heigth(20)),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: AppLayout.fontSize(14),
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      radius: AppLayout.heigth(12),
      barrierDismissible: false,  // 设置为false使得点击外部区域不会关闭对话框
    );

    // 自动在指定时间后关闭对话框
    Future.delayed(Duration(milliseconds: displayDuration), () {
      Get.back();  // 关闭对话框
    });
  }
}


