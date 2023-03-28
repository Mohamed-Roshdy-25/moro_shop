import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:moro_shop/app/extensions.dart';
import 'package:moro_shop/data/data_sources/local_data_source.dart';
import 'package:moro_shop/data/data_sources/remote_data_source.dart';
import 'package:moro_shop/data/mappers/mappers.dart';
import 'package:moro_shop/data/network/error_handler.dart';
import 'package:moro_shop/data/network/failure.dart';
import 'package:moro_shop/data/network/network_info.dart';
import 'package:moro_shop/data/network/requests.dart';
import 'package:moro_shop/data/responses/responses.dart';
import 'package:moro_shop/domain/models/models.dart';
import 'package:moro_shop/domain/repository/repository.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;
  final LocalDataSource _localDataSource;

  RepositoryImpl(
      this._remoteDataSource, this._networkInfo, this._localDataSource);

  @override
  Future<Either<Failure, LoginOrRegisterOrResetPasswordModel>> login(
      LoginRequest loginRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        LoginOrRegisterOrResetPasswordResponse response =
            await _remoteDataSource.login(loginRequest);
        if (response.status == true) {
          return Right(response.toDomain());
        } else {
          return Left(
              Failure(response.status.orFalse(), response.message.orEmpty()));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, LoginOrRegisterOrResetPasswordModel>> register(
      RegisterRequest registerRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        LoginOrRegisterOrResetPasswordResponse response =
            await _remoteDataSource.register(registerRequest);
        if (response.status == true) {
          return Right(response.toDomain());
        } else {
          return Left(
              Failure(response.status.orFalse(), response.message.orEmpty()));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, ForgotPasswordModel>> forgotPassword(
      ForgotPasswordRequest forgotPasswordRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        ForgotPasswordResponse response =
            await _remoteDataSource.forgotPassword(forgotPasswordRequest);
        if (response.status == true) {
          return Right(response.toDomain());
        } else {
          return Left(
              Failure(response.status.orFalse(), response.message.orEmpty()));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, VerifyCodeModel>> verifyCode(
      VerifyCodeRequest verifyCodeRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        VerifyCodeResponse response =
            await _remoteDataSource.verifyCode(verifyCodeRequest);
        if (response.status == true) {
          return Right(response.toDomain());
        } else {
          return Left(
              Failure(response.status.orFalse(), response.message.orEmpty()));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, LoginOrRegisterOrResetPasswordModel>> resetPassword(
      ResetPasswordRequest resetPasswordRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        LoginOrRegisterOrResetPasswordResponse response =
            await _remoteDataSource.resetPassword(resetPasswordRequest);
        if (response.status == true) {
          return Right(response.toDomain());
        } else {
          return Left(
              Failure(response.status.orFalse(), response.message.orEmpty()));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, CategoriesModel>> getCategory() async {
    try {
      final response = await _localDataSource.getCategoriesResponse();
      return Right(response.toDomain());
    } catch (cacheError) {
      if (await _networkInfo.isConnected) {
        try {
          CategoriesResponse response = await _remoteDataSource.getCategories();
          if (response.status == true) {
            await _localDataSource.saveCategoriesToCache(response);
            return Right(response.toDomain());
          } else {
            return Left(
                Failure(response.status.orFalse(), response.message.orEmpty()));
          }
        } catch (error) {
          return Left(ErrorHandler.handle(error).failure);
        }
      } else {
        return Left(DataSource.noInternetConnection.getFailure());
      }
    }
  }

  @override
  Future<Either<Failure, CategoryAllDataModel>> getCategoryProducts(
      int categoryId) async {
    try {
      final response =
          await _localDataSource.getCategoryProductsResponse(categoryId);
      return Right(response.toDomain());
    } catch (cacheError) {
      if (await _networkInfo.isConnected) {
        try {
          CategoryAllDataResponse response =
              await _remoteDataSource.getCategoryProducts(categoryId);
          if (response.status == true) {
            await _localDataSource.saveCategoryProductsToCache(
                response, categoryId);
            return Right(response.toDomain());
          } else {
            debugPrint('=============================================server');
            return Left(
                Failure(response.status.orFalse(), response.message.orEmpty()));
          }
        } catch (error) {
          debugPrint('=============================================dioerror');
          return Left(ErrorHandler.handle(error).failure);
        }
      } else {
        return Left(DataSource.noInternetConnection.getFailure());
      }
    }
  }

  @override
  Future<Either<Failure, ProfileModel>> getProfile() async {
    try {
      final response = await _localDataSource.getProfileResponse();
      return Right(response.toDomain());
    } catch (cacheError) {
      if (await _networkInfo.isConnected) {
        try {
          ProfileResponse response = await _remoteDataSource.getProfile();
          if (response.status == true) {
            await _localDataSource.saveProfileToCache(response);
            return Right(response.toDomain());
          } else {
            return Left(
                Failure(response.status.orFalse(), response.message.orEmpty()));
          }
        } catch (error) {
          return Left(ErrorHandler.handle(error).failure);
        }
      } else {
        return Left(DataSource.noInternetConnection.getFailure());
      }
    }
  }

  @override
  Future<Either<Failure, AddOrDeleteFavoritesModel>> addOrDeleteFavorites(
      AddOrDeleteFavoritesRequest addOrDeleteFavoritesRequest,
      String categoryId) async {
    if (await _networkInfo.isConnected) {
      try {
        AddOrDeleteFavoritesResponse response =
            await _remoteDataSource.favorite(addOrDeleteFavoritesRequest);
        if (response.status == true) {
          _localDataSource.removeFromCache(categoryId);
          return Right(response.toDomain());
        } else {
          return Left(
              Failure(response.status.orFalse(), response.message.orEmpty()));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, LogoutModel>> logout() async {
    if (await _networkInfo.isConnected) {
      try {
        LogoutResponse response = await _remoteDataSource.logout();
        if (response.status == true) {
          _localDataSource.clearCache();
          return Right(response.toDomain());
        } else {
          return Left(
              Failure(response.status.orFalse(), response.message.orEmpty()));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }
}
