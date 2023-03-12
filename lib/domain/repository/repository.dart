import 'package:dartz/dartz.dart';
import 'package:moro_shop/data/network/failure.dart';
import 'package:moro_shop/data/network/requests.dart';
import 'package:moro_shop/domain/models/models.dart';

abstract class Repository{
  Future<Either<Failure,LoginOrRegisterOrResetPasswordModel>> login(LoginRequest loginRequest);
  Future<Either<Failure,LoginOrRegisterOrResetPasswordModel>> register(RegisterRequest registerRequest);
  Future<Either<Failure,ForgotPasswordModel>> forgotPassword(ForgotPasswordRequest forgotPasswordRequest);
  Future<Either<Failure,VerifyCodeModel>> verifyCode(VerifyCodeRequest verifyCodeRequest);
  Future<Either<Failure,LoginOrRegisterOrResetPasswordModel>> resetPassword(ResetPasswordRequest resetPasswordRequest);
  Future<Either<Failure,CategoriesModel>> getCategory();
  Future<Either<Failure,CategoryAllDataModel>> getCategoryProducts(int categoryId);
  Future<Either<Failure,ProfileModel>> getProfile();
}