import 'package:dartz/dartz.dart';
import 'package:moro_shop/data/network/failure.dart';
import 'package:moro_shop/data/network/requests.dart';
import 'package:moro_shop/domain/models/models.dart';
import 'package:moro_shop/domain/repository/repository.dart';
import 'package:moro_shop/domain/use_case/base_use_case.dart';

class LoginUseCase implements BaseUseCase<LoginUseCaseInput,LoginOrRegisterOrResetPasswordModel>{
  final Repository _repository;

  LoginUseCase(this._repository);

  @override
  Future<Either<Failure, LoginOrRegisterOrResetPasswordModel>> execute(LoginUseCaseInput input) async {
    return await _repository.login(LoginRequest(input.email, input.password));
  }
  
}

class LoginUseCaseInput{
  String email;
  String password;

  LoginUseCaseInput(this.email, this.password);
}