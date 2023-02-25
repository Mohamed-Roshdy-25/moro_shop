// ignore_for_file: depend_on_referenced_packages

import 'package:json_annotation/json_annotation.dart';
part 'responses.g.dart';

//Login & Register Responses

@JsonSerializable()
class LoginOrRegisterDataResponse {
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

  LoginOrRegisterDataResponse(
      this.id, this.name, this.email, this.phone, this.imageUrl, this.token);

  factory LoginOrRegisterDataResponse.fromJson(Map<String,dynamic> json) => _$LoginOrRegisterDataResponseFromJson(json);

  Map<String,dynamic> toJson() => _$LoginOrRegisterDataResponseToJson(this);
}

@JsonSerializable()
class LoginOrRegisterResponse{
  @JsonKey(name: 'status')
  bool? status;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'data')
  LoginOrRegisterDataResponse? loginOrRegisterDataResponse;

  LoginOrRegisterResponse(this.status,this.message,this.loginOrRegisterDataResponse);

  factory LoginOrRegisterResponse.fromJson(Map<String, dynamic> json) => _$LoginOrRegisterResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginOrRegisterResponseToJson(this);
}