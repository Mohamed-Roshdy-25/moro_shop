import 'package:flutter/material.dart';
import 'package:moro_shop/app/app.dart';
import 'package:moro_shop/app/di.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();
  runApp(MyApp());
}