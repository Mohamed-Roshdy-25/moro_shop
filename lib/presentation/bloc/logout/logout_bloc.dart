// ignore_for_file: void_checks

import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:moro_shop/app/app_prefs.dart';
import 'package:moro_shop/app/di.dart';
import 'package:moro_shop/domain/use_case/logout_use_case.dart';

part 'logout_event.dart';
part 'logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  final LogoutUseCase _logoutUseCase;
  final AppPreferences _appPreferences = instance<AppPreferences>();

  LogoutBloc(this._logoutUseCase) : super(LogoutInitial()) {
    on<LogoutEvent>((event, emit) async {
      if (event is PostLogoutEvent) {
        emit(LogoutLoadingState());

        await (await _logoutUseCase.execute(Void)).fold(
          (failure) {
            emit(LogoutErrorState(failure.message));
          },
          (data) async {
            await _appPreferences.logout();
            emit(LogoutSuccessState(data.message));
          },
        );
      }
    });
  }
}
