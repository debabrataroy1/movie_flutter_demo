import 'package:shared_preferences/shared_preferences.dart';

enum AppSharedPrefKey {
  email,
  password,
  loginStatus
}

class AppSharedPref {

   setString({required AppSharedPrefKey key, required String value}) async {

    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(key.name, value);
  }

   Future<String> getString({required AppSharedPrefKey key}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(key.name) ?? "";
  }

   setBool({required AppSharedPrefKey key, required bool value}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(key.name, value);
  }

   Future<bool> getBool({required AppSharedPrefKey key}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool(key.name) ?? false;
  }

   void clear() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
  }
}
