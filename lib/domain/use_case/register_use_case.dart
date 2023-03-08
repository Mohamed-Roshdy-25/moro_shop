import 'package:dartz/dartz.dart';
import 'package:moro_shop/data/network/failure.dart';
import 'package:moro_shop/data/network/requests.dart';
import 'package:moro_shop/domain/models/models.dart';
import 'package:moro_shop/domain/repository/repository.dart';
import 'package:moro_shop/domain/use_case/base_use_case.dart';

class RegisterUseCase
    implements BaseUseCase<RegisterUseCaseInput, LoginOrRegisterOrResetPasswordModel> {
  final Repository _repository;

  RegisterUseCase(this._repository);

  @override
  Future<Either<Failure, LoginOrRegisterOrResetPasswordModel>> execute(
      RegisterUseCaseInput input) async {
    return await _repository.register(RegisterRequest(
      input.email,
      input.password,
      input.name,
      input.phone,
      input.image,
    ));
  }
}

class RegisterUseCaseInput {
  String email;
  String password;
  String name;
  String phone;
  String image;

  RegisterUseCaseInput(
      this.email, this.password, this.name, this.phone, this.image);
}
