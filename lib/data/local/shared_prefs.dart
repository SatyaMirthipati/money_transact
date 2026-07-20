import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static const String token = "token";
  static const String userId = "userId";
  static const String fullName = "fullName";
  static const String email = "email";
  static const String phone = "phone";
  static const String avatar = "avatar";
  static const String brightness = "brightness";
  static const String restoreId = "locationId";

  static Future<SharedPreferences> get _prefs =>
      SharedPreferences.getInstance();

  static Future<bool> clearPrefs() async {
    final prefs = await _prefs;
    return await prefs.clear();
  }

  static Future<bool> setBrightness(bool isDark) async {
    final prefs = await _prefs;
    return prefs.setBool(brightness, isDark);
  }

  static Future<bool?> getBrightness() async {
    final prefs = await _prefs;
    return prefs.getBool(brightness);
  }

  static Future<bool> setToken(String value) async {
    final prefs = await _prefs;
    return prefs.setString(token, 'Bearer $value');
  }

  static Future<String?> getToken() async {
    final prefs = await _prefs;
    return prefs.getString(token);
  }

  static Future<String> getRestoreId() async {
    final prefs = await _prefs;
    return prefs.get(restoreId).toString();
  }

  static Future setRestoreId(String value) async {
    final prefs = await _prefs;
    return prefs.setString(restoreId, value);
  }

  static Future<bool> setDays(String key, int value) async {
    final prefs = await _prefs;
    return prefs.setInt(key, value);
  }

  static Future<int?> getDays(String key) async {
    final prefs = await _prefs;
    return prefs.getInt(key);
  }

  static Future<String?> getName() async {
    final prefs = await _prefs;
    return prefs.getString(fullName);
  }

  static Future<int?> getUserId() async {
    final prefs = await _prefs;
    return prefs.getInt(userId);
  }

  static Future<String?> getEmail() async {
    final prefs = await _prefs;
    return prefs.getString(email);
  }

  static Future<String?> getMobile() async {
    final prefs = await _prefs;
    return prefs.getString(phone);
  }

  static Future<String?> getAvatar() async {
    final prefs = await _prefs;
    return prefs.getString(avatar);
  }

  static Future<List<String>> getSearchList() async {
    final prefs = await _prefs;
    var list = prefs.getStringList('search');
    print('list = $list');
    return list ?? [];
  }

  static Future<bool> setSearch(String query) async {
    var list = await getSearchList();
    if (list.contains(query)) return false;
    list.add(query);
    if (list.length > 3) list.removeAt(0);
    final prefs = await _prefs;
    print(list);
    return prefs.setStringList('search', list);
  }
}
