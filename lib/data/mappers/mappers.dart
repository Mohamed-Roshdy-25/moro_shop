import 'package:moro_shop/app/extensions.dart';
import 'package:moro_shop/data/responses/responses.dart';
import 'package:moro_shop/domain/models/models.dart';

//Login & Register & Reset Password Mappers

extension LoginOrRegisterOrResetPasswordDataResponseMapper
    on LoginOrRegisterOrResetPasswordDataResponse? {
  LoginOrRegisterOrResetPasswordDataModel toDomain() {
    return LoginOrRegisterOrResetPasswordDataModel(
        (this?.id).orZero(),
        (this?.name).orEmpty(),
        (this?.email).orEmpty(),
        (this?.phone).orEmpty(),
        (this?.imageUrl).orEmpty(),
        (this?.token).orEmpty());
  }
}

extension LoginOrRegisterOrResetPasswordResponseMapper
    on LoginOrRegisterOrResetPasswordResponse? {
  LoginOrRegisterOrResetPasswordModel toDomain() {
    return LoginOrRegisterOrResetPasswordModel(
      (this?.status).orFalse(),
      (this?.message).orEmpty(),
      (this?.loginOrRegisterOrResetPasswordDataResponse).toDomain(),
    );
  }
}

// ForgotPassword Mapper

extension ForgotPasswordResponseMapper on ForgotPasswordResponse? {
  ForgotPasswordModel toDomain() {
    return ForgotPasswordModel(
      (this?.status).orFalse(),
      (this?.message).orEmpty(),
    );
  }
}

//VerifyCode Mapper

extension VerifyCodeResponseMapper on VerifyCodeResponse? {
  VerifyCodeModel toDomain() {
    return VerifyCodeModel(
      (this?.status).orFalse(),
      (this?.message).orEmpty(),
    );
  }
}

// Logout Mapper

extension LogoutResponseExtension on LogoutResponse? {
  LogoutModel toDomain() {
    return LogoutModel(
      (this?.status).orFalse(),
      (this?.message).orEmpty(),
    );
  }
}

// UserData Mappers

extension UserDataResponseExtension on UserDataResponse? {
  UserDataModel toDomain() {
    return UserDataModel(
      (this?.id).orZero(),
      (this?.image).orEmpty(),
      (this?.name).orEmpty(),
      (this?.email).orEmpty(),
      (this?.phone).orEmpty(),
    );
  }
}

extension ProfileResponseExtension on ProfileResponse? {
  ProfileModel toDomain() {
    return ProfileModel((this?.status).orFalse(), (this?.message).orEmpty(),
        (this?.userDataResponse).toDomain());
  }
}

//Categories Mapper

extension CategoryDataResponseMapper on CategoryResponse? {
  CategoryModel toDomain() {
    return CategoryModel(
      (this?.id).orZero(),
      (this?.name).orEmpty(),
    );
  }
}

extension CategoryAllDataResponseMapper on CategoriesDataResponse? {
  CategoriesDataModel toDomain() {
    List<CategoryModel> categories = (this
                ?.categoriesResponse
                ?.map((categoryResponse) => categoryResponse.toDomain()) ??
            const Iterable.empty())
        .cast<CategoryModel>()
        .toList();
    return CategoriesDataModel(categories);
  }
}

extension CategoryResponseMapper on CategoriesResponse? {
  CategoriesModel toDomain() {
    return CategoriesModel(
      (this?.status).orFalse(),
      (this?.message).orEmpty(),
      (this?.categoriesDataResponse).toDomain(),
    );
  }
}

//Category Products Mapper

extension ProductResponseExtension on ProductResponse? {
  ProductModel toDomain() {
    return ProductModel(
      (this?.id).orZero(),
      (this?.price).orZero(),
      (this?.oldPrice).orZero(),
      (this?.discount).orZero(),
      (this?.image).orEmpty(),
      (this?.name).orEmpty(),
      (this?.description).orEmpty(),
      (this?.images).orEmpty(),
      (this?.inFavorites).orFalse(),
      (this?.inCart).orFalse(),
    );
  }
}

extension CategoryAllProductsResponseExtension on CategoryAllProductsResponse? {
  CategoryAllProductsModel toDomain() {
    List<ProductModel> products =
        (this?.products?.map((productResponse) => productResponse.toDomain()) ??
                const Iterable.empty())
            .cast<ProductModel>()
            .toList();

    return CategoryAllProductsModel(products);
  }
}

extension CategoryAllDataResponseExtension on CategoryAllDataResponse? {
  CategoryAllDataModel toDomain() {
    return CategoryAllDataModel(
        (this?.status).orFalse(),
        (this?.message).orEmpty(),
        (this?.categoryAllProductsResponse).toDomain());
  }
}

// Add or delete favorite mapper

extension AddOrDeleteFavoriteResponseExtension
    on AddOrDeleteFavoritesResponse? {
  AddOrDeleteFavoritesModel toDomain() {
    return AddOrDeleteFavoritesModel(
      (this?.status).orFalse(),
      (this?.message).orEmpty(),
    );
  }
}

// Favorites Mappers

extension FavoriteProductResponseExtension on FavoriteProductResponse? {
  FavoriteProductModel toDomain() {
    return FavoriteProductModel(
      (this?.favoriteId).orZero(),
      (this?.product).toDomain(),
    );
  }
}

extension FavoriteAllProductsDataResponseExtension
    on FavoriteAllProductsDataResponse? {
  FavoriteAllProductsDataModel toDomain() {
    List<FavoriteProductModel> favoriteProducts = (this?.favoriteProducts?.map(
                (favoriteProductResponse) =>
                    favoriteProductResponse.toDomain()) ??
            const Iterable.empty())
        .cast<FavoriteProductModel>()
        .toList();

    return FavoriteAllProductsDataModel(favoriteProducts);
  }
}

extension FavoritesAllDataResponseExtension on FavoritesAllDataResponse? {
  FavoritesAllDataModel toDomain() {
    return FavoritesAllDataModel(
      (this?.status).orFalse(),
      (this?.message).orEmpty(),
      (this?.favoriteAllProductsDataResponse).toDomain(),
    );
  }
}

// delete favorite mapper

extension DeleteFavoriteResponseExtension
on DeleteFavoriteResponse? {
  DeleteFavoriteModel toDomain() {
    return DeleteFavoriteModel(
      (this?.status).orFalse(),
      (this?.message).orEmpty(),
    );
  }
}

// Add or delete Cart Mapper

extension AddOrDeleteCartResponseExtension on AddOrDeleteCartsResponse? {
  AddOrDeleteCartsModel toDomain() {
    return AddOrDeleteCartsModel(
      (this?.status).orFalse(),
      (this?.message).orEmpty(),
    );
  }
}

// Carts Mappers

extension CartProductResponseExtension on CartProductResponse? {
  CartProductModel toDomain() {
    return CartProductModel(
      (this?.cartId).orZero(),
      (this?.quantity).orZero(),
      (this?.product).toDomain(),
    );
  }
}

extension CartAllProductsDataResponseExtension on CartAllProductsDataResponse? {
  CartAllProductsDataModel toDomain() {
    List<CartProductModel> cartProducts = (this?.cartProducts?.map(
                (cartProductResponse) => cartProductResponse.toDomain()) ??
            const Iterable.empty())
        .cast<CartProductModel>()
        .toList();

    return CartAllProductsDataModel(
      cartProducts,
      this?.totalPrice??0,
    );
  }
}

extension CartsAllDataResponseExtension on CartsAllDataResponse? {
  CartsAllDataModel toDomain() {
    return CartsAllDataModel(
      (this?.status).orFalse(),
      (this?.message).orEmpty(),
      (this?.cartAllProductsDataResponse).toDomain(),
    );
  }
}

// delete cartItem mapper

extension DeleteCartItemResponseExtension
on DeleteCartItemResponse? {
  DeleteCartItemModel toDomain() {
    return DeleteCartItemModel(
      (this?.status).orFalse(),
      (this?.message).orEmpty(),
    );
  }
}

// update cartItem quantity mapper

extension UpdateProductQuantityInCartExtension
    on UpdateProductQuantityInCartResponse? {
  UpdateProductQuantityInCartModel toDomain() {
    return UpdateProductQuantityInCartModel(
      (this?.status).orFalse(),
      (this?.message).orEmpty(),
    );
  }
}
