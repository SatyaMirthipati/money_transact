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

  static Future<bool> clearPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.clear();
  }

  static Future<bool> setBrightness(bool isDark) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(brightness, isDark);
  }

  static Future<bool?> getBrightness() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(brightness);
  }

  static Future<bool> setToken(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(token, 'Bearer $value');
  }

  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(token);
  }

  static Future<String> getRestoreId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get(restoreId).toString();
  }

  static Future setRestoreId(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(restoreId, value);
  }

  static Future<bool> setDays(String key, int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt(key, value);
  }

  static Future<int?> getDays(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key);
  }

  static Future<String?> getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(fullName);
  }

  static Future<int?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(userId);
  }

  static Future<String?> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(email);
  }

  static Future<String?> getMobile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(phone);
  }

  static Future<String?> getAvatar() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(avatar);
  }

  static Future<List<String>> getSearchList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var list = prefs.getStringList('search');
    print('list = $list');
    return list ?? [];
  }

  static Future<bool> setSearch(String query) async {
    var list = await getSearchList();
    if (list.contains(query)) return false;
    list.add(query);
    if (list.length > 3) list.removeAt(0);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(list);
    return prefs.setStringList('search', list);
  }
}
