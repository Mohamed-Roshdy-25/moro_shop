part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class PostRegisterEvent extends RegisterEvent{
  final String email;
  final String password;
  final String name;
  final String phone;
  final String image;

  const PostRegisterEvent(this.email, this.password, this.name, this.phone, this.image);

  @override
  List<Object> get props => [email,password,name,phone,image];
}


class PickCameraPhotoEvent extends RegisterEvent{

  @override
  List<Object> get props => [];
}

class PickGalleryPhotoEvent extends RegisterEvent{

  @override
  List<Object> get props => [];
}