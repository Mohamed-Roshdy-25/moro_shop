import 'package:dio/dio.dart';
import 'package:moro_shop/app/constants.dart';
import 'package:moro_shop/data/responses/responses.dart';
import 'package:retrofit/retrofit.dart';
part 'app_api.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;

  @POST('login')
  Future<LoginOrRegisterOrResetPasswordResponse> login(
      @Field('email') String email, @Field('password') String password);

  @POST('register')
  Future<LoginOrRegisterOrResetPasswordResponse> register(
    @Field('email') String email,
    @Field('password') String password,
    @Field('name') String name,
    @Field('phone') String phone,
    @Field('image') String image,
  );

  @POST('verify-email')
  Future<ForgotPasswordResponse> forgotPassword(@Field('email') String email);

  @POST('verify-code')
  Future<VerifyCodeResponse> verifyCode(
      @Field('email') String email, @Field('code') String code);

  @POST('reset-password')
  Future<LoginOrRegisterOrResetPasswordResponse> resetPassword(@Field('email') String email,
      @Field('code') String code, @Field('password') String password);

  @GET('categories')
  Future<CategoriesResponse> getCategories();

  @GET('categories/{categoryId}')
  Future<CategoryAllDataResponse> getCategoryProducts(@Path('categoryId') int categoryId);
}
