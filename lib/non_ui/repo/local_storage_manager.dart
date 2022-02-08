import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  LocalStorage._();

  static LocalStorage _instance = LocalStorage._();

  static LocalStorage get shared => _instance;

  Future<SharedPreferences> _prefs() async =>
      await SharedPreferences.getInstance();

  Future<String> getStringData(
      {required String key, required String defaultValue}) async {
    final prefs = await _prefs();
    return prefs.getString(key) ?? defaultValue;
  }

  Future<List<String>> getStringListData(
      {required String key, required List<String> defaultValue}) async {
    final prefs = await _prefs();
    return prefs.getStringList(key) ?? defaultValue;
  }

  Future<bool> saveStringData(
      {required String value, required String key}) async {
    final prefs = await _prefs();
    return prefs.setString(key, value);
  }

  Future<bool> saveStringListData(
      {required List<String> value, required String key}) async {
    final prefs = await _prefs();
    return prefs.setStringList(key, value);
  }
}
