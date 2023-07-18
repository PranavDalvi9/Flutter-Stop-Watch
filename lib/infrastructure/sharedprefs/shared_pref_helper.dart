import 'package:shared_preferences/shared_preferences.dart';
import 'package:stop_watch_application/infrastructure/sharedprefs/shared_prefs.dart';

import '../commons/storage_constants.dart';

class SharedPrefHelper {
  static SharedPrefHelper? _instance;
  static SharedPreferences? _preferences;
  static Future<SharedPrefHelper?> getInstance() async {
    _instance ??= SharedPrefHelper();
    _preferences ??= await SharedPreferences.getInstance();
    return _instance;
  }

  // lapHistoryData
  Future<String> get getLapHistory async {
    return Prefs.getPrefString(key: StorageConstants.lapHistoryData);
  }

  Future<void> setLapHistory(String data) async {
    await Prefs.setPrefString(key: StorageConstants.lapHistoryData, value: data);
  }

  // differenceHistory
  Future<String> get getDifferenceHistory async {
    return Prefs.getPrefString(key: StorageConstants.differenceHistory);
  }

  Future<void> setDifferenceHistory(String data) async {
    await Prefs.setPrefString(key: StorageConstants.differenceHistory, value: data);
  }

  // data
  Future<String> get getDataHistory async {
    return Prefs.getPrefString(key: StorageConstants.data);
  }

  Future<void> setDataHistory(String data) async {
    await Prefs.setPrefString(key: StorageConstants.data, value: data);
  }

  // Clear Preference
  Future<void> clearPref() async {
    return await Prefs.clearAllPrefValue();
  }
}
