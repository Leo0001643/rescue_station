
import 'dart:convert';

import 'package:common_utils/common_utils.dart';
import 'package:rescue_station/app/domains/user_info_entity.dart';
import 'package:rescue_station/app/utils/shared_preferences_util.dart';

class AppData {

  static Future<bool> setUser(UserInfoEntity user){
    return SharedPreferencesUtil.setString("userInfo", jsonEncode(user.toJson()));
  }

  static UserInfoEntity? getUser(){
    var user = SharedPreferencesUtil.getString("userInfo");
    if(ObjectUtil.isEmpty(user)) return null;
    return UserInfoEntity.fromJson(jsonDecode(user!));
  }

  static Future<bool> clearUser(){
    return SharedPreferencesUtil.remove("userInfo");
  }


}


