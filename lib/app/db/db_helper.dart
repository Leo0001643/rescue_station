
import 'package:rescue_station/app/db/chat_message_table.dart';
import 'package:rescue_station/app/db/message_box_table.dart';
import 'package:rescue_station/app/utils/logger.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  DbHelper._internal();

  static DbHelper? instance;

  static getInstance() {
    instance ??= DbHelper._internal();
    return instance;
  }

  factory DbHelper() => getInstance();

  late Database db;

  var messageTable = "MessageTable";
  var chatMessageTable = "ChatMessageTable";

  Future<void> init() async {
    var version = 1;
    db = await openDatabase("rescue.db",version: version,onCreate: (db,ver) async {
      await db.execute('CREATE TABLE $messageTable (id integer primary key autoincrement, userId TEXT, boxId TEXT, boxType INTEGER,'
          ' lastMessage TEXT, lastMessageTime INTEGER, unreadCount INTEGER, isTop INTEGER, isDisturb INTEGER, isGroup INTEGER, fromInfo TEXT, isShow INTEGER)');

      await db.execute('CREATE TABLE $chatMessageTable (id integer primary key autoincrement, msgId TEXT, pushType TEXT,'
          ' msgContent TEXT, fromInfo TEXT, createTime TEXT, isTop INTEGER, groupInfo TEXT, userId TEXT)');
    });

    // await Hive.initFlutter();
    // Hive.registerAdapter(MessageBoxTableAdapter());
    // Hive.registerAdapter(UserInfoTableAdapter());
    // Hive.registerAdapter(ChatMessageTableAdapter());
  }

  void close(){
    db.close();
  }

  // Future<Box<UserInfoTable>> getUserBox(){
  //   return Hive.openBox<UserInfoTable>("userBox");
  // }

  // Future putUser(int index,UserInfoTable user) async {
  //   return (await getUserBox()).putAt(index, user);
  // }

  // ///这里会保持只有一个用户信息
  // Future insertUserOrReplace(UserInfoTable user) async {
  //   if((await getUserBox()).isEmpty){
  //     return (await getUserBox()).add(user);
  //   } else if(user.isInBox){
  //     return putUser(user.key, user);
  //   } else {
  //     return putUser(0, user);
  //   }
  // }

  // ///获取当前登录用户
  // Future<UserInfoTable?> getUser() async {
  //   var box = await getUserBox();
  //   if(box.isEmpty) return null;
  //   return box.getAt(0);
  // }

  // Future<int> clearUser() async {
  //   return (await getUserBox()).clear();
  // }

  // Future<Box<MessageBoxTable>> getMessageBox(){
  //   return Hive.openBox<MessageBoxTable>("messageBox");
  // }

  Future<int> addMessageBox(MessageBoxTable message) async {
    return db.insert(messageTable, message.toJson());
    // return (await getMessageBox()).add(message);
  }

  ///查询跟好友的聊天记录
  Future<MessageBoxTable?> findMessageBox(String boxId) async {
    try{
      var list = await db.query(messageTable,where: "boxId = ?",whereArgs: [boxId]);
      if(list.isEmpty){
        return null;
      }
      return list.map((value)=> MessageBoxTable.fromJson(value)).toList(growable: true).first;
      // return (await getMessageBox()).values.toList(growable: true).firstWhere((v)=> v.boxId == userId);
    }catch(e){
      return null;
    }
  }



  ///查询消息聊天框
  ///查询登录用户的聊天记录
  Future<List<MessageBoxTable>> queryMessageBox(String userId) async {
    try{
      var list = await db.query(messageTable,where: "userId = ?",whereArgs: [userId]);
      return list.map((value)=> MessageBoxTable.fromJson(value)).toList(growable: true);
      // return (await getMessageBox()).values.toList(growable: true).where((v)=> v.boxId == userId && v.isShow).toList(growable: true);
    } catch(e) {
      return [];
    }
  }

  ///查询消息聊天框
  Future<List<MessageBoxTable>> queryMessageAll() async {
    try{
      var list = await db.query(messageTable);
      return list.map((value)=> MessageBoxTable.fromJson(value)).toList(growable: true);
      // return (await getMessageBox()).values.toList(growable: true).where((v)=> v.boxId == userId && v.isShow).toList(growable: true);
    } catch(e) {
      return [];
    }
  }

  ///更新消息聊天框
  Future<int> updateMessageBox(MessageBoxTable message) async {
    // var index = (await getMessageBox()).values.toList().indexOf(message);
    try{
      return db.update(messageTable, message.toJson(),where: 'id = ?',whereArgs: [message.id]);
    }catch(e){
      logger(e);
      return 0;
    }
  }

  ///删除消息聊天框
  Future deleteMessageBox(String userId) async {
    try{
      ///删除聊天框
      await db.delete(messageTable,where: 'userId = ?',whereArgs: [userId]);
      // var message = await findMessageBox(userId);
      // if(ObjectUtil.isNotEmpty(message) && message!.isInBox){
      //   // var index = (await getMessageBox()).values.toList().indexOf(message!);
      //   (await getMessageBox()).delete(message.key);
      // }
      ///需要同步删除历史聊天记录
      await db.delete(chatMessageTable,where: 'userId = ?', whereArgs: [userId]);
      // var list = await queryChatMessageBox(userId);
      // for (var chat in list) {
      //   // var index = (await getChatMessageBox()).values.toList().indexOf(chat);
      //   (await getChatMessageBox()).delete(chat.key);
      // }
      return true;
    } catch(e) {
      logger(e);
      return false;
    }
  }

  // Future<Box<ChatMessageTable>> getChatMessageBox(){
  //   return Hive.openBox<ChatMessageTable>("chatMessageBox");
  // }

  Future<int> addChatMessageBox(ChatMessageTable message) async {
    return db.insert(chatMessageTable, message.toJson());
  }

  ///查询聊天记录
  Future<List<ChatMessageTable>> queryChatMessageBox(String userId) async {
    try{
      var list = await db.query(chatMessageTable,where: 'userId = ?',whereArgs: [userId]);
      return list.map((value)=> ChatMessageTable.fromJson(value)).toList(growable: true);
      // return (await getChatMessageBox()).values.toList(growable: true).where((v)=> v.fromInfo?['userId'] == userId).toList(growable: true);
    }catch(e){
      return [];
    }
  }

  ///查询聊天记录
  Future<List<ChatMessageTable>> queryChatMessageAll() async {
    try{
      var list = await db.query(chatMessageTable);
      return list.map((value)=> ChatMessageTable.fromJson(value)).toList(growable: true);
      // return (await getChatMessageBox()).values.toList(growable: true).where((v)=> v.fromInfo?['userId'] == userId).toList(growable: true);
    }catch(e){
      return [];
    }
  }








}



