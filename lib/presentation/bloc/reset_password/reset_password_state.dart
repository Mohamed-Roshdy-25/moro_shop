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
  final String message;

  const ResetPasswordSuccessState(this.message);

  @override
  List<Object?> get props => [message];
}

class ResetPasswordErrorState extends ResetPasswordState{
  final String message;

  const ResetPasswordErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

