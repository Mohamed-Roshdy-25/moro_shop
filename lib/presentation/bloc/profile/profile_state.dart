part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
}

class ProfileInitial extends ProfileState {
  @override
  List<Object> get props => [];
}


class GetProfileLoadingState extends ProfileState{

  @override
  List<Object?> get props => [];
}

class GetProfileSuccessState extends ProfileState{
  final ProfileModel profileModel;

  const GetProfileSuccessState(this.profileModel);

  @override
  List<Object?> get props => [profileModel];
}

class GetProfileErrorState extends ProfileState{
  final String message;

  const GetProfileErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
