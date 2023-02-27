import 'package:moro_shop/app/extensions.dart';
import 'package:moro_shop/data/responses/responses.dart';
import 'package:moro_shop/domain/models/models.dart';

extension LoginDataResponseMapper on LoginOrRegisterDataResponse {
  LoginOrRegisterDataModel toDomain() {
    return LoginOrRegisterDataModel(id.orZero(), name.orEmpty(), email.orEmpty(),
        phone.orEmpty(), imageUrl.orEmpty(), token.orEmpty());
  }
}

extension LoginResponseMapper on LoginOrRegisterResponse {
  LoginOrRegisterModel toDomain() {
    return LoginOrRegisterModel(
      status.orFalse(),
      message.orEmpty(),
      loginOrRegisterDataResponse?.toDomain(),
    );
  }
}


extension ForgotPasswordResponseMapper on ForgotPasswordResponse {
  ForgotPasswordModel toDomain() {
    return ForgotPasswordModel(
      status.orFalse(),
      message.orEmpty(),
    );
  }
}

extension VerifyCodeResponseMapper on VerifyCodeResponse {
  VerifyCodeModel toDomain() {
    return VerifyCodeModel(
      status.orFalse(),
      message.orEmpty(),
    );
  }
}

extension ResetPasswordResponseMapper on ResetPasswordResponse {
  ResetPasswordModel toDomain() {
    return ResetPasswordModel(
      status.orFalse(),
      message.orEmpty(),
    );
  }
}