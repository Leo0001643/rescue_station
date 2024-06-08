import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  //配置透明的状态栏
  SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  runApp(ScreenUtilInit(
          designSize: const Size(430, 932),   //设计稿的宽度和高度px
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context , child) {
            return  GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: "Application",
              theme: ThemeData(primarySwatch: Colors.grey),
              initialRoute: Routes.TABS,
              defaultTransition:Transition.noTransition,//页面切换取消动画
              getPages: AppPages.pages
            );
          })
  );
}
