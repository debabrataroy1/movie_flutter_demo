import 'dart:io';
import 'package:movie_flutter_demo/Constants/app_data.dart';
import 'package:movie_flutter_demo/Constants/app_shared_pref_key.dart';
import 'package:movie_flutter_demo/Utils/app_encryption.dart';
import 'package:movie_flutter_demo/Utils/app_shared_pref.dart';
import 'package:movie_flutter_demo/Utils/file_manager.dart';
import 'package:movie_flutter_demo/di/injector.dart';
import 'package:path/path.dart';

class User {
  String? name;
  String? email;
  String? password;
  String? gender;
  String? dob;
  File? profileImage;
  final SharedPref _appSharedPref;
  final FileManager _fileManager;
  final Encryption _encryption;
  User({SharedPref? sharedPref, FileManager? fileManager, Encryption? encryption}) :
        _appSharedPref = sharedPref ?? AppInjector.getIt<SharedPref>(),
        _encryption = encryption ?? AppInjector.getIt<Encryption>(),
        _fileManager = fileManager ?? AppInjector.getIt<FileManager>() {
    _init();
  }
  _init() async {
    name = _appSharedPref.getString(key: AppSharedPrefKey.fullName);
    email = _appSharedPref.getString(key: AppSharedPrefKey.email);
    dob = _appSharedPref.getString(key: AppSharedPrefKey.dob);
    gender = _appSharedPref.getString(key: AppSharedPrefKey.gender);
    password = _appSharedPref.getString(key: AppSharedPrefKey.password);
    profileImage = await _fileManager.getFile(_appSharedPref.getString(key: AppSharedPrefKey.profileImage));
  }

  update() async {
    _appSharedPref.setString(key:AppSharedPrefKey.fullName, value: name ?? '');
    _appSharedPref.setString(key:AppSharedPrefKey.gender, value: gender ?? '');
    _appSharedPref.setString(key:AppSharedPrefKey.dob, value: dob ?? '');
    _appSharedPref.setString(key:AppSharedPrefKey.email, value: email ?? '');
    _appSharedPref.setString(key:AppSharedPrefKey.password,value:_encryption.encrypt(AppData.encryptKey, password ?? ''));
    if (profileImage != null) {
      var path = await _fileManager.saveFile(profileImage!);
      _appSharedPref.setString(key:AppSharedPrefKey.profileImage, value:basename(path.path));
    }
    _appSharedPref.setBool(key:AppSharedPrefKey.loginStatus,value: true);
  }

  clean() {
    name = null;
    email = null;
    dob = null;
    gender = null;
    password = null;
    profileImage = null;
  }
}