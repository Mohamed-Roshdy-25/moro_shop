part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class PostLoginEvent extends LoginEvent{
  final String email;
  final String password;

  const PostLoginEvent(this.email, this.password);

  @override
  List<Object> get props => [email,password];
}
