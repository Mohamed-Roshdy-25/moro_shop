part of 'verify_code_bloc.dart';

abstract class VerifyCodeEvent extends Equatable {
  const VerifyCodeEvent();

  @override
  List<Object?> get props => [];
}

class PostVerifyCodeEvent extends VerifyCodeEvent {
  final String email;
  final String code;

  const PostVerifyCodeEvent(this.email, this.code);

  @override
  List<Object?> get props => [email,code];
}