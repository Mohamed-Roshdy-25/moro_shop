import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moro_shop/app/di.dart';
import 'package:moro_shop/presentation/bloc/categories/categories_bloc.dart';
import 'package:moro_shop/presentation/bloc/category_products/category_products_bloc.dart';
import 'package:moro_shop/presentation/bloc/forgot_password/forgot_password_bloc.dart';
import 'package:moro_shop/presentation/bloc/login/login_bloc.dart';
import 'package:moro_shop/presentation/bloc/register/register_bloc.dart';
import 'package:moro_shop/presentation/bloc/reset_password/reset_password_bloc.dart';
import 'package:moro_shop/presentation/bloc/verify_code/verify_code_bloc.dart';
import 'package:moro_shop/presentation/resources/routes_manager.dart';
import 'package:moro_shop/presentation/resources/theme_manager.dart';

class MyApp extends StatefulWidget {
  const MyApp._internal();

  static const _instance = MyApp._internal();

  factory MyApp() => _instance;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => instance<LoginBloc>(),),
        BlocProvider(create: (_) => instance<RegisterBloc>(),),
        BlocProvider(create: (_) => instance<ForgotPasswordBloc>(),),
        BlocProvider(create: (_) => instance<VerifyCodeBloc>(),),
        BlocProvider(create: (_) => instance<ResetPasswordBloc>(),),
        BlocProvider(create: (_) => instance<CategoryBloc>()..add(GetCategoriesEvent()),),
        BlocProvider(create: (_) => instance<CategoryProductsBloc>(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteGenerator.getRoute,
        initialRoute: Routes.splashRoute,
        theme: ThemeManager.getTheme(),
      ),
    );
  }
}
