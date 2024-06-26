
import 'package:hive_flutter/adapters.dart';
import 'package:rescue_station/app/db/chat_message_table.dart';
import 'package:rescue_station/app/db/message_box_table.dart';
import 'package:rescue_station/app/db/user_info_table.dart';

class DbHelper {
  DbHelper._internal();

  static DbHelper? instance;

  static getInstance() {
    instance ??= DbHelper._internal();
    return instance;
  }

  factory DbHelper() => getInstance();

  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(MessageBoxTableAdapter());
    Hive.registerAdapter(UserInfoTableAdapter());
    Hive.registerAdapter(ChatMessageTableAdapter());
  }

  Future<Box<UserInfoTable>> getUserBox(){
    return Hive.openBox<UserInfoTable>("userBox");
  }

  Future putUser(int index,UserInfoTable user) async {
    return (await getUserBox()).putAt(index, user);
  }

  Future insertUserOrReplace(UserInfoTable user) async {
    if((await getUserBox()).isEmpty){
      return (await getUserBox()).add(user);
    }else {
      return (await getUserBox()).putAt(0, user);
    }
  }

  ///获取当前登录用户
  Future<UserInfoTable?> getUser() async {
    var box = await getUserBox();
    if(box.isEmpty) return null;
    return box.getAt(0);
  }

  Future<int> clearUser() async {
    return (await getUserBox()).clear();
  }

  Future<Box<MessageBoxTable>> getMessageBox(){
    return Hive.openBox<MessageBoxTable>("messageBox");
  }

  Future<int> addMessageBox(MessageBoxTable message) async {
    return (await getMessageBox()).add(message);
  }

  Future<MessageBoxTable?> findMessageBox(String userId) async {
    try{
      return (await getMessageBox()).values.toList(growable: true).firstWhere((v)=> v.userId == userId);
    }catch(e){
      return null;
    }
  }

  ///查询消息聊天框
  Future<List<MessageBoxTable>> queryMessageBox(String userId) async {
    try{
      return (await getMessageBox()).values.toList(growable: true).where((v)=> v.userId == userId && v.isShow).toList(growable: true);
    } catch(e) {
      return [];
    }
  }

  ///更新消息聊天框
  Future<MessageBoxTable?> updateMessageBox(MessageBoxTable message) async {
    var index = (await getMessageBox()).values.toList(growable: true).indexOf(message);
    (await getMessageBox()).putAt(index, message);
  }

  Future putMessageBox(MessageBoxTable message) async {
    return (await getMessageBox()).add(message);
  }


  Future<Box<ChatMessageTable>> getChatMessageBox(){
    return Hive.openBox<ChatMessageTable>("chatMessageBox");
  }

  Future<int> addChatMessageBox(ChatMessageTable message) async {
    return (await getChatMessageBox()).add(message);
  }

  ///查询聊天记录
  Future<List<ChatMessageTable>> queryChatMessageBox(String userId) async {
    try{
      return (await getChatMessageBox()).values.toList(growable: true).where((v)=> v.fromInfo?.userId == userId).toList(growable: true);
    }catch(e){
      return [];
    }
  }










}



