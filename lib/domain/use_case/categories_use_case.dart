import 'package:dartz/dartz.dart';
import 'package:moro_shop/data/network/failure.dart';
import 'package:moro_shop/domain/models/models.dart';
import 'package:moro_shop/domain/repository/repository.dart';
import 'package:moro_shop/domain/use_case/base_use_case.dart';

class CategoriesUseCase implements BaseUseCase<void,CategoriesModel>{
  final Repository _repository;

  CategoriesUseCase(this._repository);

  @override
  Future<Either<Failure, CategoriesModel>> execute(void input) async {
    return await _repository.getCategory();
  }

}