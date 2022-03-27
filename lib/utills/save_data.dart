import 'package:shared_preferences/shared_preferences.dart';

class SaveData {
  static String userSaveKey = "userKey";
  static Future<String?> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userSaveKey);
  }

  static Future<bool> saveUserData(String userData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userSaveKey,userData);
  }

  static Future<bool> clearValues() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }
}
