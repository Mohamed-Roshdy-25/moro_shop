// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginOrRegisterOrResetPasswordDataResponse
    _$LoginOrRegisterOrResetPasswordDataResponseFromJson(
            Map<String, dynamic> json) =>
        LoginOrRegisterOrResetPasswordDataResponse(
          json['id'] as int?,
          json['name'] as String?,
          json['email'] as String?,
          json['phone'] as String?,
          json['image'] as String?,
          json['token'] as String?,
        );

Map<String, dynamic> _$LoginOrRegisterOrResetPasswordDataResponseToJson(
        LoginOrRegisterOrResetPasswordDataResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'image': instance.imageUrl,
      'token': instance.token,
    };

LoginOrRegisterOrResetPasswordResponse
    _$LoginOrRegisterOrResetPasswordResponseFromJson(
            Map<String, dynamic> json) =>
        LoginOrRegisterOrResetPasswordResponse(
          json['status'] as bool?,
          json['message'] as String?,
          json['data'] == null
              ? null
              : LoginOrRegisterOrResetPasswordDataResponse.fromJson(
                  json['data'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$LoginOrRegisterOrResetPasswordResponseToJson(
        LoginOrRegisterOrResetPasswordResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.loginOrRegisterOrResetPasswordDataResponse,
    };

ForgotPasswordResponse _$ForgotPasswordResponseFromJson(
        Map<String, dynamic> json) =>
    ForgotPasswordResponse(
      json['status'] as bool?,
      json['message'] as String?,
    );

Map<String, dynamic> _$ForgotPasswordResponseToJson(
        ForgotPasswordResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
    };

VerifyCodeResponse _$VerifyCodeResponseFromJson(Map<String, dynamic> json) =>
    VerifyCodeResponse(
      json['status'] as bool?,
      json['message'] as String?,
    );

Map<String, dynamic> _$VerifyCodeResponseToJson(VerifyCodeResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
    };

LogoutResponse _$LogoutResponseFromJson(Map<String, dynamic> json) =>
    LogoutResponse(
      json['status'] as bool?,
      json['message'] as String?,
    );

Map<String, dynamic> _$LogoutResponseToJson(LogoutResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
    };

UserDataResponse _$UserDataResponseFromJson(Map<String, dynamic> json) =>
    UserDataResponse(
      json['id'] as int?,
      json['image'] as String?,
      json['name'] as String?,
      json['email'] as String?,
      json['phone'] as String?,
    );

Map<String, dynamic> _$UserDataResponseToJson(UserDataResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'image': instance.image,
      'phone': instance.phone,
    };

ProfileResponse _$ProfileResponseFromJson(Map<String, dynamic> json) =>
    ProfileResponse(
      json['status'] as bool?,
      json['message'] as String?,
      json['data'] == null
          ? null
          : UserDataResponse.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProfileResponseToJson(ProfileResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.userDataResponse,
    };

CategoryResponse _$CategoryResponseFromJson(Map<String, dynamic> json) =>
    CategoryResponse(
      json['id'] as int?,
      json['name'] as String?,
    );

Map<String, dynamic> _$CategoryResponseToJson(CategoryResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

CategoriesDataResponse _$CategoriesDataResponseFromJson(
        Map<String, dynamic> json) =>
    CategoriesDataResponse(
      (json['data'] as List<dynamic>?)
          ?.map((e) => CategoryResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CategoriesDataResponseToJson(
        CategoriesDataResponse instance) =>
    <String, dynamic>{
      'data': instance.categoriesResponse,
    };

CategoriesResponse _$CategoriesResponseFromJson(Map<String, dynamic> json) =>
    CategoriesResponse(
      json['status'] as bool?,
      json['message'] as String?,
      json['data'] == null
          ? null
          : CategoriesDataResponse.fromJson(
              json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CategoriesResponseToJson(CategoriesResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.categoriesDataResponse,
    };

ProductResponse _$ProductResponseFromJson(Map<String, dynamic> json) =>
    ProductResponse(
      json['id'] as int?,
      (json['price'] as num?)?.toDouble(),
      (json['old_price'] as num?)?.toDouble(),
      (json['discount'] as num?)?.toDouble(),
      json['image'] as String?,
      json['name'] as String?,
      json['description'] as String?,
      (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      json['in_favorites'] as bool?,
      json['in_cart'] as bool?,
    );

Map<String, dynamic> _$ProductResponseToJson(ProductResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'price': instance.price,
      'old_price': instance.oldPrice,
      'discount': instance.discount,
      'image': instance.image,
      'name': instance.name,
      'description': instance.description,
      'images': instance.images,
      'in_favorites': instance.inFavorites,
      'in_cart': instance.inCart,
    };

CategoryAllProductsResponse _$CategoryAllProductsResponseFromJson(
        Map<String, dynamic> json) =>
    CategoryAllProductsResponse(
      (json['data'] as List<dynamic>?)
          ?.map((e) => ProductResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CategoryAllProductsResponseToJson(
        CategoryAllProductsResponse instance) =>
    <String, dynamic>{
      'data': instance.products,
    };

CategoryAllDataResponse _$CategoryAllDataResponseFromJson(
        Map<String, dynamic> json) =>
    CategoryAllDataResponse(
      json['status'] as bool?,
      json['message'] as String?,
      json['data'] == null
          ? null
          : CategoryAllProductsResponse.fromJson(
              json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CategoryAllDataResponseToJson(
        CategoryAllDataResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.categoryAllProductsResponse,
    };

AddOrDeleteFavoritesResponse _$AddOrDeleteFavoritesResponseFromJson(
        Map<String, dynamic> json) =>
    AddOrDeleteFavoritesResponse(
      json['status'] as bool?,
      json['message'] as String?,
    );

Map<String, dynamic> _$AddOrDeleteFavoritesResponseToJson(
        AddOrDeleteFavoritesResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
    };

FavoriteProductResponse _$FavoriteProductResponseFromJson(
        Map<String, dynamic> json) =>
    FavoriteProductResponse(
      json['id'] as int?,
      json['product'] == null
          ? null
          : ProductResponse.fromJson(json['product'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FavoriteProductResponseToJson(
        FavoriteProductResponse instance) =>
    <String, dynamic>{
      'id': instance.favoriteId,
      'product': instance.product,
    };

FavoriteAllProductsDataResponse _$FavoriteAllProductsDataResponseFromJson(
        Map<String, dynamic> json) =>
    FavoriteAllProductsDataResponse(
      (json['data'] as List<dynamic>?)
          ?.map((e) =>
              FavoriteProductResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FavoriteAllProductsDataResponseToJson(
        FavoriteAllProductsDataResponse instance) =>
    <String, dynamic>{
      'data': instance.favoriteProducts,
    };

FavoritesAllDataResponse _$FavoritesAllDataResponseFromJson(
        Map<String, dynamic> json) =>
    FavoritesAllDataResponse(
      json['status'] as bool?,
      json['message'] as String?,
      json['data'] == null
          ? null
          : FavoriteAllProductsDataResponse.fromJson(
              json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FavoritesAllDataResponseToJson(
        FavoritesAllDataResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.favoriteAllProductsDataResponse,
    };

DeleteFavoriteResponse _$DeleteFavoriteResponseFromJson(
        Map<String, dynamic> json) =>
    DeleteFavoriteResponse(
      json['status'] as bool?,
      json['message'] as String?,
    );

Map<String, dynamic> _$DeleteFavoriteResponseToJson(
        DeleteFavoriteResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
    };

AddOrDeleteCartsResponse _$AddOrDeleteCartsResponseFromJson(
        Map<String, dynamic> json) =>
    AddOrDeleteCartsResponse(
      json['status'] as bool?,
      json['message'] as String?,
    );

Map<String, dynamic> _$AddOrDeleteCartsResponseToJson(
        AddOrDeleteCartsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
    };

CartProductResponse _$CartProductResponseFromJson(Map<String, dynamic> json) =>
    CartProductResponse(
      json['id'] as int?,
      json['quantity'] as int?,
      json['product'] == null
          ? null
          : ProductResponse.fromJson(json['product'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CartProductResponseToJson(
        CartProductResponse instance) =>
    <String, dynamic>{
      'id': instance.cartId,
      'quantity': instance.quantity,
      'product': instance.product,
    };

CartAllProductsDataResponse _$CartAllProductsDataResponseFromJson(
        Map<String, dynamic> json) =>
    CartAllProductsDataResponse(
      (json['cart_items'] as List<dynamic>?)
          ?.map((e) => CartProductResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['total'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$CartAllProductsDataResponseToJson(
        CartAllProductsDataResponse instance) =>
    <String, dynamic>{
      'cart_items': instance.cartProducts,
      'total': instance.totalPrice,
    };

CartsAllDataResponse _$CartsAllDataResponseFromJson(
        Map<String, dynamic> json) =>
    CartsAllDataResponse(
      json['status'] as bool?,
      json['message'] as String?,
      json['data'] == null
          ? null
          : CartAllProductsDataResponse.fromJson(
              json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CartsAllDataResponseToJson(
        CartsAllDataResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.cartAllProductsDataResponse,
    };

UpdateProductQuantityInCartResponse
    _$UpdateProductQuantityInCartResponseFromJson(Map<String, dynamic> json) =>
        UpdateProductQuantityInCartResponse(
          json['status'] as bool?,
          json['message'] as String?,
        );

Map<String, dynamic> _$UpdateProductQuantityInCartResponseToJson(
        UpdateProductQuantityInCartResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
    };

DeleteCartItemResponse _$DeleteCartItemResponseFromJson(
        Map<String, dynamic> json) =>
    DeleteCartItemResponse(
      json['status'] as bool?,
      json['message'] as String?,
    );

Map<String, dynamic> _$DeleteCartItemResponseToJson(
        DeleteCartItemResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
    };

AuthTokenResponse _$AuthTokenResponseFromJson(Map<String, dynamic> json) =>
    AuthTokenResponse(
      json['token'] as String?,
    );

Map<String, dynamic> _$AuthTokenResponseToJson(AuthTokenResponse instance) =>
    <String, dynamic>{
      'token': instance.token,
    };

OrderIdResponse _$OrderIdResponseFromJson(Map<String, dynamic> json) =>
    OrderIdResponse(
      json['id'] as int?,
    );

Map<String, dynamic> _$OrderIdResponseToJson(OrderIdResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

PaymentTokenResponse _$PaymentTokenResponseFromJson(
        Map<String, dynamic> json) =>
    PaymentTokenResponse(
      json['token'] as String?,
    );

Map<String, dynamic> _$PaymentTokenResponseToJson(
        PaymentTokenResponse instance) =>
    <String, dynamic>{
      'token': instance.token,
    };
