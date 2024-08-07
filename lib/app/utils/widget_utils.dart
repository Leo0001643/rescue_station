
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rescue_station/app/event/logout_event.dart';
import 'package:rescue_station/app/routes/app_pages.dart';
import 'package:rescue_station/app/socket/socket_utils.dart';
import 'package:rescue_station/app/theme/app_colors.dart';
import 'package:rescue_station/app/utils/AppLayout.dart';
import 'package:rescue_station/app/utils/Icon.dart';
import 'package:rescue_station/app/utils/app_data.dart';
import 'package:rescue_station/app/utils/dialog_utils.dart';

import 'logger.dart';

class WidgetUtils {

  static AppBar buildAppBar(String title,{List<Widget>? actions,Color backgroundColor = Colors.white,Color? textColor}) {
    return AppBar(
      title: Text(title,style: TextStyle(fontSize: 18.sp,color: textColor ?? color_333,fontWeight: FontWeight.w700),),
      iconTheme: IconThemeData(color: textColor ?? color_333),
      centerTitle: true,
      toolbarHeight: AppLayout.heigth(60),
      backgroundColor: backgroundColor,
      actions: actions,
    );
  }

  static AppBar buildObxAppBar(RxString title,{List<Widget>? actions,Color backgroundColor = Colors.white,Color? textColor}) {
    return AppBar(
      title: Obx(() {
        return Text(title.value,style: TextStyle(fontSize: 18.sp,color: textColor ?? color_333,fontWeight: FontWeight.w700),);
      }),
      iconTheme: IconThemeData(color: textColor ?? color_333),
      centerTitle: true,
      toolbarHeight: AppLayout.heigth(60),
      backgroundColor: backgroundColor,
      actions: actions,
    );
  }


  static AppBar buildSearchAppBar(BuildContext context,String title,Widget rightIcon,{Function(String text)? onChange}){
    return AppBar(
      toolbarHeight: AppLayout.heigth(120),
      backgroundColor: color_703,
      centerTitle: true,
      title: Text(title, style: TextStyle(color: Colors.white, fontSize: AppLayout.fontSize(18),fontWeight: FontWeight.w500)),
      actions: [rightIcon,],
      bottom: PreferredSize(
          preferredSize: Size(double.infinity, 10.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                margin: EdgeInsets.symmetric(horizontal: 10.w),
                child: Row(
                  children: [
                    SizedBox(width: 8.w,),
                    Icon(Icons.search,),
                    Expanded(
                      child: TextField(
                        // keyboardType: TextInputType.number,
                        style: TextStyle(fontSize: 12.sp),
                        onChanged: onChange,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 10.h),
                          isCollapsed: true,
                          hintText: "搜索",
                          hintStyle: TextStyle(fontSize: 12.sp),
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
              SizedBox(height: 15.h,),
            ],
          ),
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

  static ImageProvider buildImageProvider(String image, {String defImage = ImageFont.select_img}) {
    loggerArray(["加载的图片地址",image,isURL(image)]);
    if (image.isEmpty || (!isURL(image) && !image.contains("assets"))) {
      return AssetImage(defImage);
    }
    try {
      return image.startsWith("file://") ? FileImage(File(image.trim())) : (
          isURL(image)
              ? NetworkImage(image.trim(),)
              : AssetImage(image) as ImageProvider
      );
    } catch (e) {
      return AssetImage(defImage);
    }
  }

  static buildImage(String image, double width, double height,
      {String defImage = ImageFont.select_img, BoxFit? fit,bool placeholder=false}) {
    loggerArray(["加载图片了",image,isURL(image)]);
    if (image.isEmpty) {
      return Image.asset(defImage, width: width, height: height, fit: fit,);
    }
    try {
      return isURL(image)
          ? CachedNetworkImage(imageUrl: image.trim(),fit: fit,width: width,height: height,
        errorWidget: (context,url,error){
          loggerArray(["异常了", url, error]);
          return Image.asset(defImage,width: width, height: height, fit: fit,);
        },
        placeholder: (context,url){
          return placeholder ? Image.asset(defImage,width: width, height: height, fit: fit,) : SizedBox(width: width,height: height,);
        },
        errorListener: (stack){
            loggerArray(["加载图片错误",stack]);
        },
      )
          :Image.asset(image,width: width, height: height, fit: fit,);
    } catch (e) {
      loggerArray(["异常了", image, e]);
      return Image.asset(defImage, width: width, height: height, fit: fit,);
    }
  }


  static void clickCopy(String value) {
    if (isNotEmpty(value)) {
      Clipboard.setData(ClipboardData(text: value));
      showToasty("已复制");
    }
  }

  ////token过期
  static void logSqueezeOut(){
    DialogUtils.showSingleDialog(Get.context!, "您的登录已过期，请重新登录！").then((v) async {
      await AppData.clearUser();
      await SocketUtils().destroy();
      eventBus.fire(LogoutEvent());
      Get.until((ModalRoute.withName(Routes.TABS)));
      Future.delayed(Duration(milliseconds: 300),(){
        Get.toNamed(Routes.LOGIN);
      });
    });
  }




}


extension StringExtension on String? {
  ///防止字段为空报错
  String em({String aft = ""}){
    return isEmpty(this) ? aft : this!;
  }

}

