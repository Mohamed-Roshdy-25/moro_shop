import 'package:flutter/material.dart';
import 'package:moro_shop/app/di.dart';
import 'package:moro_shop/presentation/pages/forgot_password/forgot_password_view.dart';
import 'package:moro_shop/presentation/pages/intro/intro_view.dart';
import 'package:moro_shop/presentation/pages/login/login_view.dart';
import 'package:moro_shop/presentation/pages/main/main_view.dart';
import 'package:moro_shop/presentation/pages/profile/profile_view.dart';
import 'package:moro_shop/presentation/pages/register/register_view.dart';
import 'package:moro_shop/presentation/pages/reset_password/reset_password_view.dart';
import 'package:moro_shop/presentation/pages/search/search_view.dart';
import 'package:moro_shop/presentation/pages/splash/splash_view.dart';
import 'package:moro_shop/presentation/pages/verify_code/verify_code_view.dart';
import 'package:moro_shop/presentation/resources/strings_manager.dart';


class Routes {
  static const String splashRoute = '/';
  static const String introRoute = '/intro';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String forgotPasswordRoute = '/forgotPassword';
  static const String verifyCodeRoute = '/verifyCode';
  static const String resetPasswordRoute = '/resetPassword';
  static const String mainRoute = '/main';
  static const String homeRoute = '/home';
  static const String categoriesRoute = '/categories';
  static const String cartRoute = '/cart';
  static const String favoriteRoute = '/favorite';
  static const String searchRoute = '/search';
  static const String settingsRoute = '/settings';
  static const String profileRoute = '/profile';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {

    switch(settings.name){
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView(),);

      case Routes.introRoute:
        return MaterialPageRoute(builder: (_) =>  const IntroView(),);

      case Routes.loginRoute:
          initLoginModule();
        return MaterialPageRoute(builder: (_) => const LoginView(),);

      case Routes.registerRoute:
        initRegisterModule();
        return MaterialPageRoute(builder: (_) => const RegisterView(),);

      case Routes.forgotPasswordRoute:
        initForgotPasswordModule();
        return MaterialPageRoute(builder: (_) => const ForgotPasswordView(),);

      case Routes.verifyCodeRoute:
        initVerifyCodeModule();
        String email = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => VerifyCodeView(email: email),);

      case Routes.resetPasswordRoute:
        initResetPasswordModule();
        Map args = settings.arguments as Map;
        String email = args['email'];
        String code = args['pin'];
        return MaterialPageRoute(builder: (_) =>  ResetPasswordView(email: email,code: code),);

      case Routes.mainRoute:
        initAppModule().then((value) {
          initHomeModule();
        });
        return MaterialPageRoute(builder: (_) => const MainView(),);

      case Routes.profileRoute:
        initProfileModule();
        return MaterialPageRoute(builder: (_) => const ProfileView(),);

      case Routes.searchRoute:
        return MaterialPageRoute(builder: (_) => const SearchView(),);

      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(
            title: const Text(AppStrings.noRouteFound),
          ),
          body: const Center(child: Text(AppStrings.noRouteFound),),
        ));
  }
}