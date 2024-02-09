import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_flutter_demo/Constants/api_constants.dart';
import 'package:movie_flutter_demo/Constants/app_data.dart';
import 'package:movie_flutter_demo/Constants/app_shared_pref_key.dart';
import 'package:movie_flutter_demo/Utils/app_localization.dart';
import 'package:movie_flutter_demo/Utils/app_shared_pref.dart';
import 'package:movie_flutter_demo/Screens/change_password/cubit/state/change_password_state.dart';
import 'package:movie_flutter_demo/Utils/app_encryption.dart';
import 'package:movie_flutter_demo/di/injector.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final SharedPref _appSharedPref;
  final Encryption _encryption;
  ChangePasswordCubit({SharedPref? sharedPref, Encryption? encryption}) :
        _appSharedPref = sharedPref ?? AppInjector.getIt<SharedPref>(),
        _encryption = encryption ?? AppInjector.getIt<Encryption>(),
        super(InitialState());

  void update(Map request) async {
    if (request[LoginApiKeys.oldPassword] == _encryption.decrypt(AppData.encryptKey,
        _appSharedPref.getString(key: AppSharedPrefKey.password))) {
      _appSharedPref.setString(key: AppSharedPrefKey.password, value: _encryption
          .encrypt(AppData.encryptKey, request[LoginApiKeys.password]));
      emit(SuccessState());
    } else {
      emit(ErrorState(AppLocalization.instance.keys.passwordMismatch));
    }
  }
}