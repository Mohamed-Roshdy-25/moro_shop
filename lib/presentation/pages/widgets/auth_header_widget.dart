import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moro_shop/presentation/resources/color_manager.dart';
import 'package:moro_shop/presentation/resources/values_manager.dart';

class AuthHeaderWidget extends StatelessWidget {
  final double height;
  final bool showIcon;
  final IconData? icon;

  const AuthHeaderWidget(
      {required this.height, required this.showIcon, this.icon, super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return SizedBox(
      height: height,
      child: Stack(
        children: [
          _firstContainer(width,height,context),
          _secondContainer(width,height,context),ClipPath(
            clipper: ShapeClipper([
              Offset(width / 5, height),
              Offset(width / 2, height - 40),
              Offset(width / 5 * 4, height - 80),
              Offset(width, height - 20)
            ]),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).colorScheme.secondary,
                    ],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(1.0, 0.0),
                    tileMode: TileMode.clamp),
              ),
            ),
          ),
          _thirdContainer(width,height,context),
          _headerIcon(height,showIcon,icon),
        ],
      ),
    );
  }
}

Widget _firstContainer(double width,double height,BuildContext context){
  return ClipPath(
    clipper: ShapeClipper([
      Offset(width / 5, height),
      Offset(width / 10 * 5, height - 60),
      Offset(width / 5 * 4, height + 20),
      Offset(width, height - 18)
    ]),
    child: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).primaryColor.withOpacity(0.4),
            Theme.of(context).colorScheme.secondary.withOpacity(0.4),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
    ),
  );
}

Widget _secondContainer(double width,double height,BuildContext context){
  return ClipPath(
    clipper: ShapeClipper([
      Offset(width / 3, height + 20),
      Offset(width / 10 * 8, height - 60),
      Offset(width / 5 * 4, height - 60),
      Offset(width, height - 20)
    ]),
    child: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [
              Theme.of(context).primaryColor.withOpacity(0.4),
              Theme.of(context).colorScheme.secondary.withOpacity(0.4),
            ],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 0.0),
            stops: const [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
    ),
  );
}

Widget _thirdContainer(double width,double height,BuildContext context){
  return ClipPath(
    clipper: ShapeClipper([
      Offset(width / 5, height),
      Offset(width / 2, height - 40),
      Offset(width / 5 * 4, height - 80),
      Offset(width, height - 20)
    ]),
    child: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).colorScheme.secondary,
            ],
        ),
      ),
    ),
  );
}

Widget _headerIcon(double height, bool showIcon, IconData? icon) {
  return Visibility(
    visible: showIcon,
    child: SizedBox(
      height: height - 40.h,
      child: Center(
        child: Container(
          padding: EdgeInsets.only(
            left: AppPadding.p5.w,
            top: AppPadding.p20.h,
            right: AppPadding.p5.w,
            bottom: AppPadding.p20.h,
          ),
          decoration: BoxDecoration(
            // borderRadius: BorderRadius.circular(20),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppSize.s100.sp),
              topRight: Radius.circular(AppSize.s100.sp),
              bottomLeft: Radius.circular(AppSize.s60.sp),
              bottomRight: Radius.circular(AppSize.s60.sp),
            ),
            border: Border.all(width: AppSize.s5.w, color: ColorManager.white),
          ),
          child: Icon(
            icon,
            color: ColorManager.white,
            size: AppSize.s40.sp,
          ),
        ),
      ),
    ),
  );
}

class ShapeClipper extends CustomClipper<Path> {
  final List<Offset> _offsets;
  ShapeClipper(this._offsets);
  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(0, size.height - 20.h);

    // path.quadraticBezierTo(size.width/5, size.height, size.width/2, size.height-40);
    // path.quadraticBezierTo(size.width/5*4, size.height-80, size.width, size.height-20);

    path.quadraticBezierTo(
        _offsets[0].dx, _offsets[0].dy, _offsets[1].dx, _offsets[1].dy);
    path.quadraticBezierTo(
        _offsets[2].dx, _offsets[2].dy, _offsets[3].dx, _offsets[3].dy);

    // path.lineTo(size.width, size.height-20);
    path.lineTo(size.width,0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
