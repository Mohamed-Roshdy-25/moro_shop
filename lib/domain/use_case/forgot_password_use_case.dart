import 'package:dartz/dartz.dart';
import 'package:moro_shop/data/network/failure.dart';
import 'package:moro_shop/data/network/requests.dart';
import 'package:moro_shop/domain/models/models.dart';
import 'package:moro_shop/domain/repository/repository.dart';
import 'package:moro_shop/domain/use_case/base_use_case.dart';

class ForgotPasswordUseCase implements BaseUseCase<ForgotPasswordUseCaseInput,ForgotPasswordModel>{
  final Repository _repository;

  ForgotPasswordUseCase(this._repository);

  @override
  Future<Either<Failure, ForgotPasswordModel>> execute(ForgotPasswordUseCaseInput input) async {
    return await _repository.forgotPassword(ForgotPasswordRequest(input.email));
  }

}

class ForgotPasswordUseCaseInput{
  String email;

  ForgotPasswordUseCaseInput(this.email);
}