part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class PostLoginEvent extends LoginEvent{
  final LoginModel loginModel;

  const PostLoginEvent(this.loginModel);

  @override
  List<Object> get props => [loginModel];
}
