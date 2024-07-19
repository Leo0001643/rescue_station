import 'package:flutter/material.dart';
import 'package:rescue_station/app/domains/user_info_entity.dart';

class ApplyFriendState {
  ApplyFriendState() {
    ///Initialize variables
  }

  UserInfoEntity? user;

  var reasonCtl = TextEditingController(text: "想加你好友通过一下谢谢！");

  var remarkCtl = TextEditingController(text: "");

}
