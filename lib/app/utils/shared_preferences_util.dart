import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtil {
  static SharedPreferences? _preferences;

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future<bool> setString(String key, String value) async {
    if (_preferences == null) await init();
    return _preferences!.setString(key, value);
  }

  static String? getString(String key, {String? defaultValue}) {
    if (_preferences == null) return defaultValue;
    return _preferences!.getString(key) ?? defaultValue;
  }

  static Future<bool> setInt(String key, int value) async {
    if (_preferences == null) await init();
    return _preferences!.setInt(key, value);
  }

  static int? getInt(String key, {int? defaultValue}) {
    if (_preferences == null) return defaultValue;
    return _preferences!.getInt(key) ?? defaultValue;
  }

  static Future<bool> setBool(String key, bool value) async {
    if (_preferences == null) await init();
    return _preferences!.setBool(key, value);
  }

  static bool? getBool(String key, {bool? defaultValue}) {
    if (_preferences == null) return defaultValue;
    return _preferences!.getBool(key) ?? defaultValue;
  }

  static Future<bool> setDouble(String key, double value) async {
    if (_preferences == null) await init();
    return _preferences!.setDouble(key, value);
  }

  static double? getDouble(String key, {double? defaultValue}) {
    if (_preferences == null) return defaultValue;
    return _preferences!.getDouble(key) ?? defaultValue;
  }

  static Future<bool> setStringList(String key, List<String> value) async {
    if (_preferences == null) await init();
    return _preferences!.setStringList(key, value);
  }

  static List<String>? getStringList(String key, {List<String>? defaultValue}) {
    if (_preferences == null) return defaultValue;
    return _preferences!.getStringList(key) ?? defaultValue;
  }

  static Future<bool> remove(String key) async {
    if (_preferences == null) await init();
    return _preferences!.remove(key);
  }

  static Future<bool> clear() async {
    if (_preferences == null) await init();
    return _preferences!.clear();
  }
}