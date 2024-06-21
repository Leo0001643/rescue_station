
import 'package:hive_flutter/adapters.dart';
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
  }

  Future<Box> getUserBox(){
    return Hive.openBox("userBox");
  }


  Future<Box> getMessageBox(){
    return Hive.openBox("messageBox");
  }


}



