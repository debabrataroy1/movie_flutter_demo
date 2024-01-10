
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_flutter_demo/Constants/api_constants.dart';
import 'package:movie_flutter_demo/Constants/app_data.dart';
import 'package:movie_flutter_demo/Constants/app_shared_pref.dart';
import 'package:movie_flutter_demo/Constants/app_string_constant.dart';
import 'package:movie_flutter_demo/Utils/common_utility.dart';
import 'package:movie_flutter_demo/di/injector.dart';
import 'state/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState()) { }

  void loginIn(Map request) async{
    if (request[LoginApiKeys.email] == AppData.email && request[LoginApiKeys.password] == AppData.password) {
      var sharedInstance = AppInjector.getIt<AppSharedPref>();
      sharedInstance.setString(key:AppSharedPrefKey.email,value:request[LoginApiKeys.email]);
      sharedInstance.setString(key:AppSharedPrefKey.password,value:AppUtility.encrypt(AppData.encryptKey, request[LoginApiKeys.password]).base64);
      sharedInstance.setBool(key:AppSharedPrefKey.loginStatus,value: true);
      emit(LoginSuccessState());
    } else {
      emit(LoginError(AppStrings.incorrectPassword));
    }
  }
}