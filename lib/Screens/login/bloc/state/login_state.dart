
abstract class LoginState {
  const LoginState();
}

class LoginInitialState extends LoginState { }

class LoginLoadingState extends LoginState { }

class LoginSuccessState extends LoginState { }

class LoginError extends LoginState {
  LoginError(this.message);
 final String message;
}
