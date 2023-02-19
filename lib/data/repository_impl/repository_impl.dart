import 'package:dartz/dartz.dart';
import 'package:moro_shop/app/constants.dart';
import 'package:moro_shop/app/extensions.dart';
import 'package:moro_shop/data/data_sources/remote_data_source.dart';
import 'package:moro_shop/data/mappers/mappers.dart';
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
  Future<Either<Failure, LoginModel>> login(LoginRequest loginRequest) async {
    if(await _networkInfo.isConnected){
      LoginResponse response = await _remoteDataSource.login(loginRequest);
      if(response.status == true) {
        return Right(response.toDomain());
      }else{
        return Left(Failure(409, response.message.orEmpty()));
      }
    }else{
      return Left(Failure(501, Constants.checkInternet));
    }
  }
  
}