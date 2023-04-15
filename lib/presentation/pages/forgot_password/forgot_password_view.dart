import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moro_shop/app/di.dart';
import 'package:moro_shop/presentation/bloc/forgot_password/forgot_password_bloc.dart';
import 'package:moro_shop/presentation/common/state_renderer/state_renderer.dart';
import 'package:moro_shop/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:moro_shop/presentation/pages/widgets/auth_header_widget.dart';
import 'package:moro_shop/presentation/resources/routes_manager.dart';
import 'package:moro_shop/presentation/resources/strings_manager.dart';
import 'package:moro_shop/presentation/resources/values_manager.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ForgotPasswordBloc>(
      create: (context) => instance<ForgotPasswordBloc>(),
      child: BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
        listener: (context, state) {
          _onForgotPasswordLoadingState(context, state);
          _onForgotPasswordSuccessState(context, state);
          _onForgotPasswordErrorState(context, state);
        },
        builder: (context, state) {
          return Scaffold(
            body: _buildBOdy(context),
          );
        },
      ),
    );
  }

  void _onForgotPasswordLoadingState(context, state) {
    if (state is ForgotPasswordLoadingState) {
      LoadingState(
              stateRendererType: StateRendererType.popupLoadingState,
              message: AppStrings.loading)
          .getScreenWidget(context);
    }
  }

  void _onForgotPasswordSuccessState(context, state) {
    if (state is ForgotPasswordSuccessState) {
      dismissDialog(context);
      Navigator.pushNamed(context, Routes.verifyCodeRoute,
          arguments: _emailController.text);
    }
  }

  void _onForgotPasswordErrorState(context, state) {
    if (state is ForgotPasswordErrorState) {
      ErrorState(StateRendererType.popupErrorState, state.message)
          .getScreenWidget(context, retryActionFunction: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, Routes.verifyCodeRoute,
            arguments: _emailController.text);
      }, buttonTitle: AppStrings.ok);
    }
  }

  Widget _buildBOdy(context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _headerWidget(),
          _threeCaptionsWidget(),
          _formWidget(context),
          _goLoginWidget(),
        ],
      ),
    );
  }

  Widget _headerWidget() {
    return AuthHeaderWidget(
      height: AppSize.s220.h,
      showIcon: true,
      icon: Icons.password_rounded,
    );
  }

  Widget _threeCaptionsWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: AppPadding.p20.h, horizontal: AppPadding.p40.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _firstCaption(),
          _secondCaption(),
          _thirdCaption(),
        ],
      ),
    );
  }

  Widget _firstCaption() {
    return Padding(
      padding: EdgeInsets.only(bottom: AppPadding.p10.h),
      child: Text(
        AppStrings.forgetPassword,
        style: Theme.of(context).textTheme.headlineMedium,
        // textAlign: TextAlign.center,
      ),
    );
  }

  Widget _secondCaption() {
    return Padding(
      padding: EdgeInsets.only(bottom: AppPadding.p10.h),
      child: Text(
        AppStrings.enterEmailAddress,
        style: Theme.of(context).textTheme.headlineSmall,
      ),
    );
  }

  Widget _thirdCaption() {
    return Text(
      AppStrings.sendVerification,
      style: Theme.of(context).textTheme.titleSmall,
      // textAlign: TextAlign.center,
    );
  }

  Widget _formWidget(context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: AppPadding.p20.h, horizontal: AppPadding.p40.w),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            _emailField(),
            _sendButton(context),
          ],
        ),
      ),
    );
  }

  Widget _emailField() {
    return Padding(
      padding: EdgeInsets.only(bottom: AppPadding.p30.h),
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: AppSize.s20,
            offset: const Offset(0, 5),
          )
        ]),
        child: TextFormField(
          controller: _emailController,
          decoration: const InputDecoration(
            label: Text(AppStrings.email),
            hintText: AppStrings.emailHintText,
          ),
          validator: (val) {
            if (val!.isEmpty) {
              return AppStrings.emailErrorText;
            }
            return null;
          },
        ),
      ),
    );
  }

  Widget _sendButton(context) {
    return Container(
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
          colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).colorScheme.secondary,
          ],
        ),
        borderRadius: BorderRadius.circular(30.sp),
      ),
      child: ElevatedButton(
        onPressed: () => _onTapSendButton(context),
        child: Padding(
          padding: EdgeInsets.fromLTRB(AppPadding.p40.w, AppPadding.p10.h,
              AppPadding.p40.w, AppPadding.p10.h),
          child: Text(
            AppStrings.send.toUpperCase(),
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ),
    );
  }

  void _onTapSendButton(context) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<ForgotPasswordBloc>(context)
          .add(PostForgotPasswordEvent(_emailController.text));
    }
  }

  Widget _goLoginWidget() {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: AppStrings.rememberYourPassword,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          TextSpan(
            text: AppStrings.login,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.pushNamedAndRemoveUntil(context, Routes.loginRoute,
                    ModalRoute.withName(Routes.splashRoute));
              },
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    instance<ForgotPasswordBloc>().close();
    super.dispose();
  }
}
