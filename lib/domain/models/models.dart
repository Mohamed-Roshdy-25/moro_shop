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
  bool status;
  String message;
  LoginDataModel? loginDataModel;

  LoginModel(this.status,this.message,this.loginDataModel);
}