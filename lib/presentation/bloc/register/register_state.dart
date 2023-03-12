part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();
}

class RegisterInitial extends RegisterState {
  @override
  List<Object> get props => [];
}

class RegisterLoadingState extends RegisterState{
  @override
  List<Object?> get props => [];
}

class RegisterSuccessState extends RegisterState{
  final LoginOrRegisterOrResetPasswordModel loginOrRegisterOrResetPasswordModel;

  const RegisterSuccessState(this.loginOrRegisterOrResetPasswordModel);

  @override
  List<Object?> get props => [loginOrRegisterOrResetPasswordModel];
}

class RegisterErrorState extends RegisterState{
  final String message;

  const RegisterErrorState(this.message);

  @override
  List<Object?> get props => [message];
}



class PickCameraPhotoState extends RegisterState{
  final File? imageFile;

  const PickCameraPhotoState(this.imageFile);

  @override
  List<Object?> get props => [imageFile];
}

class PickGalleryPhotoState extends RegisterState{
  final File? imageFile;

  const PickGalleryPhotoState(this.imageFile);

  @override
  List<Object?> get props => [imageFile];
}
