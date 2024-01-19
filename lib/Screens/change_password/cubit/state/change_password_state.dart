
abstract class ChangePasswordState {
  const ChangePasswordState();

  @override
  List<Object> get props => [];
}

class InitialState extends ChangePasswordState { }

class SuccessState extends ChangePasswordState { }

class ErrorState extends ChangePasswordState {
  ErrorState(this.message);

  String? message;

  @override
  List<Object> get props => [];
}
