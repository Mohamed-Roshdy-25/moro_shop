part of 'logout_bloc.dart';

abstract class LogoutEvent extends Equatable {
  const LogoutEvent();
}

class PostLogoutEvent extends LogoutEvent{

  const PostLogoutEvent();

  @override
  List<Object?> get props => [];

}