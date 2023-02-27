import 'package:dartz/dartz.dart';
import 'package:moro_shop/data/network/failure.dart';
import 'package:moro_shop/data/network/requests.dart';
import 'package:moro_shop/domain/models/models.dart';
import 'package:moro_shop/domain/repository/repository.dart';
import 'package:moro_shop/domain/use_case/base_use_case.dart';

class ResetPasswordUseCase implements BaseUseCase<ResetPasswordUseCaseInput,ResetPasswordModel>{
  final Repository _repository;

  ResetPasswordUseCase(this._repository);

  @override
  Future<Either<Failure, ResetPasswordModel>> execute(ResetPasswordUseCaseInput input) async {
    return await _repository.resetPassword(ResetPasswordRequest(input.email,input.code,input.password));
  }

}

class ResetPasswordUseCaseInput{
  String email;
  String code;
  String password;

  ResetPasswordUseCaseInput(this.email,this.code,this.password);
}