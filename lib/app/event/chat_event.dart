
import 'package:rescue_station/app/domains/user_info_entity.dart';
import 'package:rescue_station/app/domains/group_info_entity.dart';

class ChatEvent{
  UserInfoEntity user;
  UserInfoEntity friend;

  ChatEvent(this.user, this.friend);
}

class ChatGroupEvent{
  UserInfoEntity user;
  GroupInfoEntity group;

  ChatGroupEvent(this.user, this.group);
}
