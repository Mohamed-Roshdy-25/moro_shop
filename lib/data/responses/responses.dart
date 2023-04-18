// ignore_for_file: depend_on_referenced_packages

import 'package:json_annotation/json_annotation.dart';
part 'responses.g.dart';

//Login & Register & Reset Password Responses

@JsonSerializable()
class LoginOrRegisterOrResetPasswordDataResponse {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'email')
  String? email;
  @JsonKey(name: 'phone')
  String? phone;
  @JsonKey(name: 'image')
  String? imageUrl;
  @JsonKey(name: 'token')
  String? token;

  LoginOrRegisterOrResetPasswordDataResponse(
      this.id, this.name, this.email, this.phone, this.imageUrl, this.token);

  factory LoginOrRegisterOrResetPasswordDataResponse.fromJson(
          Map<String, dynamic> json) =>
      _$LoginOrRegisterOrResetPasswordDataResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$LoginOrRegisterOrResetPasswordDataResponseToJson(this);
}

@JsonSerializable()
class LoginOrRegisterOrResetPasswordResponse {
  @JsonKey(name: 'status')
  bool? status;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'data')
  LoginOrRegisterOrResetPasswordDataResponse?
      loginOrRegisterOrResetPasswordDataResponse;

  LoginOrRegisterOrResetPasswordResponse(this.status, this.message,
      this.loginOrRegisterOrResetPasswordDataResponse);

  factory LoginOrRegisterOrResetPasswordResponse.fromJson(
          Map<String, dynamic> json) =>
      _$LoginOrRegisterOrResetPasswordResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$LoginOrRegisterOrResetPasswordResponseToJson(this);
}

// ForgotPassword Response

@JsonSerializable()
class ForgotPasswordResponse {
  @JsonKey(name: 'status')
  bool? status;
  @JsonKey(name: 'message')
  String? message;

  ForgotPasswordResponse(this.status, this.message);

  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ForgotPasswordResponseToJson(this);
}

//VerifyCode Response

@JsonSerializable()
class VerifyCodeResponse {
  @JsonKey(name: 'status')
  bool? status;
  @JsonKey(name: 'message')
  String? message;

  VerifyCodeResponse(this.status, this.message);

  factory VerifyCodeResponse.fromJson(Map<String, dynamic> json) =>
      _$VerifyCodeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyCodeResponseToJson(this);
}

// LogoutResponse

@JsonSerializable()
class LogoutResponse {
  @JsonKey(name: 'status')
  bool? status;
  @JsonKey(name: 'message')
  String? message;

  LogoutResponse(this.status, this.message);

  factory LogoutResponse.fromJson(Map<String, dynamic> json) =>
      _$LogoutResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LogoutResponseToJson(this);
}

// userData Response

@JsonSerializable()
class UserDataResponse {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'email')
  String? email;
  @JsonKey(name: 'image')
  String? image;
  @JsonKey(name: 'phone')
  String? phone;

  UserDataResponse(this.id, this.image, this.name, this.email, this.phone);

  factory UserDataResponse.fromJson(Map<String, dynamic> json) =>
      _$UserDataResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UserDataResponseToJson(this);
}

@JsonSerializable()
class ProfileResponse {
  @JsonKey(name: 'status')
  bool? status;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'data')
  UserDataResponse? userDataResponse;

  ProfileResponse(this.status, this.message, this.userDataResponse);

  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$ProfileResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileResponseToJson(this);
}


//Categories Response

@JsonSerializable()
class CategoryResponse {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;

  CategoryResponse(this.id, this.name);

  factory CategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryResponseToJson(this);
}

@JsonSerializable()
class CategoriesDataResponse {
  @JsonKey(name: 'data')
  List<CategoryResponse>? categoriesResponse;

  CategoriesDataResponse(this.categoriesResponse);

  factory CategoriesDataResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoriesDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CategoriesDataResponseToJson(this);
}

@JsonSerializable()
class CategoriesResponse {
  @JsonKey(name: 'status')
  bool? status;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'data')
  CategoriesDataResponse? categoriesDataResponse;

  CategoriesResponse(this.status, this.message, this.categoriesDataResponse);

  factory CategoriesResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoriesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CategoriesResponseToJson(this);
}

//Category Products Response

@JsonSerializable()
class ProductResponse {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'price')
  double? price;
  @JsonKey(name: 'old_price')
  double? oldPrice;
  @JsonKey(name: 'discount')
  double? discount;
  @JsonKey(name: 'image')
  String? image;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'images')
  List<String>? images;
  @JsonKey(name: 'in_favorites')
  bool? inFavorites;
  @JsonKey(name: 'in_cart')
  bool? inCart;

  ProductResponse(this.id, this.price, this.oldPrice, this.discount, this.image,
      this.name, this.description, this.images, this.inFavorites, this.inCart);

  factory ProductResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ProductResponseToJson(this);
}

@JsonSerializable()
class CategoryAllProductsResponse {
  @JsonKey(name: 'data')
  List<ProductResponse>? products;

  CategoryAllProductsResponse(this.products);

  factory CategoryAllProductsResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoryAllProductsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryAllProductsResponseToJson(this);
}

@JsonSerializable()
class CategoryAllDataResponse {
  @JsonKey(name: 'status')
  bool? status;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'data')
  CategoryAllProductsResponse? categoryAllProductsResponse;

  CategoryAllDataResponse(
      this.status, this.message, this.categoryAllProductsResponse);

  factory CategoryAllDataResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoryAllDataResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryAllDataResponseToJson(this);
}


// Add or delete favorite response

@JsonSerializable()
class AddOrDeleteFavoritesResponse {
  @JsonKey(name: 'status')
  bool? status;
  @JsonKey(name: 'message')
  String? message;

  AddOrDeleteFavoritesResponse(this.status, this.message);

  factory AddOrDeleteFavoritesResponse.fromJson(Map<String, dynamic> json) =>
      _$AddOrDeleteFavoritesResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AddOrDeleteFavoritesResponseToJson(this);
}

// Favorites Response

@JsonSerializable()
class FavoriteProductResponse {
  @JsonKey(name: 'id')
  int? favoriteId;
  @JsonKey(name: 'product')
  ProductResponse? product;

  FavoriteProductResponse(this.favoriteId, this.product);

  factory FavoriteProductResponse.fromJson(Map<String, dynamic> json) =>
      _$FavoriteProductResponseFromJson(json);
  Map<String, dynamic> toJson() => _$FavoriteProductResponseToJson(this);
}

@JsonSerializable()
class FavoriteAllProductsDataResponse {
  @JsonKey(name: 'data')
  List<FavoriteProductResponse>? favoriteProducts;

  FavoriteAllProductsDataResponse(this.favoriteProducts);

  factory FavoriteAllProductsDataResponse.fromJson(Map<String, dynamic> json) =>
      _$FavoriteAllProductsDataResponseFromJson(json);
  Map<String, dynamic> toJson() =>
      _$FavoriteAllProductsDataResponseToJson(this);
}

@JsonSerializable()
class FavoritesAllDataResponse {
  @JsonKey(name: 'status')
  bool? status;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'data')
  FavoriteAllProductsDataResponse? favoriteAllProductsDataResponse;

  FavoritesAllDataResponse(
      this.status, this.message, this.favoriteAllProductsDataResponse);

  factory FavoritesAllDataResponse.fromJson(Map<String, dynamic> json) =>
      _$FavoritesAllDataResponseFromJson(json);
  Map<String, dynamic> toJson() => _$FavoritesAllDataResponseToJson(this);
}

// delete favorite response

@JsonSerializable()
class DeleteFavoriteResponse {
  @JsonKey(name: 'status')
  bool? status;
  @JsonKey(name: 'message')
  String? message;

  DeleteFavoriteResponse(this.status, this.message);

  factory DeleteFavoriteResponse.fromJson(Map<String, dynamic> json) =>
      _$DeleteFavoriteResponseFromJson(json);
  Map<String, dynamic> toJson() => _$DeleteFavoriteResponseToJson(this);
}


// Add or delete cart response

@JsonSerializable()
class AddOrDeleteCartsResponse {
  @JsonKey(name: 'status')
  bool? status;
  @JsonKey(name: 'message')
  String? message;

  AddOrDeleteCartsResponse(this.status, this.message);

  factory AddOrDeleteCartsResponse.fromJson(Map<String, dynamic> json) =>
      _$AddOrDeleteCartsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AddOrDeleteCartsResponseToJson(this);
}


// Carts Response

@JsonSerializable()
class CartProductResponse {
  @JsonKey(name: 'id')
  int? cartId;
  @JsonKey(name: 'quantity')
  int? quantity;
  @JsonKey(name: 'product')
  ProductResponse? product;

  CartProductResponse(this.cartId, this.quantity, this.product);

  factory CartProductResponse.fromJson(Map<String, dynamic> json) =>
      _$CartProductResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CartProductResponseToJson(this);
}

@JsonSerializable()
class CartAllProductsDataResponse {
  @JsonKey(name: 'cart_items')
  List<CartProductResponse>? cartProducts;
  @JsonKey(name: 'total')
  double? totalPrice;

  CartAllProductsDataResponse(this.cartProducts,this.totalPrice);

  factory CartAllProductsDataResponse.fromJson(Map<String, dynamic> json) =>
      _$CartAllProductsDataResponseFromJson(json);
  Map<String, dynamic> toJson() =>
      _$CartAllProductsDataResponseToJson(this);
}

@JsonSerializable()
class CartsAllDataResponse {
  @JsonKey(name: 'status')
  bool? status;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'data')
  CartAllProductsDataResponse? cartAllProductsDataResponse;

  CartsAllDataResponse(
      this.status, this.message, this.cartAllProductsDataResponse);

  factory CartsAllDataResponse.fromJson(Map<String, dynamic> json) =>
      _$CartsAllDataResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CartsAllDataResponseToJson(this);
}

// product quantity in cart response

@JsonSerializable()
class UpdateProductQuantityInCartResponse {
  @JsonKey(name: 'status')
  bool? status;
  @JsonKey(name: 'message')
  String? message;

  UpdateProductQuantityInCartResponse(this.status, this.message);

  factory UpdateProductQuantityInCartResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdateProductQuantityInCartResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateProductQuantityInCartResponseToJson(this);
}

// delete cartItem response

@JsonSerializable()
class DeleteCartItemResponse {
  @JsonKey(name: 'status')
  bool? status;
  @JsonKey(name: 'message')
  String? message;

  DeleteCartItemResponse(this.status, this.message);

  factory DeleteCartItemResponse.fromJson(Map<String, dynamic> json) =>
      _$DeleteCartItemResponseFromJson(json);
  Map<String, dynamic> toJson() => _$DeleteCartItemResponseToJson(this);
}

// payment responses

@JsonSerializable()
class AuthTokenResponse{
  @JsonKey(name: 'token')
  String? token;

  AuthTokenResponse(this.token);

  factory AuthTokenResponse.fromJson(Map<String, dynamic> json) => _$AuthTokenResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthTokenResponseToJson(this);
}

@JsonSerializable()
class OrderIdResponse{
  @JsonKey(name: 'id')
  int? id;

  OrderIdResponse(this.id);

  factory OrderIdResponse.fromJson(Map<String, dynamic> json) => _$OrderIdResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OrderIdResponseToJson(this);
}

@JsonSerializable()
class PaymentTokenResponse{
  @JsonKey(name: 'token')
  String? token;

  PaymentTokenResponse(this.token);

  factory PaymentTokenResponse.fromJson(Map<String, dynamic> json) => _$PaymentTokenResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentTokenResponseToJson(this);
}