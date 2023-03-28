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


//Categories Model

class CategoryModel{
  int id;
  String name;
  String image;


  CategoryModel(this.id,this.name,this.image);
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
  bool isToast;

  ProductModel(this.id, this.price, this.oldPrice, this.discount, this.image,
      this.name, this.description, this.images, this.inFavorites, this.inCart,
      {this.isLoading = false,this.isToast = false});
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

//UserData Response

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


class AddOrDeleteFavoritesModel{
  bool status;
  String message;

  AddOrDeleteFavoritesModel(this.status,this.message);
}

class LogoutModel{
  bool status;
  String message;

  LogoutModel(this.status,this.message);
}