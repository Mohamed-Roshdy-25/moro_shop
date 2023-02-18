import 'package:dio/dio.dart';
import 'package:moro_shop/app/constants.dart';
import 'package:moro_shop/data/responses/responses.dart';
import 'package:retrofit/retrofit.dart';
part 'app_api.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio,{String baseUrl}) = _AppServiceClient;

  @POST('login')
  Future<LoginResponse> login(@Field('email') String email,@Field('password') String password);
}