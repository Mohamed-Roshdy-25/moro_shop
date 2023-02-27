part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordState extends Equatable {
  const ForgotPasswordState();
}

class ForgotPasswordInitial extends ForgotPasswordState {
  @override
  List<Object> get props => [];
}

class ForgotPasswordLoadingState extends ForgotPasswordState{
  @override
  List<Object?> get props => [];
}

class ForgotPasswordSuccessState extends ForgotPasswordState{
  final String message;

  const ForgotPasswordSuccessState(this.message);

  @override
  List<Object?> get props => [message];
}

class ForgotPasswordErrorState extends ForgotPasswordState{
  final String message;

  const ForgotPasswordErrorState(this.message);

  @override
  List<Object?> get props => [message];
}