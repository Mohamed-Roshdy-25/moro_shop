class LoginOrRegisterDataModel{
  int id;
  String name;
  String email;
  String phone;
  String imageUrl;
  String token;

  LoginOrRegisterDataModel(
      this.id, this.name, this.email, this.phone, this.imageUrl, this.token);
}

class LoginOrRegisterModel{
  bool status;
  String message;
  LoginOrRegisterDataModel? loginOrRegisterDataModel;

  LoginOrRegisterModel(this.status,this.message,this.loginOrRegisterDataModel);
}

class ForgotPasswordModel{
  bool status;
  String message;

  ForgotPasswordModel(this.status,this.message);
}

class VerifyCodeModel{
  bool status;
  String message;

  VerifyCodeModel(this.status,this.message);
}

class ResetPasswordModel{
  bool status;
  String message;

  ResetPasswordModel(this.status,this.message);
}