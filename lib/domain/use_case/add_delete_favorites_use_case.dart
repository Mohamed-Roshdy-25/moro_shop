import 'package:dartz/dartz.dart';
import 'package:moro_shop/data/network/failure.dart';
import 'package:moro_shop/data/network/requests.dart';
import 'package:moro_shop/domain/models/models.dart';
import 'package:moro_shop/domain/repository/repository.dart';
import 'package:moro_shop/domain/use_case/base_use_case.dart';

class AddOrDeleteFavoritesUseCase
    implements
        BaseUseCase<AddOrDeleteFavoritesUseCaseInput,
            AddOrDeleteFavoritesModel> {
  final Repository _repository;

  AddOrDeleteFavoritesUseCase(this._repository);

  @override
  Future<Either<Failure, AddOrDeleteFavoritesModel>> execute(
      AddOrDeleteFavoritesUseCaseInput input) async {
    return await _repository.addOrDeleteFavorites(
        AddOrDeleteFavoritesRequest(input.productId), input.categoryId);
  }
}

class AddOrDeleteFavoritesUseCaseInput {
  int productId;
  String categoryId;

  AddOrDeleteFavoritesUseCaseInput(this.productId, this.categoryId);
}
