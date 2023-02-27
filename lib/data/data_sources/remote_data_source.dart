import 'package:moro_shop/data/network/app_api.dart';
import 'package:moro_shop/data/network/requests.dart';
import 'package:moro_shop/data/responses/responses.dart';

abstract class RemoteDataSource {
  Future<LoginOrRegisterResponse> login(LoginRequest loginRequest);
  Future<LoginOrRegisterResponse> register(RegisterRequest registerRequest);
  Future<ForgotPasswordResponse> forgotPassword(ForgotPasswordRequest forgotPasswordRequest);
  Future<VerifyCodeResponse> verifyCode(VerifyCodeRequest verifyCodeRequest);
  Future<ResetPasswordResponse> resetPassword(ResetPasswordRequest resetPasswordRequest);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final AppServiceClient appServiceClient;

  RemoteDataSourceImpl(this.appServiceClient);

  @override
  Future<LoginOrRegisterResponse> login(LoginRequest loginRequest) async {
    return await appServiceClient.login(
        loginRequest.email, loginRequest.password);
  }

  @override
  Future<LoginOrRegisterResponse> register(
      RegisterRequest registerRequest) async {
    return await appServiceClient.register(
      registerRequest.email,
      registerRequest.password,
      registerRequest.name,
      registerRequest.phone,
      registerRequest.image,
    );
  }

  @override
  Future<ForgotPasswordResponse> forgotPassword(ForgotPasswordRequest forgotPasswordRequest) async {
    return await appServiceClient.forgotPassword(forgotPasswordRequest.email);
  }

  @override
  Future<VerifyCodeResponse> verifyCode(VerifyCodeRequest verifyCodeRequest) async {
    return await appServiceClient.verifyCode(verifyCodeRequest.email, verifyCodeRequest.code);
  }

  @override
  Future<ResetPasswordResponse> resetPassword(ResetPasswordRequest resetPasswordRequest) async {
    return await appServiceClient.resetPassword(resetPasswordRequest.email, resetPasswordRequest.code, resetPasswordRequest.password);
  }
}
