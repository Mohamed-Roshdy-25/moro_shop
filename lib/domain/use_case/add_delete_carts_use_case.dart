import 'package:dartz/dartz.dart';
import 'package:moro_shop/data/network/failure.dart';
import 'package:moro_shop/data/network/requests.dart';
import 'package:moro_shop/domain/models/models.dart';
import 'package:moro_shop/domain/repository/repository.dart';
import 'package:moro_shop/domain/use_case/base_use_case.dart';

class AddOrDeleteCartsUseCase
    implements
        BaseUseCase<AddOrDeleteCartsUseCaseInput,
            AddOrDeleteCartsModel> {
  final Repository _repository;

  AddOrDeleteCartsUseCase(this._repository);

  @override
  Future<Either<Failure, AddOrDeleteCartsModel>> execute(
      AddOrDeleteCartsUseCaseInput input) async {
    return await _repository.addOrDeleteCarts(
        AddOrDeleteCartsRequest(input.productId), input.categoryId);
  }
}

class AddOrDeleteCartsUseCaseInput {
  int productId;
  String categoryId;

  AddOrDeleteCartsUseCaseInput(this.productId, this.categoryId);
}
