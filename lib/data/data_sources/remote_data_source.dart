import 'package:moro_shop/data/network/app_api.dart';
import 'package:moro_shop/data/network/requests.dart';
import 'package:moro_shop/data/responses/responses.dart';

abstract class RemoteDataSource {
  Future<LoginOrRegisterOrResetPasswordResponse> login(LoginRequest loginRequest);
  Future<LoginOrRegisterOrResetPasswordResponse> register(RegisterRequest registerRequest);
  Future<ForgotPasswordResponse> forgotPassword(ForgotPasswordRequest forgotPasswordRequest);
  Future<VerifyCodeResponse> verifyCode(VerifyCodeRequest verifyCodeRequest);
  Future<LoginOrRegisterOrResetPasswordResponse> resetPassword(ResetPasswordRequest resetPasswordRequest);
  Future<CategoriesResponse> getCategories();
  Future<CategoryAllDataResponse> getCategoryProducts(int categoryId);
  Future<ProfileResponse> getProfile();
  Future<AddOrDeleteFavoritesResponse> favorite(AddOrDeleteFavoritesRequest addOrDeleteFavoritesRequest);
  Future<LogoutResponse> logout();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final AppServiceClient appServiceClient;

  RemoteDataSourceImpl(this.appServiceClient);

  @override
  Future<LoginOrRegisterOrResetPasswordResponse> login(LoginRequest loginRequest) async {
    return await appServiceClient.login(
        loginRequest.email, loginRequest.password);
  }

  @override
  Future<LoginOrRegisterOrResetPasswordResponse> register(
      RegisterRequest registerRequest) async {
    return await appServiceClient.register(
      registerRequest.email,
      registerRequest.password,
      registerRequest.name,
      registerRequest.phone,
      registerRequest.image,
    );
  }

  @override
  Future<ForgotPasswordResponse> forgotPassword(ForgotPasswordRequest forgotPasswordRequest) async {
    return await appServiceClient.forgotPassword(forgotPasswordRequest.email);
  }

  @override
  Future<VerifyCodeResponse> verifyCode(VerifyCodeRequest verifyCodeRequest) async {
    return await appServiceClient.verifyCode(verifyCodeRequest.email, verifyCodeRequest.code);
  }

  @override
  Future<LoginOrRegisterOrResetPasswordResponse> resetPassword(ResetPasswordRequest resetPasswordRequest) async {
    return await appServiceClient.resetPassword(resetPasswordRequest.email, resetPasswordRequest.code, resetPasswordRequest.password);
  }

  @override
  Future<CategoriesResponse> getCategories() async {
    return await appServiceClient.getCategories();
  }

  @override
  Future<CategoryAllDataResponse> getCategoryProducts(int categoryId) async {
    return await appServiceClient.getCategoryProducts(categoryId);
  }

  @override
  Future<ProfileResponse> getProfile() async {
    return await appServiceClient.getProfile();
  }

  @override
  Future<AddOrDeleteFavoritesResponse> favorite(AddOrDeleteFavoritesRequest addOrDeleteFavoritesRequest) async {
    return await appServiceClient.favorites(addOrDeleteFavoritesRequest.productId);
  }

  @override
  Future<LogoutResponse> logout() async {
    return await appServiceClient.logout();
  }
}
