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

//Categories Response

@JsonSerializable()
class CategoryResponse {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'image')
  String? image;

  CategoryResponse(this.id, this.name, this.image);

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

  UserDataResponse(this.id, this.image, this.name,this.email,this.phone);

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

  ProfileResponse(
      this.status, this.message, this.userDataResponse);

  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$ProfileResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileResponseToJson(this);
}
