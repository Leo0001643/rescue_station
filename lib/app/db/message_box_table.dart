
import 'package:hive/hive.dart';
import 'package:rescue_station/app/db/user_info_table.dart';
part 'message_box_table.g.dart';

@HiveType(typeId: 0)
class MessageBoxTable extends HiveObject{
  @HiveField(0)
  int? boxId;

  @HiveField(1)
  String? userId;

  @HiveField(2,defaultValue: 0)
  int boxType = 0;///0 单聊 1 群聊

  @HiveField(3)
  dynamic lastMessage;///最后一天消息

  @HiveField(4)
  int? lastMessageTime;///最后一条消息时间

  @HiveField(5)
  int? unreadCount;///消息未读数量

  @HiveField(6,defaultValue: false)
  bool isTop = false;///是否置顶

  @HiveField(7,defaultValue: false)
  bool isDisturb = false;///是否免打扰

  @HiveField(8,defaultValue: false)
  bool isGroup = false;///是否是群聊

  @HiveField(9)
  UserInfoTable? friend;///单聊好友信息

  @HiveField(10)
  dynamic group;///群聊信息

}


