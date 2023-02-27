// ignore_for_file: depend_on_referenced_packages

import 'package:freezed_annotation/freezed_annotation.dart';
part 'freezed_data_classes.freezed.dart';

@freezed
class LoginObject with _$LoginObject {
  factory LoginObject(String email, String password) = _LoginObject;
}

@freezed
class RegisterObject with _$RegisterObject {
  factory RegisterObject(String email, String password, String name,
      String phone, String image) = _RegisterObject;
}


@freezed
class ForgotPasswordObject with _$ForgotPasswordObject {
  factory ForgotPasswordObject(String email) = _ForgotPasswordObject;
}

@freezed
class VerifyCodeObject with _$VerifyCodeObject {
  factory VerifyCodeObject(String email,String code) = _VerifyCodeObject;
}

@freezed
class ResetPasswordObject with _$ResetPasswordObject {
  factory ResetPasswordObject(String email,String code,String password) = _ResetPasswordObject;
}