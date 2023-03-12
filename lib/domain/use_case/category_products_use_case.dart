
import 'package:dartz/dartz.dart';
import 'package:moro_shop/data/network/failure.dart';
import 'package:moro_shop/domain/models/models.dart';
import 'package:moro_shop/domain/repository/repository.dart';
import 'package:moro_shop/domain/use_case/base_use_case.dart';

class CategoryProductsUseCase implements BaseUseCase<CategoryProductsUseCaseInput,CategoryAllDataModel>{
  final Repository _repository;

  CategoryProductsUseCase(this._repository);

  @override
  Future<Either<Failure, CategoryAllDataModel>> execute(CategoryProductsUseCaseInput input) async {
    return await _repository.getCategoryProducts(input.categoryId);
  }

}

class CategoryProductsUseCaseInput{
  int categoryId;

  CategoryProductsUseCaseInput(this.categoryId);
}