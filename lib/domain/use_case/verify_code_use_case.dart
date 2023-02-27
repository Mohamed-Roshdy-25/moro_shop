import 'package:dartz/dartz.dart';
import 'package:moro_shop/data/network/failure.dart';
import 'package:moro_shop/data/network/requests.dart';
import 'package:moro_shop/domain/models/models.dart';
import 'package:moro_shop/domain/repository/repository.dart';
import 'package:moro_shop/domain/use_case/base_use_case.dart';

class VerifyCodeUseCase implements BaseUseCase<VerifyCodeUseCaseInput,VerifyCodeModel>{
  final Repository _repository;

  VerifyCodeUseCase(this._repository);

  @override
  Future<Either<Failure, VerifyCodeModel>> execute(VerifyCodeUseCaseInput input) async {
    return await _repository.verifyCode(VerifyCodeRequest(input.email,input.code));
  }

}

class VerifyCodeUseCaseInput{
  String email;
  String code;

  VerifyCodeUseCaseInput(this.email,this.code);
}