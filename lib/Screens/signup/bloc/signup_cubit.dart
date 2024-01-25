
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_flutter_demo/Constants/api_constants.dart';
import 'package:movie_flutter_demo/Constants/app_data.dart';
import 'package:movie_flutter_demo/Constants/app_shared_pref_key.dart';
import 'package:movie_flutter_demo/Utils/app_shared_pref.dart';
import 'package:movie_flutter_demo/Screens/signup/bloc/state/signup_state.dart';
import 'package:movie_flutter_demo/Utils/app_encryption.dart';
import 'package:movie_flutter_demo/Utils/file_manager.dart';
import 'package:movie_flutter_demo/di/injector.dart';
import 'package:path/path.dart';

class SignupCubit extends Cubit<SignupState> {
  final TextEditingController emailEditingController = TextEditingController();
  final TextEditingController passwordEditingController = TextEditingController();
  final TextEditingController dobEditingController = TextEditingController();
  final TextEditingController nameEditingController = TextEditingController();
  final TextEditingController confirmPasswordEditingController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  final SharedPref _appSharedPref;
  final Encryption _encryption;
  final FileManager _fileManager;
  File? pickedImage;
  String gender = "";

  SignupCubit({SharedPref? sharedPref, Encryption? encryption, FileManager? fileManager}) :
        _appSharedPref = sharedPref ?? AppInjector.getIt<SharedPref>(),
        _encryption = encryption ?? AppInjector.getIt<Encryption>(),
        _fileManager = fileManager ?? AppInjector.getIt<FileManager>(),
        super(SignupInitialState());

  void _signup(Map request) async {
    _appSharedPref.setString(key:AppSharedPrefKey.fullName, value:request[LoginApiKeys.name]);
    _appSharedPref.setString(key:AppSharedPrefKey.gender, value:request[LoginApiKeys.gender]);
    _appSharedPref.setString(key:AppSharedPrefKey.dob, value:request[LoginApiKeys.dob]);
    _appSharedPref.setString(key:AppSharedPrefKey.email, value:request[LoginApiKeys.email]);
    _appSharedPref.setString(key:AppSharedPrefKey.password,value:_encryption.encrypt(AppData.encryptKey, request[LoginApiKeys.password]));
      if (request[LoginApiKeys.image] is File) {
        var path = await _fileManager.saveFile(request[LoginApiKeys.image]);
        _appSharedPref.setString(key:AppSharedPrefKey.profileImage, value:basename(path.path));
      }
    _appSharedPref.setBool(key:AppSharedPrefKey.loginStatus,value: true);
      emit(SignupSuccessState());
  }

  void validateForm() async {
    if (formKey.currentState?.validate() == true) {
      Map<String, dynamic> params = {LoginApiKeys.email: emailEditingController.text,
        LoginApiKeys.password: passwordEditingController.text,
        LoginApiKeys.name: nameEditingController.text,
        LoginApiKeys.dob: dobEditingController.text,
        LoginApiKeys.gender: gender
      };
      if (pickedImage != null) {
        params[LoginApiKeys.image] = pickedImage;
      }
      _signup(params);
    }
  }

  void updateGender(String value) async{
    gender = value;
    emit(GenderState());
  }

}