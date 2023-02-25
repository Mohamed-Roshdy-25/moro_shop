import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:moro_shop/app/app_prefs.dart';
import 'package:moro_shop/app/constants.dart';
import 'package:moro_shop/app/di.dart';
import 'package:moro_shop/presentation/resources/assets_manager.dart';
import 'package:moro_shop/presentation/resources/routes_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  Timer? _timer;
  final AppPreferences _appPreferences = instance<AppPreferences>();

  _startDelay() {
    _timer = Timer(const Duration(seconds: Constants.splashDelay), _goNext);
  }

  _goNext() {
    // navigate to main screen
    _appPreferences.isUserLoggedIn().then((isUserLoggedIn) {
      if (isUserLoggedIn) {
        Navigator.of(context).pushNamedAndRemoveUntil(Routes.homeRoute, ModalRoute.withName(Routes.splashRoute));
      } else {
        // navigate to login screen
        Navigator.of(context).pushNamedAndRemoveUntil(Routes.loginRoute, ModalRoute.withName(Routes.splashRoute));
      }
    });
  }

  @override
  void initState() {
    _startDelay();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: const [0.0, 1.0],
              colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).colorScheme.secondary,
              ],
            ),
          ),
        ),
        Center(
          child: Lottie.asset(JsonAssets.splashIcon),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
