
import 'dart:convert';

import 'package:rescue_station/app/domains/user_info_entity.dart';
import 'package:rescue_station/app/utils/shared_preferences_util.dart';

import '../routes/app_pages.dart';

class AppData {

  static Future<bool> setUser(UserInfoEntity user){
    return SharedPreferencesUtil.setString("userInfo", jsonEncode(user.toJson()));
  }

  static UserInfoEntity? getUser(){
    var user = SharedPreferencesUtil.getString("userInfo");
    if(isEmpty(user)) return null;
    return UserInfoEntity.fromJson(jsonDecode(user!));
  }

  static Future<bool> clearUser(){
    return SharedPreferencesUtil.remove("userInfo");
  }


  static Future<bool> setPageRefresh(bool isRefresh){
    return SharedPreferencesUtil.setBool("PageRefresh", isRefresh);
  }

  static bool pageRefresh(){
    return SharedPreferencesUtil.getBool("PageRefresh",defaultValue: false) ?? false;
  }

  static Future<bool> setRouteHistory(String history){
    return SharedPreferencesUtil.setString("RouteHistory", history);
  }

  static String routeHistory(){
    return SharedPreferencesUtil.getString("RouteHistory") ?? '[]';
  }




}


