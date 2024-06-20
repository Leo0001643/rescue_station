
import 'package:hive_flutter/adapters.dart';

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
    // Hive.registerAdapter(adapter);
  }



}



