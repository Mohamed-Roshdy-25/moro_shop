import 'package:flutter/material.dart';
import 'package:moro_shop/presentation/resources/color_manager.dart';
import 'package:moro_shop/presentation/resources/values_manager.dart';

class ThemeManager {
  static ThemeData getTheme() {
    return ThemeData(
      primaryColor: ColorManager.primary,
      appBarTheme: AppBarTheme(
        color: ColorManager.white,
        elevation: 0,
      ),
      brightness: Brightness.light,
      textTheme: TextTheme(
        displayLarge: TextStyle(
            color: ColorManager.primary,
            fontSize: AppSize.s18,
            fontWeight: FontWeight.bold),
        bodyLarge: TextStyle(
            color: ColorManager.grey,
            fontSize: AppSize.s12,
            fontWeight: FontWeight.normal),
      ),
    );
  }
}
