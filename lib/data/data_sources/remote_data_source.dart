import 'package:moro_shop/data/network/app_api.dart';
import 'package:moro_shop/data/network/requests.dart';
import 'package:moro_shop/data/responses/responses.dart';

abstract class RemoteDataSource {
  Future<LoginOrRegisterResponse> login(LoginRequest loginRequest);
  Future<LoginOrRegisterResponse> register(RegisterRequest registerRequest);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final AppServiceClient appServiceClient;

  RemoteDataSourceImpl(this.appServiceClient);

  @override
  Future<LoginOrRegisterResponse> login(LoginRequest loginRequest) async {
    return await appServiceClient.login(
        loginRequest.email, loginRequest.password);
  }

  @override
  Future<LoginOrRegisterResponse> register(
      RegisterRequest registerRequest) async {
    return await appServiceClient.register(
      registerRequest.email,
      registerRequest.password,
      registerRequest.name,
      registerRequest.phone,
      registerRequest.image,
    );
  }
}
