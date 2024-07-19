
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

}


