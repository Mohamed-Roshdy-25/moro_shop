
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:moro_shop/app/app_prefs.dart';
import 'package:moro_shop/domain/models/models.dart';
import 'package:moro_shop/domain/use_case/login_use_case.dart';
import 'package:moro_shop/presentation/common/freezed_data_classes.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;
  var loginObject = LoginObject('', '');
  LoginOrRegisterOrResetPasswordModel? loginOrRegisterOrResetPasswordModel;




  LoginBloc({required this.loginUseCase}) : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      if (event is PostLoginEvent) {
        emit(LoginLoadingState());

        loginObject = loginObject.copyWith(email: event.email,password: event.password);
        await ( await loginUseCase.execute(
          LoginUseCaseInput(loginObject.email, loginObject.password),
        )).fold((failure) {
          emit(LoginErrorState(failure.message));
        }, (data)  async {
          loginOrRegisterOrResetPasswordModel = data;
          AppPreferences.setUserLoggedIn();
             await AppPreferences.saveToken(data.loginOrRegisterOrResetPasswordDataModel?.token??'');
          emit(LoginSuccessState(data));
        });
      }
    });
  }
}
