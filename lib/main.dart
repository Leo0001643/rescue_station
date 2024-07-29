import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:lifecycle/lifecycle.dart';
import 'package:rescue_station/app/constant/constant.dart';
import 'package:rescue_station/app/db/db_helper.dart';
import 'app/routes/app_pages.dart';
import 'app/utils/navigator_observer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'app/utils/shared_preferences_util.dart';

void main() async{
  ///配置透明的状态栏
  SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  ///路由追踪
  final CustomNavigatorObserver navigatorObserver = CustomNavigatorObserver();
  ///初始化本地缓存
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesUtil.init();
  await DbHelper().init();
  ///初始化国际日期格式
  initializeDateFormatting().then((_){
    runApp(
        ScreenUtilInit(
            designSize: const Size(375, 800),   //设计稿的宽度和高度px
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context , child) {
              return GetMaterialApp(
                debugShowCheckedModeBanner: false,
                title: "绿色扶贫",
                locale: Constant.locale,
                fallbackLocale: Constant.locale,
                localizationsDelegates: const [
                  GlobalMaterialLocalizations.delegate, /// 指定本地化的字符串和一些其他的值
                  GlobalCupertinoLocalizations.delegate, /// 对应的Cupertino风格
                  GlobalWidgetsLocalizations.delegate, /// 指定默认的文本排列方向, 由左到右或由右到左
                ],
                navigatorObservers: [defaultLifecycleObserver,navigatorObserver],
                theme: ThemeData(primarySwatch: Colors.grey),
                initialRoute: Routes.TABS,
                defaultTransition:Transition.noTransition,//页面切换取消动画
                getPages: AppPages.pages,
                builder: EasyLoading.init(),
              );
            })
    );
  });

}
