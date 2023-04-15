part of 'logout_bloc.dart';

abstract class LogoutState extends Equatable {
  const LogoutState();
}

class LogoutInitial extends LogoutState {
  @override
  List<Object> get props => [];
}

class LogoutLoadingState extends LogoutState{
  @override
  List<Object?> get props => [];
}

class LogoutSuccessState extends LogoutState{
  final String message;

  const LogoutSuccessState(this.message);

  @override
  List<Object?> get props => [message];
}

class LogoutErrorState extends LogoutState{
  final String message;

  const LogoutErrorState(this.message);


  @override
  List<Object?> get props => [message];
}
