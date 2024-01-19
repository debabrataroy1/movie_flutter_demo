
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_flutter_demo/Constants/api_constants.dart';
import 'package:movie_flutter_demo/Constants/app_shared_pref.dart';
import 'package:movie_flutter_demo/Screens/edit_account/cubit/state/edit_account_state.dart';
import 'package:movie_flutter_demo/Utils/file_manager.dart';
import 'package:movie_flutter_demo/di/injector.dart';
import 'package:path/path.dart';

class EditAccountCubit extends Cubit<EditAccountState> {
  EditAccountCubit() : super(InitialState());

  void update(Map request) async {
    var sharedInstance = AppInjector.getIt<AppSharedPref>();
    sharedInstance.setString(key:AppSharedPrefKey.fullName, value:request[LoginApiKeys.name]);
    sharedInstance.setString(key:AppSharedPrefKey.gender, value:request[LoginApiKeys.gender]);
    sharedInstance.setString(key:AppSharedPrefKey.dob, value:request[LoginApiKeys.dob]);
    if (request[LoginApiKeys.image] is File) {
      FileManager fileManager = AppInjector.getIt<FileManager>();
      var path = await fileManager.saveFile(request[LoginApiKeys.image]);
      sharedInstance.setString(key:AppSharedPrefKey.profileImage, value:basename(path.path));
    }
    emit(SuccessState());
  }
}