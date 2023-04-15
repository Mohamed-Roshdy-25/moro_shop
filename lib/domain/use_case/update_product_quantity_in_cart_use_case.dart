import 'package:dartz/dartz.dart';
import 'package:moro_shop/data/network/failure.dart';
import 'package:moro_shop/data/network/requests.dart';
import 'package:moro_shop/domain/models/models.dart';
import 'package:moro_shop/domain/repository/repository.dart';
import 'package:moro_shop/domain/use_case/base_use_case.dart';

class UpdateProductQuantityInCartUseCase extends BaseUseCase<
    UpdateProductQuantityInCartUseCaseInputs,
    UpdateProductQuantityInCartModel> {
  final Repository _repository;

  UpdateProductQuantityInCartUseCase(this._repository);

  @override
  Future<Either<Failure, UpdateProductQuantityInCartModel>> execute(
      UpdateProductQuantityInCartUseCaseInputs input) async {
    return await _repository.updateProductQuantityInCart(
        UpdateProductQuantityInCartRequest(input.cartItemId, input.quantity));
  }
}

class UpdateProductQuantityInCartUseCaseInputs {
  int cartItemId;
  int quantity;

  UpdateProductQuantityInCartUseCaseInputs(this.cartItemId, this.quantity);
}
