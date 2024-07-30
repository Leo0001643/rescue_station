
import 'dart:convert';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:rescue_station/app/db/chat_message_table.dart';
import 'package:rescue_station/app/db/message_box_table.dart';
import 'package:rescue_station/app/routes/app_pages.dart';
import 'package:rescue_station/app/socket/socket_message_entity.dart';
import 'package:rescue_station/app/utils/app_data.dart';
import 'package:rescue_station/app/utils/logger.dart';
import 'package:rescue_station/app/utils/widget_utils.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';



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
    if(kIsWeb){
      db = await databaseFactoryFfiWeb.openDatabase("rescue.db",
          options: OpenDatabaseOptions(
            version: version,
            onCreate: createDbForm,
          ));
    } else {
      db = await openDatabase("rescue.db",version: version,onCreate: createDbForm);
    }
  }


  void createDbForm(db,ver) async {
    await db.execute('CREATE TABLE $messageTable (id integer primary key autoincrement, userId TEXT, boxId TEXT, boxType INTEGER,'
        ' lastMessage TEXT, lastMessageTime INTEGER, unreadCount INTEGER, isTop INTEGER, isDisturb INTEGER, fromInfo TEXT, isShow INTEGER)');

    await db.execute('CREATE TABLE $chatMessageTable (id integer primary key autoincrement, msgId TEXT, pushType TEXT,'
        ' msgContent TEXT, fromInfo TEXT, createTime TEXT, isTop INTEGER, groupInfo TEXT, boxId TEXT, userId TEXT)');
  }


  void close(){
    db.close();
  }


  Future<int> addMessageBox(MessageBoxTable message) async {
    loggerArray(["添加新聊天了",message.userId,message.boxId,]);
    return db.insert(messageTable, message.toJson());
    // return (await getMessageBox()).add(message);
  }

  ///根据当前登录人的userid查询跟好友的聊天记录
  Future<MessageBoxTable?> findMessageBox(String userId,String boxId) async {
    try{
      var list = await db.query(messageTable,where: "userId = ? and boxId = ?",whereArgs: [userId,boxId]);
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
      var list = await db.query(messageTable,where: "userId = ? ORDER BY isTop DESC, lastMessageTime DESC",whereArgs: [userId]);
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
      loggerArray(["更新聊天了",message.userId,message.boxId,]);
      return db.update(messageTable, message.toJson(),where: 'id = ?',whereArgs: [message.id]);
    }catch(e){
      logger(e);
      return 0;
    }
  }

  ///删除消息聊天框
  Future deleteMessageBox(String userId,String boxId) async {
    try{
      var msgBox = await findMessageBox(userId,boxId);

      ///需要同步删除历史聊天记录
      await db.delete(chatMessageTable,where: 'boxId = ?', whereArgs: [msgBox?.boxId]);

      ///删除聊天框
      await db.delete(messageTable,where: 'userId = ? and boxId = ?',whereArgs: [userId,msgBox?.boxId]);
      return true;
    } catch(e) {
      logger(e);
      return false;
    }
  }

  ///删除历史消息
  Future deleteHistoryMessage(String userId,String boxId) async {
    try{
      var msgBox = await findMessageBox(userId,boxId);

      ///需要同步删除历史聊天记录
      await db.delete(chatMessageTable,where: 'boxId = ?', whereArgs: [msgBox!.boxId]);
      ///删除最后一条消息，更新聊天框表缓存
      msgBox.lastMessage = null;
      await updateMessageBox(msgBox);
      return true;
    } catch(e) {
      logger(e);
      return false;
    }
  }


  Future<int> addChatMessageBox(ChatMessageTable message) async {
    ///根据msgId查询有没有存储过这条消息，存储过则返回不再存储
    if(isNotEmpty(message.msgId)){
      var list = await db.query(chatMessageTable,where: "msgId = ?",whereArgs: [message.msgId]);
      if(list.isNotEmpty){
        return 0;
      }
    }
    return db.insert(chatMessageTable, message.toJson());
  }

  ///查询聊天记录
  Future<List<ChatMessageTable>> queryChatMessageBox(String userId,String boxId) async {
    try{
      var list = await db.query(chatMessageTable,where: 'userId = ? and boxId = ?',whereArgs: [userId,boxId]);
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

  ///更新数据库中消息或者插入消息
  ///处理消息已读未读数量
  Future<void> messageInsertOrUpdate(bool isSend,SocketMessageEntity message) async {
    var isFriend = isEmpty(message.groupInfo?.groupId);
    if(!isSend){///如果不是发送者，需要定义boxId
      message.boxId = isFriend ? message.fromInfo!.userId.em() : message.groupInfo!.groupId.em();
    }
    var user = AppData.getUser()!;
    if(message.msgContent != null){
      ///缓存消息到数据库
      var count = await DbHelper().addChatMessageBox(ChatMessageTable.fromJson2(user.userId.em(),
          message.boxId!,isSend ? AppData.getUser()!:message.fromInfo!,message));
      ///存在已经存储过的聊天消息，不需要更新
      if(count == 0){
        return;
      }
    }
    var userId = user.userId.em();
    var v = await DbHelper().findMessageBox(userId.em(),message.boxId!);
    if(isEmpty(v)){
      ///boxId为聊天好友的id
      var boxType = isFriend ? 0 : 1;
      var fromInfo = isFriend ? jsonEncode(message.fromInfo?.toJson()) : jsonEncode(message.groupInfo?.toJson());
      ///如果不是发送者，而且消息内容不为空,则默认消息未读数为1
      var unreadCount = (!isSend && isNotEmpty(message.msgContent)) ? 1 : 0;
      await DbHelper().addMessageBox(MessageBoxTable(userId: userId, boxId: message.boxId, boxType: boxType, lastMessage: jsonEncode(message.msgContent?.toJson()),
          lastMessageTime: DateUtil.getDateMsByTimeStr(message.createTime.em()),unreadCount: unreadCount,fromInfo: fromInfo));
    } else {
      var fromInfo = v!.isGroup()==false ? jsonEncode(message.fromInfo?.toJson()) : jsonEncode(message.groupInfo?.toJson());
      v.fromInfo = fromInfo;
      v.lastMessageTime = DateUtil.getDateMsByTimeStr(message.createTime.em());
      v.lastMessage = jsonEncode(message.msgContent?.toJson());
      v.unreadCount = isSend ? v.unreadCount : (v.unreadCount ?? 0) + 1;
      await DbHelper().updateMessageBox(v);
    }
  }

  ///标记消息已读
  Future<bool> setMessageRead(MessageBoxTable table) async {
    if(table.unreadCount != 0){
      table.unreadCount = 0;
      var res = await updateMessageBox(table);
      return res > 0;
    }
    return false;
  }


}



