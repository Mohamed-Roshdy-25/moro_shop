part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();
}

class PostForgotPasswordEvent extends ForgotPasswordEvent{
  final String email;

  const PostForgotPasswordEvent(this.email);

  @override
 List<Object?> get props => [email];
}