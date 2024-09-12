import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:lifecycle/lifecycle.dart';
import 'package:rescue_station/app/constant/constant.dart';
import 'package:rescue_station/app/db/db_helper.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'app/routes/app_pages.dart';
import 'app/utils/navigator_observer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'app/utils/shared_preferences_util.dart';

void main() async {
  /// Ensure Flutter framework is properly initialized
  WidgetsFlutterBinding.ensureInitialized();

  /// FFI initialization for desktop platforms
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;  // Set databaseFactory for desktop platforms
  }

  /// Initialize shared preferences
  await SharedPreferencesUtil.init();

  /// Initialize the database helper (ensure databaseFactory is set for desktop)
  await DbHelper().init();

  /// Configure transparent status bar
  SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);

  /// Route tracking
  final CustomNavigatorObserver navigatorObserver = CustomNavigatorObserver();

  /// Initialize international date formatting
  initializeDateFormatting().then((_) {
    runApp(ScreenUtilInit(
      designSize: const Size(375, 800),   // Design width and height in px
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: "水滴扶贫",
          locale: Constant.locale,
          fallbackLocale: Constant.locale,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,  // For localized strings and values
            GlobalCupertinoLocalizations.delegate, // For Cupertino style localization
            GlobalWidgetsLocalizations.delegate,   // For text directionality
          ],
          navigatorObservers: [defaultLifecycleObserver, navigatorObserver],
          theme: ThemeData(primarySwatch: Colors.grey),
          initialRoute: Routes.TABS,
          defaultTransition: Transition.noTransition, // Disable page transition animation
          getPages: AppPages.pages,
          unknownRoute: AppPages.pages.first,
          builder: EasyLoading.init(),
        );
      },
    ));
  });
}
