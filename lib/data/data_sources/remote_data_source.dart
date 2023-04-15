import 'package:moro_shop/data/network/app_api.dart';
import 'package:moro_shop/data/network/requests.dart';
import 'package:moro_shop/data/responses/responses.dart';

abstract class RemoteDataSource {
  Future<LoginOrRegisterOrResetPasswordResponse> login(LoginRequest loginRequest);
  Future<LoginOrRegisterOrResetPasswordResponse> register(RegisterRequest registerRequest);
  Future<ForgotPasswordResponse> forgotPassword(ForgotPasswordRequest forgotPasswordRequest);
  Future<VerifyCodeResponse> verifyCode(VerifyCodeRequest verifyCodeRequest);
  Future<LoginOrRegisterOrResetPasswordResponse> resetPassword(ResetPasswordRequest resetPasswordRequest);
  Future<LogoutResponse> logout();
  Future<ProfileResponse> getProfile();
  Future<CategoriesResponse> getCategories();
  Future<CategoryAllDataResponse> getCategoryProducts(int categoryId);
  Future<AddOrDeleteFavoritesResponse> addOrDeleteFavorite(AddOrDeleteFavoritesRequest addOrDeleteFavoritesRequest);
  Future<AddOrDeleteCartsResponse> addOrDeleteCart(AddOrDeleteCartsRequest addOrDeleteCartsRequest);
  Future<DeleteFavoriteResponse> deleteFavorite(DeleteFavoriteRequest deleteFavoriteRequest);
  Future<DeleteCartItemResponse> deleteCartItem(DeleteCartItemRequest deleteCartItemRequest);
  Future<FavoritesAllDataResponse> getFavorites();
  Future<CartsAllDataResponse> getCarts();
  Future<UpdateProductQuantityInCartResponse> updateProductQuantityInCart(UpdateProductQuantityInCartRequest updateProductQuantityInCartRequest);
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
  Future<LogoutResponse> logout() async {
    return await appServiceClient.logout();
  }

  @override
  Future<ProfileResponse> getProfile() async {
    return await appServiceClient.getProfile();
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
  Future<AddOrDeleteFavoritesResponse> addOrDeleteFavorite(AddOrDeleteFavoritesRequest addOrDeleteFavoritesRequest) async {
    return await appServiceClient.addOrDeleteFavorite(addOrDeleteFavoritesRequest.productId);
  }

  @override
  Future<AddOrDeleteCartsResponse> addOrDeleteCart(AddOrDeleteCartsRequest addOrDeleteCartsRequest) async {
    return await appServiceClient.addOrDeleteCart(addOrDeleteCartsRequest.productId);
  }

  @override
  Future<CartsAllDataResponse> getCarts() async {
    return await appServiceClient.getCarts();
  }

  @override
  Future<FavoritesAllDataResponse> getFavorites() async {
    return await appServiceClient.getFavorites();
  }

  @override
  Future<DeleteFavoriteResponse> deleteFavorite(DeleteFavoriteRequest deleteFavoriteRequest) async {
    return await appServiceClient.deleteFavorite(deleteFavoriteRequest.favoriteItemId);
  }

  @override
  Future<DeleteCartItemResponse> deleteCartItem(DeleteCartItemRequest deleteCartItemRequest) async {
    return await appServiceClient.deleteCartItem(deleteCartItemRequest.cartItemId);
  }

  @override
  Future<UpdateProductQuantityInCartResponse> updateProductQuantityInCart(UpdateProductQuantityInCartRequest updateProductQuantityInCartRequest) async {
    return await appServiceClient.updateProductQuantityInCart(updateProductQuantityInCartRequest.cartItemId, updateProductQuantityInCartRequest.quantity);
  }
}
