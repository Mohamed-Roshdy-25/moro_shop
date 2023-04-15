import 'package:dartz/dartz.dart';
import 'package:moro_shop/data/network/failure.dart';
import 'package:moro_shop/data/network/requests.dart';
import 'package:moro_shop/domain/models/models.dart';
import 'package:moro_shop/domain/repository/repository.dart';
import 'package:moro_shop/domain/use_case/base_use_case.dart';

class DeleteFavoriteUseCase
    implements
        BaseUseCase<DeleteFavoriteUseCaseInput,
            DeleteFavoriteModel> {
  final Repository _repository;

  DeleteFavoriteUseCase(this._repository);

  @override
  Future<Either<Failure, DeleteFavoriteModel>> execute(
      DeleteFavoriteUseCaseInput input) async {
    return await _repository.deleteFavorite(DeleteFavoriteRequest(input.favoriteItemId));
  }
}

class DeleteFavoriteUseCaseInput {
  int favoriteItemId;

  DeleteFavoriteUseCaseInput(this.favoriteItemId);
}
