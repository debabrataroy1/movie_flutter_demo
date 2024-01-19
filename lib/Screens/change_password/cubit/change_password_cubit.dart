
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_flutter_demo/Constants/api_constants.dart';
import 'package:movie_flutter_demo/Constants/app_data.dart';
import 'package:movie_flutter_demo/Constants/app_shared_pref.dart';
import 'package:movie_flutter_demo/Extensions/build_context_extension.dart';
import 'package:movie_flutter_demo/Screens/change_password/cubit/state/change_password_state.dart';
import 'package:movie_flutter_demo/Utils/common_utility.dart';
import 'package:movie_flutter_demo/di/injector.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit() : super(InitialState());

  void update(BuildContext context, Map request) async {
    var sharedInstance = AppInjector.getIt<AppSharedPref>();
    if (request[LoginApiKeys.oldPassword] == AppUtility.decrypt(
            AppData.encryptKey,
            sharedInstance.getString(key: AppSharedPrefKey.password))) {
      sharedInstance.setString(key: AppSharedPrefKey.password, value: AppUtility
          .encrypt(AppData.encryptKey, request[LoginApiKeys.password])
          .base64);
      emit(SuccessState());
    } else {
      emit(ErrorState(context.l10n.passwordMismatch));
    }
  }
}