import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:moro_shop/app/constants.dart';
import 'package:moro_shop/app/extensions.dart';
import 'package:moro_shop/domain/use_case/login_use_case.dart';
import 'package:moro_shop/presentation/common/freezed_data_classes.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginUseCase loginUseCase;
  var loginObject = LoginObject('', '');

  static StreamController isUserLoggedInSuccessfullyStreamController =
      StreamController<bool>();

  LoginBloc({required this.loginUseCase}) : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      if (event is PostLoginEvent) {
        emit(LoginLoadingState());

        loginObject = loginObject.copyWith(email: event.email,password: event.password);
        ( await loginUseCase.execute(
          LoginUseCaseInput(loginObject.email, loginObject.password),
        )).fold((failure) {
          emit(LoginErrorState(failure.message));
        }, (data) {
          emit(LoginSuccessState(data.message));
          Constants.token = data.loginDataModel?.token.orEmpty();
          isUserLoggedInSuccessfullyStreamController.add(true);
        });
      }
    });
  }
}
