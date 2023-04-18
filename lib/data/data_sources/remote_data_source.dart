import 'package:moro_shop/data/network/dio_helper.dart';
import 'package:moro_shop/data/network/end_points.dart';
import 'package:moro_shop/data/network/requests.dart';
import 'package:moro_shop/data/responses/responses.dart';

abstract class RemoteDataSource {
  Future<LoginOrRegisterOrResetPasswordResponse> login(
      LoginRequest loginRequest);
  Future<LoginOrRegisterOrResetPasswordResponse> register(
      RegisterRequest registerRequest);
  Future<ForgotPasswordResponse> forgotPassword(
      ForgotPasswordRequest forgotPasswordRequest);
  Future<VerifyCodeResponse> verifyCode(VerifyCodeRequest verifyCodeRequest);
  Future<LoginOrRegisterOrResetPasswordResponse> resetPassword(
      ResetPasswordRequest resetPasswordRequest);
  Future<LogoutResponse> logout();
  Future<ProfileResponse> getProfile();
  Future<CategoriesResponse> getCategories();
  Future<CategoryAllDataResponse> getCategoryProducts(int categoryId);
  Future<AddOrDeleteFavoritesResponse> addOrDeleteFavorite(
      AddOrDeleteFavoritesRequest addOrDeleteFavoritesRequest);
  Future<AddOrDeleteCartsResponse> addOrDeleteCart(
      AddOrDeleteCartsRequest addOrDeleteCartsRequest);
  Future<DeleteFavoriteResponse> deleteFavorite(
      DeleteFavoriteRequest deleteFavoriteRequest);
  Future<DeleteCartItemResponse> deleteCartItem(
      DeleteCartItemRequest deleteCartItemRequest);
  Future<FavoritesAllDataResponse> getFavorites();
  Future<CartsAllDataResponse> getCarts();
  Future<UpdateProductQuantityInCartResponse> updateProductQuantityInCart(
      UpdateProductQuantityInCartRequest updateProductQuantityInCartRequest);
}

class RemoteDataSourceImpl implements RemoteDataSource {

  DioHelper dioHelper;

  RemoteDataSourceImpl(this.dioHelper);

  @override
  Future<LoginOrRegisterOrResetPasswordResponse> login(
      LoginRequest loginRequest) async {
    final response = await dioHelper.postData(
      url: LOGIN,
      data: {'email': loginRequest.email, 'password': loginRequest.password},
    );
    LoginOrRegisterOrResetPasswordResponse loginResponse =
        LoginOrRegisterOrResetPasswordResponse.fromJson(response.data);
    return loginResponse;
  }

  @override
  Future<LoginOrRegisterOrResetPasswordResponse> register(
      RegisterRequest registerRequest) async {
    final response = await dioHelper.postData(
      url: REGISTER,
      data: {
        'email': registerRequest.email,
        'password': registerRequest.password,
        'name': registerRequest.name,
        'phone': registerRequest.phone,
        'image': registerRequest.image,
      },
    );
    LoginOrRegisterOrResetPasswordResponse registerResponse =
        LoginOrRegisterOrResetPasswordResponse.fromJson(response.data);
    return registerResponse;
  }

  @override
  Future<ForgotPasswordResponse> forgotPassword(
      ForgotPasswordRequest forgotPasswordRequest) async {
    final response = await dioHelper.postData(
      url: FORGOT_PASSWORD,
      data: {
        'email': forgotPasswordRequest.email,
      },
    );
    ForgotPasswordResponse forgotPasswordResponse =
        ForgotPasswordResponse.fromJson(response.data);
    return forgotPasswordResponse;
  }

  @override
  Future<VerifyCodeResponse> verifyCode(
      VerifyCodeRequest verifyCodeRequest) async {
    final response = await dioHelper.postData(
      url: VERIFY_CODE,
      data: {
        'email': verifyCodeRequest.email,
        'code': verifyCodeRequest.code,
      },
    );
    VerifyCodeResponse verifyCodeResponse =
        VerifyCodeResponse.fromJson(response.data);
    return verifyCodeResponse;
  }

  @override
  Future<LoginOrRegisterOrResetPasswordResponse> resetPassword(
      ResetPasswordRequest resetPasswordRequest) async {
    final response = await dioHelper.postData(
      url: RESET_PASSWORD,
      data: {
        'email': resetPasswordRequest.email,
        'code': resetPasswordRequest.code,
        'password': resetPasswordRequest.password,
      },
    );
    LoginOrRegisterOrResetPasswordResponse resetPasswordResponse =
        LoginOrRegisterOrResetPasswordResponse.fromJson(response.data);
    return resetPasswordResponse;
  }

  @override
  Future<LogoutResponse> logout() async {
    final response = await dioHelper.postData(url: LOGOUT, data: {});
    LogoutResponse logoutResponse = LogoutResponse.fromJson(response.data);
    return logoutResponse;
  }

  @override
  Future<ProfileResponse> getProfile() async {
    final response = await dioHelper.getData(url: PROFILE);
    ProfileResponse profileResponse = ProfileResponse.fromJson(response.data);
    return profileResponse;
  }

  @override
  Future<CategoriesResponse> getCategories() async {
    final response = await dioHelper.getData(url: CATEGORIES);
    CategoriesResponse categoriesResponse =
        CategoriesResponse.fromJson(response.data);
    return categoriesResponse;
  }

  @override
  Future<CategoryAllDataResponse> getCategoryProducts(int categoryId) async {
    final response = await dioHelper.getData(url: '$CATEGORIES/$categoryId');
    CategoryAllDataResponse categoryAllDataResponse =
        CategoryAllDataResponse.fromJson(response.data);
    return categoryAllDataResponse;
  }

  @override
  Future<AddOrDeleteFavoritesResponse> addOrDeleteFavorite(
      AddOrDeleteFavoritesRequest addOrDeleteFavoritesRequest) async {
    final response = await dioHelper.postData(
        url: FAVORITES,
        data: {'product_id': addOrDeleteFavoritesRequest.productId});
    AddOrDeleteFavoritesResponse addOrDeleteFavoritesResponse =
        AddOrDeleteFavoritesResponse.fromJson(response.data);
    return addOrDeleteFavoritesResponse;
  }

  @override
  Future<AddOrDeleteCartsResponse> addOrDeleteCart(
      AddOrDeleteCartsRequest addOrDeleteCartsRequest) async {
    final response = await dioHelper.postData(
        url: FAVORITES,
        data: {'product_id': addOrDeleteCartsRequest.productId});
    AddOrDeleteCartsResponse addOrDeleteCartsResponse =
        AddOrDeleteCartsResponse.fromJson(response.data);
    return addOrDeleteCartsResponse;
  }

  @override
  Future<CartsAllDataResponse> getCarts() async {
    final response = await dioHelper.getData(url: CARTS);
    CartsAllDataResponse cartsAllDataResponse =
        CartsAllDataResponse.fromJson(response.data);
    return cartsAllDataResponse;
  }

  @override
  Future<FavoritesAllDataResponse> getFavorites() async {
    final response = await dioHelper.getData(url: FAVORITES);
    FavoritesAllDataResponse favoritesAllDataResponse =
        FavoritesAllDataResponse.fromJson(response.data);
    return favoritesAllDataResponse;
  }

  @override
  Future<DeleteFavoriteResponse> deleteFavorite(
      DeleteFavoriteRequest deleteFavoriteRequest) async {
    final response = await dioHelper.deleteData(
        url: '$FAVORITES/${deleteFavoriteRequest.favoriteItemId}');
    DeleteFavoriteResponse deleteFavoriteResponse =
        DeleteFavoriteResponse.fromJson(response.data);
    return deleteFavoriteResponse;
  }

  @override
  Future<DeleteCartItemResponse> deleteCartItem(
      DeleteCartItemRequest deleteCartItemRequest) async {
    final response = await dioHelper.deleteData(
        url: '$CARTS/${deleteCartItemRequest.cartItemId}');
    DeleteCartItemResponse deleteCartItemResponse =
        DeleteCartItemResponse.fromJson(response.data);
    return deleteCartItemResponse;
  }

  @override
  Future<UpdateProductQuantityInCartResponse> updateProductQuantityInCart(
      UpdateProductQuantityInCartRequest
          updateProductQuantityInCartRequest) async {
    final response = await dioHelper.putData(
      url: '$CARTS/${updateProductQuantityInCartRequest.cartItemId}',
      data: {
        'quantity': updateProductQuantityInCartRequest.quantity,
      },
    );
    UpdateProductQuantityInCartResponse updateProductQuantityInCartResponse =
        UpdateProductQuantityInCartResponse.fromJson(response.data);
    return updateProductQuantityInCartResponse;
  }
}
