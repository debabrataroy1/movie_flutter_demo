
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_flutter_demo/Constants/api_constants.dart';
import 'package:movie_flutter_demo/Constants/app_constants.dart';
import 'package:movie_flutter_demo/Constants/app_shared_pref.dart';
import 'package:movie_flutter_demo/Constants/app_string_constant.dart';
import 'package:movie_flutter_demo/Utils/common_utility.dart';
import 'state/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState()) { }

  void loginIn(Map request) async{
    if (request[LoginApiKeys.email] == AppData.email && request[LoginApiKeys.password] == AppData.password) {
      AppSharedPref.setEmail(request[LoginApiKeys.email]);
      AppSharedPref.setPassword(AppUtility.encrypt(AppData.encryptKey, request[LoginApiKeys.password]).base64);
      AppSharedPref.setIsLogin(true);
      emit(LoginSuccessState());
    } else {
      emit(LoginError(AppStrings.incorrectPassword));
    }
  }
}