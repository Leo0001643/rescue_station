import 'package:get/get.dart';
import 'package:rescue_station/app/domains/group_detail_entity.dart';
import 'package:rescue_station/app/domains/user_info_entity.dart';

class GroupAddState {
  GroupAddState() {
    ///Initialize variables
  }

  late GroupDetailEntity groupDetail;


  var contacts = RxList<UserInfoEntity>.empty(growable: true);

  var selectList = RxList<UserInfoEntity>.empty(growable: true);




}
