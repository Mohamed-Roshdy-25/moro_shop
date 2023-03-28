import 'package:dartz/dartz.dart';
import 'package:moro_shop/data/network/failure.dart';
import 'package:moro_shop/domain/models/models.dart';
import 'package:moro_shop/domain/repository/repository.dart';
import 'package:moro_shop/domain/use_case/base_use_case.dart';

class LogoutUseCase implements BaseUseCase<void,LogoutModel>{
  final Repository _repository;

  LogoutUseCase(this._repository);

  @override
  Future<Either<Failure, LogoutModel>> execute(void input) async {
    return await _repository.logout();
  }

}