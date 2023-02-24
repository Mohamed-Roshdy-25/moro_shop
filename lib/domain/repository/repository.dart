import 'package:dartz/dartz.dart';
import 'package:moro_shop/data/network/failure.dart';
import 'package:moro_shop/data/network/requests.dart';
import 'package:moro_shop/domain/models/models.dart';

abstract class Repository{
  Future<Either<Failure,LoginOrRegisterModel>> login(LoginRequest loginRequest);
  Future<Either<Failure,LoginOrRegisterModel>> register(RegisterRequest registerRequest);
}