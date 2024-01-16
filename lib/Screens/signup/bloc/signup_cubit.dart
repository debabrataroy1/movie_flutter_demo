
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_flutter_demo/Constants/api_constants.dart';
import 'package:movie_flutter_demo/Constants/app_data.dart';
import 'package:movie_flutter_demo/Constants/app_shared_pref.dart';
import 'package:movie_flutter_demo/Screens/signup/bloc/state/signup_state.dart';
import 'package:movie_flutter_demo/Utils/common_utility.dart';
import 'package:movie_flutter_demo/Utils/file_manager.dart';
import 'package:movie_flutter_demo/di/injector.dart';
import 'package:path/path.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitialState());

  void signup(Map request) async {
      var sharedInstance = AppInjector.getIt<AppSharedPref>();
      sharedInstance.setString(key:AppSharedPrefKey.fullName, value:request[LoginApiKeys.name]);
      sharedInstance.setString(key:AppSharedPrefKey.gender, value:request[LoginApiKeys.gender]);
      sharedInstance.setString(key:AppSharedPrefKey.dob, value:request[LoginApiKeys.dob]);
      sharedInstance.setString(key:AppSharedPrefKey.email, value:request[LoginApiKeys.email]);
      sharedInstance.setString(key:AppSharedPrefKey.password,value:AppUtility.encrypt(AppData.encryptKey, request[LoginApiKeys.password]).base64);
      if (request[LoginApiKeys.image] is File) {
        FileManager fileManager = AppInjector.getIt<FileManager>();
        var path = await fileManager.saveFile(request[LoginApiKeys.image]);
       sharedInstance.setString(key:AppSharedPrefKey.profileImage, value:basename(path.path));
      }
      sharedInstance.setBool(key:AppSharedPrefKey.loginStatus,value: true);
      emit(SignupSuccessState());
  }
}