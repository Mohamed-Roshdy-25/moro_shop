
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
import 'package:moro_shop/domain/use_case/forgot_password_use_case.dart';
import 'package:moro_shop/domain/use_case/login_use_case.dart';
import 'package:moro_shop/domain/use_case/register_use_case.dart';
import 'package:moro_shop/domain/use_case/reset_password_use_case.dart';
import 'package:moro_shop/domain/use_case/verify_code_use_case.dart';
import 'package:moro_shop/presentation/bloc/forgot_password/forgot_password_bloc.dart';
import 'package:moro_shop/presentation/bloc/login/login_bloc.dart';
import 'package:moro_shop/presentation/bloc/register/register_bloc.dart';
import 'package:moro_shop/presentation/bloc/reset_password/reset_password_bloc.dart';
import 'package:moro_shop/presentation/bloc/verify_code/verify_code_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  // app module, its a module where we put all generic dependencies

  // shared prefs instance
  final sharedPrefs = await SharedPreferences.getInstance();
  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  // app prefs instance
  instance
      .registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));

  // network info
  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnectionChecker()));

  // dio factory
  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));

  Dio dio = await instance<DioFactory>().getDio();
  //app service client
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

  // remote data source
  instance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(instance<AppServiceClient>()));

  // local data source
  // instance.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl());

  // repository

  instance.registerLazySingleton<Repository>(
      () => RepositoryImpl(instance(), instance()));
}

initLoginModule() {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
    instance.registerFactory<LoginBloc>(() => LoginBloc(loginUseCase: instance(), appPreferences: instance()));
  }
}

initForgotPasswordModule() {
  if (!GetIt.I.isRegistered<ForgotPasswordUseCase>()) {
    instance.registerFactory<ForgotPasswordUseCase>(
        () => ForgotPasswordUseCase(instance()));
    instance.registerFactory<ForgotPasswordBloc>(
        () => ForgotPasswordBloc(forgotPasswordUseCase: instance()));
  }
}

initVerifyCodeModule() {
  if (!GetIt.I.isRegistered<VerifyCodeUseCase>()) {
    instance.registerFactory<VerifyCodeUseCase>(
            () => VerifyCodeUseCase(instance()));
    instance.registerFactory<VerifyCodeBloc>(
            () => VerifyCodeBloc(verifyCodeUseCase: instance()));
  }
}

initResetPasswordModule() {
  if (!GetIt.I.isRegistered<ResetPasswordUseCase>()) {
    instance.registerFactory<ResetPasswordUseCase>(
            () => ResetPasswordUseCase(instance()));
    instance.registerFactory<ResetPasswordBloc>(
            () => ResetPasswordBloc(resetPasswordUseCase: instance(),appPreferences: instance()));
  }
}

initRegisterModule() {
  if (!GetIt.I.isRegistered<RegisterUseCase>()) {
    instance
        .registerFactory<RegisterUseCase>(() => RegisterUseCase(instance()));
    instance.registerFactory<RegisterBloc>(() => RegisterBloc(registerUseCase: instance(), appPreferences: instance()));
    instance.registerFactory<ImagePicker>(() => ImagePicker());
  }
}
//
// initHomeModule() {
//   if (!GetIt.I.isRegistered<HomeUseCase>()) {
//     instance.registerFactory<HomeUseCase>(() => HomeUseCase(instance()));
//     instance.registerFactory<HomeViewModel>(() => HomeViewModel(instance()));
//   }
// }
//
// initStoreDetailsModule() {
//   if (!GetIt.I.isRegistered<StoreDetailsUseCase>()) {
//     instance.registerFactory<StoreDetailsUseCase>(
//             () => StoreDetailsUseCase(instance()));
//     instance.registerFactory<StoreDetailsViewModel>(
//             () => StoreDetailsViewModel(instance()));
//   }
// }
