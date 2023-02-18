import 'package:moro_shop/data/network/app_api.dart';
import 'package:moro_shop/data/network/requests.dart';
import 'package:moro_shop/data/responses/responses.dart';

abstract class RemoteDataSource {
  Future<LoginResponse> login(LoginRequest loginRequest);
}

class RemoteDataSourceImpl implements RemoteDataSource{
  final AppServiceClient appServiceClient;


  RemoteDataSourceImpl(this.appServiceClient);

  @override
  Future<LoginResponse> login(LoginRequest loginRequest) async {
    return await appServiceClient.login(loginRequest.email, loginRequest.password);
  }

}