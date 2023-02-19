import 'package:dartz/dartz.dart';
import 'package:moro_shop/data/network/failure.dart';

abstract class BaseUseCase<In,Out>{
  Future<Either<Failure,Out>> execute(In input);
}