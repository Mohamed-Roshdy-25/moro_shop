import 'package:moro_shop/app/extensions.dart';
import 'package:moro_shop/data/responses/responses.dart';
import 'package:moro_shop/domain/models/models.dart';

extension LoginDataResponseMapper on LoginDataResponse {
  LoginDataModel toDomain() {
    return LoginDataModel(id.orZero(), name.orEmpty(), email.orEmpty(),
        phone.orEmpty(), imageUrl.orEmpty(), token.orEmpty());
  }
}

extension LoginResponseMapper on LoginResponse {
  LoginModel toDomain() {
    return LoginModel(
      status.orFalse(),
      message.orEmpty(),
      loginDataResponse?.toDomain(),
    );
  }
}
