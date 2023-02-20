import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:moro_shop/app/app_prefs.dart';
import 'package:moro_shop/presentation/bloc/login/login_bloc.dart';
import 'package:moro_shop/presentation/resources/routes_manager.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

   AppPreferences? _appPreferences;


  @override
  void initState() {
    LoginBloc.isUserLoggedInSuccessfullyStreamController.stream.listen((isLoggedIn) {
      if (isLoggedIn) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          _appPreferences?.setUserLoggedIn();
          Navigator.of(context).pushReplacementNamed(Routes.homeRoute);
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
