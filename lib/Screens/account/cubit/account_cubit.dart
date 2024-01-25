import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_flutter_demo/Models/user_model.dart';
import 'package:movie_flutter_demo/Screens/account/cubit/state/account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  AccountCubit() : super(AccountInitState()) {
    getAccountData();
  }
  void getAccountData() async {
    emit(InfoAccountState(User()));
  }

}