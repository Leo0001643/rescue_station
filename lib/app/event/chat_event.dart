
import 'package:rescue_station/app/db/user_info_table.dart';
import 'package:rescue_station/app/modules/contacts_module/group_list/group_info_entity.dart';

class ChatEvent{
  UserInfoTable user;
  UserInfoTable friend;

  ChatEvent(this.user, this.friend);
}

class ChatGroupEvent{
  UserInfoTable user;
  GroupInfoEntity group;

  ChatGroupEvent(this.user, this.group);
}
