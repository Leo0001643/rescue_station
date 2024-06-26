import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rescue_station/app/db/user_info_table.dart';

class ApplyFriendState {
  ApplyFriendState() {
    ///Initialize variables
  }

  UserInfoTable? user;

  var reasonCtl = TextEditingController(text: "想加你好友通过一下谢谢！");

  var remarkCtl = TextEditingController(text: "");

}
