
abstract class ChangePasswordState {
  const ChangePasswordState();
}

class InitialState extends ChangePasswordState { }

class SuccessState extends ChangePasswordState { }

class ErrorState extends ChangePasswordState {
  ErrorState(this.message);
  final String message;
}
