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