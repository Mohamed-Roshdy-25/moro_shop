
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:moro_shop/app/app_prefs.dart';
import 'package:moro_shop/domain/models/models.dart';
import 'package:moro_shop/domain/use_case/reset_password_use_case.dart';
import 'package:moro_shop/presentation/common/freezed_data_classes.dart';

part 'reset_password_event.dart';
part 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  final ResetPasswordUseCase resetPasswordUseCase;
  var resetPasswordObject = ResetPasswordObject('','','');
  LoginOrRegisterOrResetPasswordModel? loginOrRegisterOrResetPasswordModel;

  ResetPasswordBloc({required this.resetPasswordUseCase}) : super(ResetPasswordInitial()) {
    on<ResetPasswordEvent>((event, emit) async {
      if(event is PostResetPasswordEvent){
        emit(ResetPasswordLoadingState());

        resetPasswordObject = resetPasswordObject.copyWith(email: event.email,code: event.code,password: event.password);
        (await resetPasswordUseCase.execute(ResetPasswordUseCaseInput(resetPasswordObject.email, resetPasswordObject.code,resetPasswordObject.password)))
          .fold((failure) {
          emit(ResetPasswordErrorState(failure.message));
      }, (data) {
          loginOrRegisterOrResetPasswordModel = data;
          AppPreferences.saveToken(data.loginOrRegisterOrResetPasswordDataModel?.token??'');
          AppPreferences.setUserLoggedIn();
          emit(ResetPasswordSuccessState(data));

      });
    }
    });
  }
}
