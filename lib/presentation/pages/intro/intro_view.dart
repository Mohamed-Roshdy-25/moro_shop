import 'package:flutter/material.dart';
import 'package:moro_shop/app/app_prefs.dart';
import 'package:moro_shop/app/di.dart';
import 'package:moro_shop/presentation/pages/widgets/intro_image_list_widget.dart';
import 'package:moro_shop/presentation/resources/routes_manager.dart';
import 'package:moro_shop/presentation/resources/style_manager.dart';
import 'package:moro_shop/presentation/resources/values_manager.dart';

class IntroView extends StatefulWidget {
  const IntroView({Key? key}) : super(key: key);

  @override
  State<IntroView> createState() => _IntroViewState();
}

class _IntroViewState extends State<IntroView> {
  final AppPreferences _appPreferences = instance<AppPreferences>();

  @override
  void initState() {
    _appPreferences.setOnBoardingScreenViewed();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).colorScheme.secondary.withOpacity(.5),
            ],
            begin: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            //image transition
            Positioned(
              top: -10,
              left: -150,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  ImageListView(startIndex: 0),
                  ImageListView(startIndex: 1),
                  ImageListView(startIndex: 2),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: size.height * 0.55,
                width: size.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.transparent,
                      Colors.transparent,
                      Theme.of(context).colorScheme.secondary,
                      Theme.of(context).primaryColor,

                    ],
                    begin: Alignment.topCenter,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 70,),
                    Text('Yor Appearance \n Shows Your Quality',style: StyleManager.bodyStyle,),
                    const SizedBox(height: 90,),
                    Container(
                      width: 150,
                      decoration: BoxDecoration(
                        boxShadow:  const [
                          BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0, 4),
                              blurRadius: AppSize.s5)
                        ],
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          stops: const [0.0, 1.0],
                          colors: [
                            Theme.of(context).primaryColor,
                            Theme.of(context).colorScheme.secondary,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: ElevatedButton(
                        child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Go'.toUpperCase(),
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              const SizedBox(width: 20,),
                              const Icon(Icons.arrow_circle_right_sharp),
                            ],
                          ),
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(context, Routes.loginRoute, ModalRoute.withName(Routes.splashRoute));
                          },
                      ),
                    ),
                  ],
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }
}
