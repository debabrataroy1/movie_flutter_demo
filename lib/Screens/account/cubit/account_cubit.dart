import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_flutter_demo/Constants/app_shared_pref_key.dart';
import 'package:movie_flutter_demo/Models/user_model.dart';
import 'package:movie_flutter_demo/Screens/account/cubit/state/account_state.dart';
import 'package:movie_flutter_demo/Utils/app_shared_pref.dart';
import 'package:movie_flutter_demo/di/injector.dart';

class AccountCubit extends Cubit<AccountState> {
  final SharedPref _sharedPref;
  AccountCubit({SharedPref? sharedPref}) : _sharedPref = sharedPref ?? AppInjector.getIt<SharedPref>(), super(AccountInitState()) {
    getAccountData();
  }

  void getAccountData() async {
    emit(InfoAccountState(User()));
  }

  void logout() {
    _sharedPref.remove(AppSharedPrefKey.loginStatus);
    _sharedPref.remove(AppSharedPrefKey.lastActive);
  }

  void clearData() {
    _sharedPref.clear();
  }
}