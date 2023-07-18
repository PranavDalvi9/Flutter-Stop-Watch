import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  /// set string to preference
  static Future<void> setPrefString({required String key, required String value}) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString(key, value);
  }

  /// get string to preference
  static Future<String> getPrefString({required String key}) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(key) ?? "";
  }

  /// set int from preference
  static Future<void> setPrefInt({required String key, required int value}) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setInt(key, value);
  }

  /// get int from preference
  static Future<int> getPrefInt({required String key}) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getInt(key) ?? 0;
  }

  /// set boolean to preference
  static Future<void> setPrefBoolean({required String key, required bool value}) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setBool(key, value);
  }

  /// get boolean to preference
  static Future<bool> getPrefBoolean({required String key}) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool(key) ?? false;
  }

  /// check whether key is available or not.
  static Future<bool> checkKey({required String key}) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    bool checkValue = pref.containsKey(key);
    return checkValue;
  }

  /// clear all shared preference data
  static Future<void> clearAllPrefValue() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.clear();
  }

  static Future<void> removeKey({required String key}) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.remove(key);
  }
}
