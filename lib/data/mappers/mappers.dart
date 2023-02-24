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
