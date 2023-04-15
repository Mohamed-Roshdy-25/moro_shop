import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moro_shop/presentation/resources/color_manager.dart';
import 'package:moro_shop/presentation/resources/font_manager.dart';
import 'package:moro_shop/presentation/resources/styles_manager.dart';
import 'package:moro_shop/presentation/resources/values_manager.dart';

class ThemeManager {
  static ThemeData getTheme() {
    return ThemeData(
      primaryColor: ColorManager.primary,
      scaffoldBackgroundColor: ColorManager.white,
      appBarTheme: AppBarTheme(
        color: ColorManager.white,
        elevation: 0,
      ),
      brightness: Brightness.light,
      textTheme: TextTheme(
        displayLarge:
            getBoldStyle(color: ColorManager.white, fontSize: FontSize.s60),
        headlineLarge: getSemiBoldStyle(
            color: ColorManager.primary, fontSize: FontSize.s40),
        headlineMedium: getMediumStyle(
            color: ColorManager.lightBlack, fontSize: FontSize.s30),
        headlineSmall: getRegularStyle(
            color: ColorManager.lightBlack, fontSize: FontSize.s18),
        titleLarge:
            getSemiBoldStyle(color: ColorManager.white, fontSize: FontSize.s20),
        titleMedium:
            getMediumStyle(color: ColorManager.blue, fontSize: FontSize.s14),
        titleSmall:
            getRegularStyle(color: ColorManager.grey, fontSize: FontSize.s14),
        bodyLarge:
            getSemiBoldStyle(color: ColorManager.grey, fontSize: FontSize.s18),
        bodyMedium:
            getMediumStyle(color: ColorManager.blue, fontSize: FontSize.s16),
        bodySmall:
            getRegularStyle(color: ColorManager.white, fontSize: FontSize.s14),
        labelLarge: getSemiBoldStyle(
            color: ColorManager.primary, fontSize: FontSize.s14),
        labelMedium:
            getMediumStyle(color: ColorManager.grey, fontSize: FontSize.s12),
        labelSmall: getRegularStyle(
            color: ColorManager.primary, fontSize: FontSize.s10),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle:
            getRegularStyle(color: ColorManager.grey, fontSize: FontSize.s12),
        labelStyle:
            getMediumStyle(color: ColorManager.grey, fontSize: FontSize.s14),
        fillColor: ColorManager.white,
        filled: true,
        contentPadding: EdgeInsets.fromLTRB(
          AppPadding.p20.h,
          AppPadding.p10.w,
          AppPadding.p20.h,
          AppPadding.p10.w,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.s100.sp),
          borderSide: BorderSide(color: ColorManager.blue),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.s100.sp),
          borderSide: BorderSide(color: ColorManager.grey),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.s100.sp),
          borderSide: BorderSide(color: ColorManager.red, width: AppSize.s2.w),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.s100.sp),
          borderSide: BorderSide(color: ColorManager.red, width: AppSize.s2.w),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSize.s30.sp),
            ),
          ),
          minimumSize: MaterialStateProperty.all(
            Size(AppSize.s50.w, AppSize.s50.h),
          ),
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          shadowColor: MaterialStateProperty.all(Colors.transparent),
        ),
      ),
    );
  }
}
