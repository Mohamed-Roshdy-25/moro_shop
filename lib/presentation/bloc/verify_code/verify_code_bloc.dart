
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:moro_shop/domain/use_case/verify_code_use_case.dart';
import 'package:moro_shop/presentation/common/freezed_data_classes.dart';

part 'verify_code_event.dart';
part 'verify_code_state.dart';

class VerifyCodeBloc extends Bloc<VerifyCodeEvent, VerifyCodeState> {
  final VerifyCodeUseCase verifyCodeUseCase;
  var verifyCodeObject = VerifyCodeObject('', '');

  VerifyCodeBloc({required this.verifyCodeUseCase}) : super(VerifyCodeInitial()) {
    on<VerifyCodeEvent>((event, emit) async {
      if(event is PostVerifyCodeEvent){
        emit(VerifyCodeLoadingState());

        verifyCodeObject = verifyCodeObject.copyWith(email: event.email,code: event.code);
        (await verifyCodeUseCase.execute(VerifyCodeUseCaseInput(verifyCodeObject.email, verifyCodeObject.code)))
            .fold((failure) {
              emit(VerifyCodeErrorState(failure.message));
        }, (data) {
              emit(VerifyCodeSuccessState(data.message));
        });
      }
    });
  }
}
