import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moro_shop/app/di.dart';
import 'package:moro_shop/app/extensions.dart';
import 'package:moro_shop/presentation/bloc/login/login_bloc.dart';
import 'package:moro_shop/presentation/common/state_renderer/state_renderer.dart';
import 'package:moro_shop/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:moro_shop/presentation/pages/widgets/auth_header_widget.dart';
import 'package:moro_shop/presentation/resources/color_manager.dart';
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

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => instance<LoginBloc>(),
      child: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          _loginLoadingState(state, context);
          _loginSuccessState(state, context);
          _loginErrorState(state, context);
        },
        builder: (context, state) {
          return Scaffold(
            body: _buildBody(context),
          );
        },
      ),
    );
  }

  void _loginLoadingState(state, context) {
    if (state is LoginLoadingState) {
      LoadingState(
              stateRendererType: StateRendererType.popupLoadingState,
              message: AppStrings.loading)
          .getScreenWidget(context);
    }
  }

  void _loginSuccessState(state, context) {
    if (state is LoginSuccessState) {
      Navigator.of(context).pushNamedAndRemoveUntil(
          Routes.mainRoute, ModalRoute.withName(Routes.splashRoute),
          arguments: state.loginOrRegisterOrResetPasswordModel
              .loginOrRegisterOrResetPasswordDataModel?.imageUrl
              .orEmpty());
    }
  }

  void _loginErrorState(state, context) {
    if (state is LoginErrorState) {
      ErrorState(StateRendererType.popupErrorState, state.message)
          .getScreenWidget(context, retryActionFunction: () {
        Navigator.pop(context);
      }, buttonTitle: AppStrings.ok);
    }
  }

  _buildBody(context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _headerWidget(),
          _loginForm(context),
        ],
      ),
    );
  }

  Widget _headerWidget() {
    return AuthHeaderWidget(
      height: AppSize.s220.h,
      showIcon: true,
      icon: Icons.login_rounded,
    );
  }

  _loginForm(context) {
    double height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Container(
          padding: EdgeInsets.fromLTRB(AppPadding.p20.w, AppPadding.p10.h,
              AppPadding.p20.w, AppPadding.p10.h),
          margin: EdgeInsets.fromLTRB(AppMargin.m20.w, AppMargin.m10.h,
              AppMargin.m20.w, AppMargin.m10.h),
          child: Column(
            children: [
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _titleAndSubTitle(height),
                      _nameField(),
                      SizedBox(height: height / 30),
                      _passField(),
                      SizedBox(height: height / 50),
                      _forgotPassWidget(),
                      SizedBox(height: height / 60),
                      _loginButton(context),
                      _registerWidget(),
                    ],
                  )),
            ],
          )),
    );
  }

  Widget _titleAndSubTitle(double height) {
    return Column(
      children: [
        Text(
          AppStrings.loginTitle,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        Text(
          AppStrings.loginSubTitle,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        SizedBox(height: height / 20),
      ],
    );
  }

  Widget _nameField() {
    return Container(
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
    );
  }

  Widget _passField() {
    return Container(
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
    );
  }

  Widget _forgotPassWidget() {
    return Container(
      margin: EdgeInsets.fromLTRB(
          AppMargin.m10.w, AppMargin.m0.h, AppMargin.m10.w, AppMargin.m20.h),
      alignment: Alignment.topRight,
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, Routes.forgotPasswordRoute);
        },
        child: Text(
          AppStrings.forgetPassword,
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ),
    );
  }

  Widget _loginButton(context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: ColorManager.primary,
              offset: const Offset(0, 4),
              blurRadius: 5)
        ],
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).colorScheme.secondary,
          ],
        ),
        borderRadius: BorderRadius.circular(AppSize.s30),
      ),
      child: ElevatedButton(
        onPressed: () => _onTapLoginButton(context),
        child: Padding(
          padding: EdgeInsets.fromLTRB(AppPadding.p40.w, AppPadding.p10.h,
              AppPadding.p40.w, AppPadding.p10.h),
          child: Text(
            AppStrings.signIn.toUpperCase(),
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ),
    );
  }

  void _onTapLoginButton(context) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<LoginBloc>(context)
          .add(PostLoginEvent(_emailController.text, _passController.text));
    }
  }

  Widget _registerWidget() {
    return Container(
      margin: EdgeInsets.fromLTRB(
          AppMargin.m10.w, AppMargin.m20.h, AppMargin.m10.w, AppMargin.m20.h),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, Routes.registerRoute);
        },
        child: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: AppStrings.dontHaveAccount,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              TextSpan(
                text: AppStrings.create,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    instance<LoginBloc>().close();
    super.dispose();
  }
}
