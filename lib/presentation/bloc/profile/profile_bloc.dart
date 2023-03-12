
// ignore_for_file: void_checks

import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:moro_shop/domain/models/models.dart';
import 'package:moro_shop/domain/use_case/profile_use_case.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileUseCase profileUseCase;
  ProfileModel? profileModel;


  ProfileBloc(this.profileUseCase) : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) async {
      if(event is GetProfileEvent){
        emit(GetProfileLoadingState());

        (await profileUseCase.execute(Void)).fold((failure) {
          emit(GetProfileErrorState(failure.message));
        }, (data) {
          profileModel = data;
          emit(GetProfileSuccessState(data));
        },);
      }
    });
  }
}
