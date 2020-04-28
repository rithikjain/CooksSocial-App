import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static void setUserPhoneNum(String no) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("PREF_USER_PHONE", no);
  } 

  static Future<String> getUserPhoneNum() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("PREF_USER_PHONE");
  }

  static void setUserAuthToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("PREF_USER_TOKEN", token);
  }

  static Future<String> getUserAuthToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("PREF_USER_TOKEN");
  }
}