import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moro_shop/presentation/resources/routes_manager.dart';
import 'package:moro_shop/presentation/resources/theme_manager.dart';

class MyApp extends StatefulWidget {
  const MyApp._internal();

  static const _instance = MyApp._internal();

  factory MyApp() => _instance;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            onGenerateRoute: RouteGenerator.getRoute,
            initialRoute: Routes.splashRoute,
            theme: ThemeManager.getTheme(),
          );
        });
  }
}
