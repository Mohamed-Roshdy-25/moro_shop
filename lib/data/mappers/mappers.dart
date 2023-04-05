import 'package:moro_shop/app/extensions.dart';
import 'package:moro_shop/data/responses/responses.dart';
import 'package:moro_shop/domain/models/models.dart';

//Login & Register & Reset Password Mappers

extension LoginOrRegisterOrResetPasswordDataResponseMapper
    on LoginOrRegisterOrResetPasswordDataResponse? {
  LoginOrRegisterOrResetPasswordDataModel toDomain() {
    return LoginOrRegisterOrResetPasswordDataModel((this?.id).orZero(), (this?.name).orEmpty(),
        (this?.email).orEmpty(), (this?.phone).orEmpty(), (this?.imageUrl).orEmpty(), (this?.token).orEmpty());
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
    List<CategoryModel> categories = (this?.categoriesResponse?.map((categoryResponse) => categoryResponse.toDomain())??const Iterable.empty()).cast<CategoryModel>().toList();
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

      List<ProductModel> products = ( this?.products?.map((productResponse) => productResponse.toDomain())??const Iterable.empty()).cast<ProductModel>().toList();

    return CategoryAllProductsModel(products);
  }
}

extension CategoryAllDataResponseExtension on CategoryAllDataResponse? {
  CategoryAllDataModel toDomain(){
    return CategoryAllDataModel(
        (this?.status).orFalse(),
        (this?.message).orEmpty(),
        (this?.categoryAllProductsResponse).toDomain());
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
  ProfileModel toDomain(){
    return ProfileModel(
        (this?.status).orFalse(),
        (this?.message).orEmpty(),
        (this?.userDataResponse).toDomain());
  }
}

extension AddOrDeleteFavoriteResponseExtension on AddOrDeleteFavoritesResponse? {
  AddOrDeleteFavoritesModel toDomain(){
    return AddOrDeleteFavoritesModel(
        (this?.status).orFalse(),
        (this?.message).orEmpty(),
        );
  }
}

extension LogoutResponseExtension on LogoutResponse? {
  LogoutModel toDomain(){
    return LogoutModel(
      (this?.status).orFalse(),
      (this?.message).orEmpty(),
    );
  }
}