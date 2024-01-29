import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_flutter_demo/Constants/api_constants.dart';
import 'package:movie_flutter_demo/Constants/app_data.dart';
import 'package:movie_flutter_demo/Constants/app_shared_pref_key.dart';
import 'package:movie_flutter_demo/Utils/app_localization.dart';
import 'package:movie_flutter_demo/Utils/app_shared_pref.dart';
import 'package:movie_flutter_demo/Utils/app_encryption.dart';
import 'package:movie_flutter_demo/di/injector.dart';
import 'state/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final TextEditingController emailEditingController = TextEditingController();
  final TextEditingController passwordEditingController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  final SharedPref _appSharedPref;
  final Encryption _encryption;
  LoginCubit({SharedPref? sharedPref, Encryption? encryption}) :
        _appSharedPref = sharedPref ?? AppInjector.getIt<SharedPref>(),
        _encryption = encryption ?? AppInjector.getIt<Encryption>(),
        super(LoginInitialState());

  void loginIn(Map request) async {
    try {
      if (request[LoginApiKeys.email] ==
          _appSharedPref.getString(key: AppSharedPrefKey.email)
          && request[LoginApiKeys.password] == _encryption.decrypt(
              AppData.encryptKey,
              _appSharedPref.getString(key: AppSharedPrefKey.password))) {
        _appSharedPref.setString(
            key: AppSharedPrefKey.email, value: request[LoginApiKeys.email]);
        _appSharedPref.setString(
            key: AppSharedPrefKey.password, value: _encryption
            .encrypt(AppData.encryptKey, request[LoginApiKeys.password]));
        _appSharedPref.setBool(key: AppSharedPrefKey.loginStatus, value: true);
        emit(LoginSuccessState());
      } else {
        emit(LoginError(AppLocalization.instance.keys.incorrectPassword));
      }
    } catch (error) {
      emit(LoginError(error.toString()));
    }
  }
  void validateForm() async {
    if (formKey.currentState?.validate() == true) {
      var params = {LoginApiKeys.email: emailEditingController.text,
        LoginApiKeys.password: passwordEditingController.text
      };
      loginIn(params);
    }
  }
}