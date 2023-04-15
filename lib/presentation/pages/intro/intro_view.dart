import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moro_shop/app/app_prefs.dart';
import 'package:moro_shop/app/di.dart';
import 'package:moro_shop/presentation/pages/widgets/intro_image_list_widget.dart';
import 'package:moro_shop/presentation/resources/routes_manager.dart';
import 'package:moro_shop/presentation/resources/strings_manager.dart';
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
    super.initState();
    _appPreferences.setIntroScreenViewed();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container(
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
          _imagesTransition(),
          _bottomWidget(),
        ],
      ),
    );
  }

  Widget _imagesTransition() {
    return Positioned(
      top: -30,
      left: -150,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          ImageListView(startIndex: 0),
          ImageListView(startIndex: 1),
          ImageListView(startIndex: 2),
        ],
      ),
    );
  }

  Widget _bottomWidget() {
    Size size = MediaQuery.of(context).size;

    return Positioned(
      bottom: 0,
      child: Container(
        height: AppSize.s370.h,
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
            _captionText(),
            _startButton(size),
          ],
        ),
      ),
    );
  }

  Widget _captionText() {
    return Padding(
      padding: EdgeInsets.only(top: AppPadding.p40.h, bottom: AppPadding.p90.h),
      child: Text(
        AppStrings.introCaption,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }

  Widget _startButton(Size size) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 4),
              blurRadius: AppSize.s5)
        ],
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).colorScheme.secondary,
          ],
        ),
        borderRadius: BorderRadius.circular(AppSize.s30),
      ),
      child: ElevatedButton(
        onPressed: _onTapButton,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppStrings.introButtonTitle.toUpperCase(),
              style: Theme.of(context).textTheme.bodySmall,
            ),
            SizedBox(
              width: size.width * .05,
            ),
            const Icon(Icons.arrow_circle_right_sharp),
          ],
        ),
      ),
    );
  }

  void _onTapButton() {
    Navigator.pushNamedAndRemoveUntil(context, Routes.loginRoute,
        ModalRoute.withName(Routes.splashRoute));
  }
}
