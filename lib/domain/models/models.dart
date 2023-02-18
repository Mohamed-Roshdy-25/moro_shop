class LoginDataModel{
  int id;
  String name;
  String email;
  String phone;
  String imageUrl;
  String token;

  LoginDataModel(
      this.id, this.name, this.email, this.phone, this.imageUrl, this.token);
}

class LoginModel{
  LoginDataModel? loginDataModel;

  LoginModel(this.loginDataModel);
}