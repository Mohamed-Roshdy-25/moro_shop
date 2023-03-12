import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:moro_shop/app/app.dart';
import 'package:moro_shop/app/di.dart';
import 'package:moro_shop/presentation/bloc/bloc_observer.dart';

Future<void> main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();
  runApp(MyApp());
}