part of 'reset_password_bloc.dart';

abstract class ResetPasswordEvent extends Equatable {
  const ResetPasswordEvent();
}

class PostResetPasswordEvent extends ResetPasswordEvent {
  final String email;
  final String code;
  final String password;

  const PostResetPasswordEvent(this.email, this.code, this.password);

  @override
  List<Object?> get props => [email,code,password];
}