
import 'package:rescue_station/app/db/message_box_table.dart';
import 'package:rescue_station/app/domains/group_detail_entity.dart';
import 'package:rescue_station/app/event/chat_event.dart';

class EditGroupEvent{
  GroupDetailEntity group;
  ChatGroupEvent event;

  EditGroupEvent(this.group,this.event);
}



