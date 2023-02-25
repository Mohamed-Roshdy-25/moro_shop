
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:moro_shop/app/app_prefs.dart';
import 'package:moro_shop/app/constants.dart';
import 'package:moro_shop/app/extensions.dart';
import 'package:moro_shop/domain/use_case/login_use_case.dart';
import 'package:moro_shop/presentation/common/freezed_data_classes.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;
  final AppPreferences appPreferences;
  var loginObject = LoginObject('', '');



  LoginBloc({required this.loginUseCase,required this.appPreferences}) : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      if (event is PostLoginEvent) {
        emit(LoginLoadingState());

        loginObject = loginObject.copyWith(email: event.email,password: event.password);
        ( await loginUseCase.execute(
          LoginUseCaseInput(loginObject.email, loginObject.password),
        )).fold((failure) {
          emit(LoginErrorState(failure.message));
        }, (data)  {
          Constants.token = data.loginOrRegisterDataModel?.token.orEmpty();
             appPreferences.setUserLoggedIn();
          emit(LoginSuccessState(data.message));
        });
      }
    });
  }
}
