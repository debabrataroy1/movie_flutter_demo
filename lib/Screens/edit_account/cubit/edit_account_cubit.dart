
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_flutter_demo/Constants/api_constants.dart';
import 'package:movie_flutter_demo/Constants/app_shared_pref_key.dart';
import 'package:movie_flutter_demo/Utils/app_shared_pref.dart';
import 'package:movie_flutter_demo/Screens/edit_account/cubit/state/edit_account_state.dart';
import 'package:movie_flutter_demo/Utils/file_manager.dart';
import 'package:movie_flutter_demo/di/injector.dart';
import 'package:path/path.dart';

class EditAccountCubit extends Cubit<EditAccountState> {
  final FileManager _fileManager;
  final SharedPref _sharedPref;
  EditAccountCubit({FileManager? fileManager, SharedPref? sharedPref}) :
        _fileManager = fileManager ?? AppInjector.getIt<FileManager>(),
        _sharedPref = sharedPref ?? AppInjector.getIt<SharedPref>(),
        super(InitialState());

  void update(Map request) async {
    _sharedPref.setString(key:AppSharedPrefKey.fullName, value:request[LoginApiKeys.name]);
    _sharedPref.setString(key:AppSharedPrefKey.gender, value:request[LoginApiKeys.gender]);
    _sharedPref.setString(key:AppSharedPrefKey.dob, value:request[LoginApiKeys.dob]);
    if (request[LoginApiKeys.image] is File) {
      var path = await _fileManager.saveFile(request[LoginApiKeys.image]);
      _sharedPref.setString(key:AppSharedPrefKey.profileImage, value:basename(path.path));
    }
    emit(SuccessState());
  }
}