import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moro_shop/app/app_prefs.dart';
import 'package:moro_shop/app/di.dart';
import 'package:moro_shop/presentation/bloc/login/login_bloc.dart';
import 'package:moro_shop/presentation/common/freezed_data_classes.dart';
import 'package:moro_shop/presentation/common/state_renderer/state_renderer.dart';
import 'package:moro_shop/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:moro_shop/presentation/common/widgets/auth_header_widget.dart';
import 'package:moro_shop/presentation/resources/font_manager.dart';
import 'package:moro_shop/presentation/resources/routes_manager.dart';
import 'package:moro_shop/presentation/resources/strings_manager.dart';
import 'package:moro_shop/presentation/resources/values_manager.dart';

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
    _isLoggedIn();
    super.initState();
  }

  _isLoggedIn() {
    LoginBloc.isUserLoggedInSuccessfullyStreamController.stream
        .listen((isLoggedIn) {
      if (isLoggedIn) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          _appPreferences?.setUserLoggedIn();
          Navigator.of(context).pushReplacementNamed(Routes.homeRoute);
        });
      }
    });
  }

  @override
  void dispose() {
    LoginBloc.isUserLoggedInSuccessfullyStreamController.close();
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (_) => instance<LoginBloc>(),
      child: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginLoadingState) {
            LoadingState(stateRendererType: StateRendererType.popupLoadingState,message: AppStrings.loading).getScreenWidget(context);
          }
          if (state is LoginErrorState) {
            ErrorState(StateRendererType.popupErrorState, state.message).getScreenWidget(context);
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: _buildBody(context),
          );
        },
      ),
    );
  }

  _buildBody(context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const AuthHeaderWidget(250, true, Icons.login_rounded),
          _loginForm(context),
        ],
      ),
    );
  }

  _loginForm(context) {
    return SafeArea(
      child: Container(
          padding: const EdgeInsets.fromLTRB(AppPadding.p20, AppPadding.p10, AppPadding.p20, AppPadding.p10),
          margin: const EdgeInsets.fromLTRB(AppMargin.m20, AppMargin.m10, AppMargin.m20, AppMargin.m10),
          child: Column(
            children: [
              const Text(
                'Hello',
                style: TextStyle(fontSize: FontSize.s60, fontWeight: FontWeight.bold),
              ),
              const Text(
                'Sign in into your account',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: AppSize.s30),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 5),
                          )
                        ]),
                        child: TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            label: Text(AppStrings.email),
                            hintText: AppStrings.emailHintText,
                          ),
                          validator: (value) {
                            if (value?.isEmpty ?? false) {
                              return AppStrings.emailErrorText;
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: AppSize.s30),
                      Container(
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: AppSize.s20,
                            offset: const Offset(0, 5),
                          )
                        ]),
                        child: TextFormField(
                          controller: _passController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            label: Text(AppStrings.password),
                            hintText: AppStrings.passwordHintText,
                          ),
                          validator: (value) {
                            if (value?.isEmpty ?? false) {
                              return AppStrings.passwordErrorText;
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 15.0),
                      Container(
                        margin: const EdgeInsets.fromLTRB(AppMargin.m10, AppMargin.m0, AppMargin.m10, AppMargin.m20),
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                          onTap: () {},
                          child: const Text(
                            AppStrings.forgetPassword,
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      Container(
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
                            stops: const [0.0, 1.0],
                            colors: [
                              Theme.of(context).primaryColor,
                              Theme.of(context).colorScheme.secondary,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: ElevatedButton(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(AppPadding.p40, AppPadding.p10, AppPadding.p40, AppPadding.p10),
                            child: Text(
                              'Sign In'.toUpperCase(),
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              BlocProvider.of<LoginBloc>(context).add(
                                  PostLoginEvent(_emailController.text,
                                      _passController.text));
                            }
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(AppMargin.m10, AppMargin.m20, AppMargin.m10, AppMargin.m20),
                        //child: Text('Don\'t have an account? Create'),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, Routes.registerRoute);
                          },
                          child: Text.rich(TextSpan(children: [
                            const TextSpan(text: AppStrings.dontHaveAccount),
                            TextSpan(
                              text: AppStrings.create,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.secondary),
                            ),
                          ]),
                        )),
                      ),
                    ],
                  )),
            ],
          )),
    );
  }
}
