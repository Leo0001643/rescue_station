
import 'package:rescue_station/app/db/user_info_table.dart';

class ChatEvent{
  UserInfoTable user;
  UserInfoTable friend;

  ChatEvent(this.user, this.friend);
}


