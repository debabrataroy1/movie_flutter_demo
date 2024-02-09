import 'package:movie_flutter_demo/Models/user_model.dart';

abstract class AccountState {
  const AccountState();
}
class AccountInitState extends AccountState { }

class InfoAccountState extends AccountState {
  InfoAccountState(this.info);
  final User info;
}