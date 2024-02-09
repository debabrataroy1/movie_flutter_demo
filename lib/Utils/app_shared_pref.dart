import 'package:movie_flutter_demo/Constants/app_shared_pref_key.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SharedPref {
  void setString({required AppSharedPrefKey key, required String value});
  String getString({required AppSharedPrefKey key});
  void setBool({required AppSharedPrefKey key, required bool value});
  bool getBool({required AppSharedPrefKey key});
  void remove(AppSharedPrefKey key);
  void clear();
}

class AppSharedPref implements SharedPref {
  SharedPreferences? _pref;
  AppSharedPref() {
    _setup();
  }

  _setup() async{
    _pref = await SharedPreferences.getInstance();
  }

  @override
  void setString({required AppSharedPrefKey key, required String value}) {
    _pref?.setString(key.name, value);
  }

  @override
  String getString({required AppSharedPrefKey key}) {
    return _pref?.getString(key.name) ?? "";
  }

  @override
  setBool({required AppSharedPrefKey key, required bool value}) {
    _pref?.setBool(key.name, value);
  }

  @override
  bool getBool({required AppSharedPrefKey key}) {
    return _pref?.getBool(key.name) ?? false;
  }

  @override
  void remove(AppSharedPrefKey key){
    _pref?.remove(key.name);
  }

  @override
  void clear() async {
    _pref?.clear();
  }
}
