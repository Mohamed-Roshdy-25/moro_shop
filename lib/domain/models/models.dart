class IntroViewProduct {
  final String productName;
  final String productImageUrl;
  final String currentPrice;
  final String oldPrice;
  final bool isLiked;

  const IntroViewProduct({
    required this.productName,
    required this.productImageUrl,
    required this.currentPrice,
    required this.oldPrice,
    required this.isLiked,
  });
}


//Login & Register & Reset Password Models

class LoginOrRegisterOrResetPasswordDataModel{
  int id;
  String name;
  String email;
  String phone;
  String imageUrl;
  String token;

  LoginOrRegisterOrResetPasswordDataModel(
      this.id, this.name, this.email, this.phone, this.imageUrl, this.token);
}

class LoginOrRegisterOrResetPasswordModel{
  bool status;
  String message;
  LoginOrRegisterOrResetPasswordDataModel? loginOrRegisterOrResetPasswordDataModel;

  LoginOrRegisterOrResetPasswordModel(this.status,this.message,this.loginOrRegisterOrResetPasswordDataModel);
}

// Logout Model

class LogoutModel{
  bool status;
  String message;

  LogoutModel(this.status,this.message);
}


// ForgotPassword Model

class ForgotPasswordModel{
  bool status;
  String message;

  ForgotPasswordModel(this.status,this.message);
}


//VerifyCode Model

class VerifyCodeModel{
  bool status;
  String message;

  VerifyCodeModel(this.status,this.message);
}


//UserData Model

class UserDataModel{
  int id;
  String image;
  String name;
  String email;
  String phone;

  UserDataModel(this.id, this.image,
      this.name, this.email,this.phone);
}


class ProfileModel{
  bool status;
  String message;
  UserDataModel? userDataModel;

  ProfileModel(this.status,this.message,this.userDataModel);
}


//Categories Model

class CategoryModel{
  int id;
  String name;


  CategoryModel(this.id,this.name);
}

class CategoriesDataModel{
  List<CategoryModel>? categoriesModel;


  CategoriesDataModel(this.categoriesModel);
}

class CategoriesModel{
  bool status;
  String message;
  CategoriesDataModel? categoriesDataModel;


  CategoriesModel(this.status,this.message, this.categoriesDataModel);
}


//Category Products Model

class ProductModel{
  int id;
  double price;
  double oldPrice;
  double discount;
  String image;
  String name;
  String description;
  List<String> images;
  bool inFavorites;
  bool inCart;
  bool isLoading;

  ProductModel(this.id, this.price, this.oldPrice, this.discount, this.image,
      this.name, this.description, this.images, this.inFavorites, this.inCart,
      {this.isLoading = false});
}

class CategoryAllProductsModel{
  List<ProductModel>? products;

  CategoryAllProductsModel(this.products);
}

class CategoryAllDataModel{
  bool status;
  String message;
  CategoryAllProductsModel? categoryAllProductsModel;

  CategoryAllDataModel(this.status,this.message,this.categoryAllProductsModel);
}

// Add or delete favorite

class AddOrDeleteFavoritesModel{
  bool status;
  String message;

  AddOrDeleteFavoritesModel(this.status,this.message);
}


// Favorites Model

class FavoriteProductModel {
  int favoriteId;
  ProductModel product;

  FavoriteProductModel(this.favoriteId, this.product);
}

class FavoriteAllProductsDataModel {
  List<FavoriteProductModel>? favoriteProducts;

  FavoriteAllProductsDataModel(this.favoriteProducts);
}

class FavoritesAllDataModel {
  bool status;
  String message;
  FavoriteAllProductsDataModel? favoriteAllProductsDataModel;

  FavoritesAllDataModel(
      this.status, this.message, this.favoriteAllProductsDataModel);
}


// delete favorite model

class DeleteFavoriteModel{
  bool status;
  String message;

  DeleteFavoriteModel(this.status,this.message);
}


// Add or delete cart Model

class AddOrDeleteCartsModel {
  bool status;
  String message;

  AddOrDeleteCartsModel(this.status, this.message);
}


// Carts Model

class CartProductModel {
  int cartId;
  int quantity;
  ProductModel product;

  CartProductModel(this.cartId, this.quantity, this.product);
}

class CartAllProductsDataModel {
  List<CartProductModel>? cartProducts;
  double totalPrice;

  CartAllProductsDataModel(this.cartProducts,this.totalPrice);
}

class CartsAllDataModel {
  bool status;
  String message;
  CartAllProductsDataModel? cartAllProductsDataModel;

  CartsAllDataModel(
      this.status, this.message, this.cartAllProductsDataModel);
}

// delete cartItem model

class DeleteCartItemModel{
  bool status;
  String message;

  DeleteCartItemModel(this.status,this.message);
}

// product quantity in cart model

class UpdateProductQuantityInCartModel {
  bool status;
  String message;

  UpdateProductQuantityInCartModel(this.status, this.message);
}
