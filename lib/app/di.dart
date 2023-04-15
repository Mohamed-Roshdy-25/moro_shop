import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:moro_shop/app/app_prefs.dart';
import 'package:moro_shop/data/data_sources/remote_data_source.dart';
import 'package:moro_shop/data/network/app_api.dart';
import 'package:moro_shop/data/network/dio_factory.dart';
import 'package:moro_shop/data/network/network_info.dart';
import 'package:moro_shop/data/repository_impl/repository_impl.dart';
import 'package:moro_shop/domain/repository/repository.dart';
import 'package:moro_shop/domain/use_case/add_delete_carts_use_case.dart';
import 'package:moro_shop/domain/use_case/add_delete_favorites_use_case.dart';
import 'package:moro_shop/domain/use_case/carts_use_case.dart';
import 'package:moro_shop/domain/use_case/category_products_use_case.dart';
import 'package:moro_shop/domain/use_case/delete_cart_item_use_case.dart';
import 'package:moro_shop/domain/use_case/delete_favorite_use_case.dart';
import 'package:moro_shop/domain/use_case/favorites_use_case.dart';
import 'package:moro_shop/domain/use_case/forgot_password_use_case.dart';
import 'package:moro_shop/domain/use_case/categories_use_case.dart';
import 'package:moro_shop/domain/use_case/login_use_case.dart';
import 'package:moro_shop/domain/use_case/logout_use_case.dart';
import 'package:moro_shop/domain/use_case/profile_use_case.dart';
import 'package:moro_shop/domain/use_case/register_use_case.dart';
import 'package:moro_shop/domain/use_case/reset_password_use_case.dart';
import 'package:moro_shop/domain/use_case/update_product_quantity_in_cart_use_case.dart';
import 'package:moro_shop/domain/use_case/verify_code_use_case.dart';
import 'package:moro_shop/presentation/bloc/add_delete_cart/add_or_delete_cart_bloc.dart';
import 'package:moro_shop/presentation/bloc/add_delete_favorite/add_or_delete_favorite_bloc.dart';
import 'package:moro_shop/presentation/bloc/cart/cart_bloc.dart';
import 'package:moro_shop/presentation/bloc/categories/categories_bloc.dart';
import 'package:moro_shop/presentation/bloc/category_products/category_products_bloc.dart';
import 'package:moro_shop/presentation/bloc/delete_cart_item/delete_cart_item_bloc.dart';
import 'package:moro_shop/presentation/bloc/delete_favorite/delete_favorite_bloc.dart';
import 'package:moro_shop/presentation/bloc/favorites/favorites_bloc.dart';
import 'package:moro_shop/presentation/bloc/forgot_password/forgot_password_bloc.dart';
import 'package:moro_shop/presentation/bloc/login/login_bloc.dart';
import 'package:moro_shop/presentation/bloc/logout/logout_bloc.dart';
import 'package:moro_shop/presentation/bloc/profile/profile_bloc.dart';
import 'package:moro_shop/presentation/bloc/register/register_bloc.dart';
import 'package:moro_shop/presentation/bloc/reset_password/reset_password_bloc.dart';
import 'package:moro_shop/presentation/bloc/update_product_quantity_in_cart/update_product_quantity_in_cart_bloc.dart';
import 'package:moro_shop/presentation/bloc/verify_code/verify_code_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  // app module, its a module where we put all generic dependencies

  instance.allowReassignment = true;

  // shared prefs instance

  final sharedPrefs = await SharedPreferences.getInstance();
  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  // app prefs instance

  instance
      .registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));

  // network info

  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnectionChecker()));

  // Dio Factory
  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));

  // app service client
  Dio dio = await DioFactory(instance<AppPreferences>()).getDio();

  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

  // remote data source
  instance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(instance<AppServiceClient>()));

  // repository
  instance.registerLazySingleton<Repository>(
      () => RepositoryImpl(instance(), instance()));
}

initLoginModule() {
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
    instance.registerFactory<LoginBloc>(
        () => LoginBloc(loginUseCase: instance(), appPreferences: instance()));

}

initForgotPasswordModule() {
    instance.registerFactory<ForgotPasswordUseCase>(
        () => ForgotPasswordUseCase(instance()));
    instance.registerFactory<ForgotPasswordBloc>(
        () => ForgotPasswordBloc(forgotPasswordUseCase: instance()));

}

initVerifyCodeModule() {
    instance.registerFactory<VerifyCodeUseCase>(
        () => VerifyCodeUseCase(instance()));
    instance.registerFactory<VerifyCodeBloc>(
        () => VerifyCodeBloc(verifyCodeUseCase: instance()));

}

initResetPasswordModule() {
    instance.registerFactory<ResetPasswordUseCase>(
        () => ResetPasswordUseCase(instance()));
    instance.registerFactory<ResetPasswordBloc>(() => ResetPasswordBloc(
        resetPasswordUseCase: instance(), appPreferences: instance()));

}

initRegisterModule() {
    instance
        .registerFactory<RegisterUseCase>(() => RegisterUseCase(instance()));
    instance.registerFactory<RegisterBloc>(() =>
        RegisterBloc(registerUseCase: instance(), appPreferences: instance()));
    instance.registerFactory<ImagePicker>(() => ImagePicker());

}

initHomeModule() {
    instance.registerFactory<CategoriesUseCase>(
        () => CategoriesUseCase(instance()));
    instance.registerFactory<CategoryBloc>(() => CategoryBloc(instance()));
    instance.registerFactory<CategoryProductsUseCase>(
        () => CategoryProductsUseCase(instance()));
    instance.registerFactory<CategoryProductsBloc>(
        () => CategoryProductsBloc(instance()));

    instance.registerFactory<AddOrDeleteFavoritesUseCase>(
        () => AddOrDeleteFavoritesUseCase(instance()));
    instance.registerFactory<AddOrDeleteFavoriteBloc>(
        () => AddOrDeleteFavoriteBloc(instance()));

    instance.registerFactory<AddOrDeleteCartsUseCase>(
        () => AddOrDeleteCartsUseCase(instance()));
    instance.registerFactory<AddOrDeleteCartBloc>(
        () => AddOrDeleteCartBloc(instance()));
    instance
        .registerFactory<FavoritesUseCase>(() => FavoritesUseCase(instance()));
    instance.registerFactory<FavoritesBloc>(() => FavoritesBloc(instance()));
    instance.registerFactory<CartsUseCase>(() => CartsUseCase(instance()));
    instance.registerFactory<CartBloc>(() => CartBloc(instance()));

    instance.registerFactory<DeleteFavoriteUseCase>(
            () => DeleteFavoriteUseCase(instance()));
    instance.registerFactory<DeleteFavoriteBloc>(
            () => DeleteFavoriteBloc(instance()));

    instance.registerFactory<DeleteCartItemUseCase>(
            () => DeleteCartItemUseCase(instance()));
    instance.registerFactory<DeleteCartItemBloc>(
            () => DeleteCartItemBloc(instance()));

    instance.registerFactory<UpdateProductQuantityInCartUseCase>(
        () => UpdateProductQuantityInCartUseCase(instance()));
    instance.registerFactory<UpdateProductQuantityInCartBloc>(
        () => UpdateProductQuantityInCartBloc(instance()));
    instance.registerFactory<LogoutUseCase>(() => LogoutUseCase(instance()));
    instance.registerFactory<LogoutBloc>(() => LogoutBloc(instance()));

}

initProfileModule() {
    instance.registerFactory<ProfileUseCase>(() => ProfileUseCase(instance()));
    instance.registerFactory<ProfileBloc>(() => ProfileBloc(instance()));

}
