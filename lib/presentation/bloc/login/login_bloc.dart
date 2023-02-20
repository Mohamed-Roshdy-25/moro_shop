import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:moro_shop/domain/models/models.dart';
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

        (await loginUseCase.execute(
          LoginUseCaseInput(loginObject.email, loginObject.password),
        ))
            .fold((failure) {
          emit(LoginErrorState(event.loginModel.message));
          print('error ==> ${event.loginModel.message}');
        }, (data) {
          emit(LoginSuccessState(event.loginModel.message));
          isUserLoggedInSuccessfullyStreamController.add(true);
        });
      }
    });
  }
}
