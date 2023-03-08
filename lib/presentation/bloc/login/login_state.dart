part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginLoadingState extends LoginState{
  @override
  List<Object?> get props => [];
}

class LoginSuccessState extends LoginState{
  final LoginOrRegisterOrResetPasswordModel loginOrRegisterModel;

  const LoginSuccessState(this.loginOrRegisterModel);

  @override
  List<Object?> get props => [loginOrRegisterModel];
}

class LoginErrorState extends LoginState{
  final String message;

  const LoginErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
