import 'package:dartz/dartz.dart';
import 'package:moro_shop/app/extensions.dart';
import 'package:moro_shop/data/data_sources/remote_data_source.dart';
import 'package:moro_shop/data/mappers/mappers.dart';
import 'package:moro_shop/data/network/error_handler.dart';
import 'package:moro_shop/data/network/failure.dart';
import 'package:moro_shop/data/network/network_info.dart';
import 'package:moro_shop/data/network/requests.dart';
import 'package:moro_shop/data/responses/responses.dart';
import 'package:moro_shop/domain/models/models.dart';
import 'package:moro_shop/domain/repository/repository.dart';

class RepositoryImpl implements Repository{
  final RemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;


  RepositoryImpl(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, LoginOrRegisterModel>> login(LoginRequest loginRequest) async {
    if(await _networkInfo.isConnected){
      try{
        LoginOrRegisterResponse response = await _remoteDataSource.login(loginRequest);
        if(response.status == true) {
          return Right(response.toDomain());
        }else{
          return Left(Failure(response.status.orFalse(), response.message.orEmpty()));
        }
      }catch (error){
        return Left(ErrorHandler.handle(error).failure);
      }
    }else{
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, LoginOrRegisterModel>> register(RegisterRequest registerRequest) async {
    if(await _networkInfo.isConnected){
      try{
        LoginOrRegisterResponse response = await _remoteDataSource.register(registerRequest);
        if(response.status == true) {
          return Right(response.toDomain());
        }else{
          return Left(Failure(response.status.orFalse(), response.message.orEmpty()));
        }
      }catch (error){
        return Left(ErrorHandler.handle(error).failure);
      }
    }else{
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, ForgotPasswordModel>> forgotPassword(ForgotPasswordRequest forgotPasswordRequest) async {
    if(await _networkInfo.isConnected){
      try{
        ForgotPasswordResponse response = await _remoteDataSource.forgotPassword(forgotPasswordRequest);
        if(response.status == true) {
          return Right(response.toDomain());
        }else{
          return Left(Failure(response.status.orFalse(), response.message.orEmpty()));
        }
      }catch (error){
        return Left(ErrorHandler.handle(error).failure);
      }
    }else{
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, VerifyCodeModel>> verifyCode(VerifyCodeRequest verifyCodeRequest) async {
    if(await _networkInfo.isConnected){
      try{
        VerifyCodeResponse response = await _remoteDataSource.verifyCode(verifyCodeRequest);
        if(response.status == true) {
          return Right(response.toDomain());
        }else{
          return Left(Failure(response.status.orFalse(), response.message.orEmpty()));
        }
      }catch (error){
        return Left(ErrorHandler.handle(error).failure);
      }
    }else{
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, ResetPasswordModel>> resetPassword(ResetPasswordRequest resetPasswordRequest) async {
    if(await _networkInfo.isConnected){
      try{
        ResetPasswordResponse response = await _remoteDataSource.resetPassword(resetPasswordRequest);
        if(response.status == true) {
          return Right(response.toDomain());
        }else{
          return Left(Failure(response.status.orFalse(), response.message.orEmpty()));
        }
      }catch (error){
        return Left(ErrorHandler.handle(error).failure);
      }
    }else{
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }
}