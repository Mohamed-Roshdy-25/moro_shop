import 'package:flutter/material.dart';
import 'package:moro_shop/presentation/cart/cart_view.dart';
import 'package:moro_shop/presentation/categories/categories_view.dart';
import 'package:moro_shop/presentation/favorite/favorite_view.dart';
import 'package:moro_shop/presentation/home/home_view.dart';
import 'package:moro_shop/presentation/intro/intro_view.dart';
import 'package:moro_shop/presentation/profile/profile_view.dart';
import 'package:moro_shop/presentation/resources/strings_manager.dart';
import 'package:moro_shop/presentation/search/search_view.dart';
import 'package:moro_shop/presentation/settings/settings_view.dart';

class Routes {
  static const String introRoute = '/';
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