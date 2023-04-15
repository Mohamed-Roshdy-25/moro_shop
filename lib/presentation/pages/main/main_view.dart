import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moro_shop/presentation/pages/main/pages/cart/cart_view.dart';
import 'package:moro_shop/presentation/pages/main/pages/favorite/favorite_view.dart';
import 'package:moro_shop/presentation/pages/main/pages/home/home_view.dart';
import 'package:moro_shop/presentation/pages/main/pages/settings/settings_view.dart';
import 'package:moro_shop/presentation/resources/color_manager.dart';
import 'package:moro_shop/presentation/resources/values_manager.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final _pageController = PageController(initialPage: 0);
  final tabBarIcons = [
    FontAwesomeIcons.house,
    FontAwesomeIcons.heartPulse,
    FontAwesomeIcons.cartShopping,
    FontAwesomeIcons.userGear,
  ];
  int currentIndex = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: _body(),
    );
  }

  Widget _body(){
    return SafeArea(
      child: Stack(
        children: [
          _screensView(),
          _bottomBar(),
        ],
      ),
    );
  }

  Widget _screensView(){
    return PageView(
      physics: const BouncingScrollPhysics(),
      controller: _pageController,
      onPageChanged: (index) {
        setState(() {
          currentIndex = index;
        });
      },
      children: const [
        HomeView(),
        FavoriteView(),
        CartView(),
        SettingsView(),
      ],
    );
  }


  Widget _bottomBar(){
    return Positioned(
      bottom: 20.h,
      left: 20.w,
      right: 20.w,
      child: Container(
        alignment: Alignment.center,
        height: AppSize.s60.h,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).colorScheme.secondary,
            ],
          ),
          borderRadius: BorderRadius.circular(40.sp),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ...tabBarIcons.map(
                  (icon) => IconButton(
                onPressed: () {
                  icon == FontAwesomeIcons.house
                      ? _pageController.jumpToPage(0)
                      : icon == FontAwesomeIcons.heartPulse
                      ? _pageController.jumpToPage(1)
                      : icon == FontAwesomeIcons.cartShopping
                      ? _pageController.jumpToPage(2)
                      : _pageController.jumpToPage(3);
                },
                icon: Icon(
                  icon,
                  size: 22.sp,
                ),
                color: ColorManager.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
