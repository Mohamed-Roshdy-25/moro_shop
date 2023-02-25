import 'package:flutter/material.dart';
import 'package:moro_shop/app/di.dart';
import 'package:moro_shop/presentation/pages/cart/cart_view.dart';
import 'package:moro_shop/presentation/pages/categories/categories_view.dart';
import 'package:moro_shop/presentation/pages/favorite/favorite_view.dart';
import 'package:moro_shop/presentation/pages/home/home_view.dart';
import 'package:moro_shop/presentation/pages/intro/intro_view.dart';
import 'package:moro_shop/presentation/pages/login/login_view.dart';
import 'package:moro_shop/presentation/pages/profile/profile_view.dart';
import 'package:moro_shop/presentation/pages/register/register_view.dart';
import 'package:moro_shop/presentation/pages/search/search_view.dart';
import 'package:moro_shop/presentation/pages/settings/settings_view.dart';
import 'package:moro_shop/presentation/pages/splash/splash_view.dart';
import 'package:moro_shop/presentation/resources/strings_manager.dart';


class Routes {
  static const String splashRoute = '/';
  static const String introRoute = '/intro';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
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
      case Routes.loginRoute:
        initLoginModule();
        return MaterialPageRoute(builder: (_) => const LoginView(),);
      case Routes.registerRoute:
        initRegisterModule();
        return MaterialPageRoute(builder: (_) => const RegisterView(),);
      case Routes.introRoute:
        return MaterialPageRoute(builder: (_) => const IntroView(),);
      case Routes.homeRoute:
        return MaterialPageRoute(builder: (_) => const HomeView(),);
      case Routes.categoriesRoute:
        return MaterialPageRoute(builder: (_) => const CategoriesView(),);
      case Routes.cartRoute:
        return MaterialPageRoute(builder: (_) => const CartView(),);
      case Routes.favoriteRoute:
        return MaterialPageRoute(builder: (_) => const FavoriteView(),);
      case Routes.profileRoute:
        return MaterialPageRoute(builder: (_) => const ProfileView(),);
      case Routes.searchRoute:
        return MaterialPageRoute(builder: (_) => const SearchView(),);
      case Routes.settingsRoute:
        return MaterialPageRoute(builder: (_) => const SettingsView(),);
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