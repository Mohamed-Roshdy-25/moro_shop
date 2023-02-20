// ignore_for_file: depend_on_referenced_packages

import 'package:json_annotation/json_annotation.dart';
part 'responses.g.dart';

@JsonSerializable()
class LoginDataResponse {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'email')
  String? email;
  @JsonKey(name: 'phone')
  String? phone;
  @JsonKey(name: 'image')
  String? imageUrl;
  @JsonKey(name: 'token')
  String? token;

  LoginDataResponse(
      this.id, this.name, this.email, this.phone, this.imageUrl, this.token);

  factory LoginDataResponse.fromJson(Map<String,dynamic> json) => _$LoginDataResponseFromJson(json);

  Map<String,dynamic> toJson() => _$LoginDataResponseToJson(this);
}

@JsonSerializable()
class LoginResponse{
  @JsonKey(name: 'status')
  bool? status;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'data')
  LoginDataResponse? loginDataResponse;

  LoginResponse(this.status,this.message,this.loginDataResponse);

  factory LoginResponse.fromJson(Map<String, dynamic> json) => _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}