
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moro_shop/app/app.dart';
import 'package:moro_shop/app/cache_helper.dart';
import 'package:moro_shop/app/di.dart';
import 'package:moro_shop/data/network/dio_helper.dart';
import 'package:moro_shop/presentation/bloc/bloc_observer.dart';

Future<void> main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark
  ));
  DioHelper.init();
  await CacheHelper.init();
  await initAppModule();
  await ScreenUtil.ensureScreenSize();
  runApp(MyApp());
}