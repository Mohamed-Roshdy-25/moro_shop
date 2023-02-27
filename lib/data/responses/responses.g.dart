// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginOrRegisterDataResponse _$LoginOrRegisterDataResponseFromJson(
        Map<String, dynamic> json) =>
    LoginOrRegisterDataResponse(
      json['id'] as int?,
      json['name'] as String?,
      json['email'] as String?,
      json['phone'] as String?,
      json['image'] as String?,
      json['token'] as String?,
    );

Map<String, dynamic> _$LoginOrRegisterDataResponseToJson(
        LoginOrRegisterDataResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'image': instance.imageUrl,
      'token': instance.token,
    };

LoginOrRegisterResponse _$LoginOrRegisterResponseFromJson(
        Map<String, dynamic> json) =>
    LoginOrRegisterResponse(
      json['status'] as bool?,
      json['message'] as String?,
      json['data'] == null
          ? null
          : LoginOrRegisterDataResponse.fromJson(
              json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginOrRegisterResponseToJson(
        LoginOrRegisterResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.loginOrRegisterDataResponse,
    };

ForgotPasswordResponse _$ForgotPasswordResponseFromJson(
        Map<String, dynamic> json) =>
    ForgotPasswordResponse(
      json['status'] as bool?,
      json['message'] as String?,
    );

Map<String, dynamic> _$ForgotPasswordResponseToJson(
        ForgotPasswordResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
    };

VerifyCodeResponse _$VerifyCodeResponseFromJson(Map<String, dynamic> json) =>
    VerifyCodeResponse(
      json['status'] as bool?,
      json['message'] as String?,
    );

Map<String, dynamic> _$VerifyCodeResponseToJson(VerifyCodeResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
    };

ResetPasswordResponse _$ResetPasswordResponseFromJson(
        Map<String, dynamic> json) =>
    ResetPasswordResponse(
      json['status'] as bool?,
      json['message'] as String?,
    );

Map<String, dynamic> _$ResetPasswordResponseToJson(
        ResetPasswordResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
    };
