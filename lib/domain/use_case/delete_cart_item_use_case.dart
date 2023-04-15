import 'package:dartz/dartz.dart';
import 'package:moro_shop/data/network/failure.dart';
import 'package:moro_shop/data/network/requests.dart';
import 'package:moro_shop/domain/models/models.dart';
import 'package:moro_shop/domain/repository/repository.dart';
import 'package:moro_shop/domain/use_case/base_use_case.dart';

class DeleteCartItemUseCase
    implements
        BaseUseCase<DeleteCartItemUseCaseInput,
            DeleteCartItemModel> {
  final Repository _repository;

  DeleteCartItemUseCase(this._repository);

  @override
  Future<Either<Failure, DeleteCartItemModel>> execute(
      DeleteCartItemUseCaseInput input) async {
    return await _repository.deleteCartItem(DeleteCartItemRequest(input.cartItemId));
  }
}

class DeleteCartItemUseCaseInput {
  int cartItemId;

  DeleteCartItemUseCaseInput(this.cartItemId);
}