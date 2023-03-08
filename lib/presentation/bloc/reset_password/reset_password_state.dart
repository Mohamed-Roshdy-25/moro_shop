part of 'reset_password_bloc.dart';

abstract class ResetPasswordState extends Equatable {
  const ResetPasswordState();
}

class ResetPasswordInitial extends ResetPasswordState {
  @override
  List<Object> get props => [];
}

class ResetPasswordLoadingState extends ResetPasswordState{
  @override
  List<Object?> get props => [];
}

class ResetPasswordSuccessState extends ResetPasswordState{
  final LoginOrRegisterOrResetPasswordModel loginOrRegisterOrResetPasswordModel;


  const ResetPasswordSuccessState(this.loginOrRegisterOrResetPasswordModel);

  @override
  List<Object?> get props => [loginOrRegisterOrResetPasswordModel];
}

class ResetPasswordErrorState extends ResetPasswordState{
  final String message;

  const ResetPasswordErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

