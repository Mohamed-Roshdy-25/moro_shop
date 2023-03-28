class LoginRequest{
  String email;
  String password;

  LoginRequest(this.email, this.password);
}

class RegisterRequest{
  String email;
  String password;
  String name;
  String phone;
  String image;

  RegisterRequest(this.email, this.password, this.name, this.phone, this.image);
}

class ForgotPasswordRequest{
  String email;


  ForgotPasswordRequest(this.email);
}

class VerifyCodeRequest{
  String email;
  String code;


  VerifyCodeRequest(this.email,this.code);
}

class ResetPasswordRequest{
  String email;
  String code;
  String password;

  ResetPasswordRequest(this.email,this.code,this.password);
}

class AddOrDeleteFavoritesRequest{
  int productId;


  AddOrDeleteFavoritesRequest(this.productId);
}