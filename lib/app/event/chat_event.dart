
import 'package:rescue_station/app/db/message_box_table.dart';
import 'package:rescue_station/app/domains/user_info_entity.dart';
import 'package:rescue_station/app/domains/group_info_entity.dart';

class ChatEvent{
  UserInfoEntity user;
  UserInfoEntity friend;
  MessageBoxTable messageBox;

  ChatEvent(this.user, this.friend,this.messageBox);
}

class ChatGroupEvent{
  UserInfoEntity user;
  GroupInfoEntity group;
  MessageBoxTable messageBox;

  ChatGroupEvent(this.user, this.group,this.messageBox);
}

///清空聊天记录的事件
class ChartHistoryClearEvent{

}
