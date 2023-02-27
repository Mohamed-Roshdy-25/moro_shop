
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:moro_shop/domain/use_case/forgot_password_use_case.dart';
import 'package:moro_shop/presentation/common/freezed_data_classes.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final ForgotPasswordUseCase forgotPasswordUseCase;
  var forgotPasswordObject = ForgotPasswordObject('');

  ForgotPasswordBloc({required this.forgotPasswordUseCase}) : super(ForgotPasswordInitial()) {
    on<ForgotPasswordEvent>((event, emit) async {
      if (event is PostForgotPasswordEvent) {
        emit(ForgotPasswordLoadingState());

        forgotPasswordObject = forgotPasswordObject.copyWith(email: event.email);
        ( await forgotPasswordUseCase.execute(
        ForgotPasswordUseCaseInput(forgotPasswordObject.email),
      )).fold((failure) {
      emit(ForgotPasswordErrorState(failure.message));
      }, (data)  {
      emit(ForgotPasswordSuccessState(data.message));
      });
    }
    });
  }
}
