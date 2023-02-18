import 'package:flutter/material.dart';
import 'package:moro_shop/presentation/resources/routes_manager.dart';

class MyApp extends StatefulWidget {

  MyApp._internal();

  static final _instance = MyApp._internal();

  factory MyApp() => _instance;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.introRoute,
    );
  }
}
