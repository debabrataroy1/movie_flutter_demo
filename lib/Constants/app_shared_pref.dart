import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPref {
  static const String email = "emailId";
  static const String password = "username";
  static const String loginStatus = "loginStatus";

  static setEmail(String email) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(email, email);
  }

  static Future<String> getEmail() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(email) ?? "";
  }

  static setIsLogin(bool isLogin) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(loginStatus, isLogin);
  }

  static Future<bool> isLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool isLogin = pref.getBool(loginStatus) ?? false;
    return isLogin;
  }

  static setPassword(String value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(password, value);
  }

  static Future<String> getPassword() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(password) ?? "";
  }
  static void clear() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
  }
}
