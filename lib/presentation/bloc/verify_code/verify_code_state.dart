part of 'verify_code_bloc.dart';

abstract class VerifyCodeState extends Equatable {
  const VerifyCodeState();
}

class VerifyCodeInitial extends VerifyCodeState {
  @override
  List<Object> get props => [];
}

class VerifyCodeLoadingState extends VerifyCodeState{
  @override
  List<Object?> get props => [];
}

class VerifyCodeSuccessState extends VerifyCodeState{
  final String message;

  const VerifyCodeSuccessState(this.message);

  @override
  List<Object?> get props => [message];
}

class VerifyCodeErrorState extends VerifyCodeState{
  final String message;

  const VerifyCodeErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
