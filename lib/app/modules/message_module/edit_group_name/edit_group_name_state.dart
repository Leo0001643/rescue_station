import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rescue_station/app/domains/group_detail_entity.dart';
import 'package:rescue_station/app/event/chat_event.dart';

class EditGroupNameState {
  EditGroupNameState() {
    ///Initialize variables
  }

  late ChatGroupEvent chatEvent;

  var groupDetail = GroupDetailEntity().obs;

  late TextEditingController textController;


}
