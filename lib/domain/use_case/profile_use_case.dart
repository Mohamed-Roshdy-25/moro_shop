import 'package:dartz/dartz.dart';
import 'package:moro_shop/data/network/failure.dart';
import 'package:moro_shop/domain/models/models.dart';
import 'package:moro_shop/domain/repository/repository.dart';
import 'package:moro_shop/domain/use_case/base_use_case.dart';

class ProfileUseCase implements BaseUseCase<void,ProfileModel>{
 final Repository _repository;

  ProfileUseCase(this._repository);

  @override
  Future<Either<Failure, ProfileModel>> execute(void input) async {
    return await _repository.getProfile();
  }

}