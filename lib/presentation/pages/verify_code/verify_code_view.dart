import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moro_shop/app/di.dart';
import 'package:moro_shop/presentation/bloc/forgot_password/forgot_password_bloc.dart';
import 'package:moro_shop/presentation/bloc/verify_code/verify_code_bloc.dart';
import 'package:moro_shop/presentation/common/state_renderer/state_renderer.dart';
import 'package:moro_shop/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:moro_shop/presentation/pages/widgets/auth_header_widget.dart';
import 'package:moro_shop/presentation/resources/color_manager.dart';
import 'package:moro_shop/presentation/resources/routes_manager.dart';
import 'package:moro_shop/presentation/resources/strings_manager.dart';
import 'package:moro_shop/presentation/resources/values_manager.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

class VerifyCodeView extends StatefulWidget {
  final String email;

  const VerifyCodeView({Key? key, required this.email}) : super(key: key);

  @override
  State<VerifyCodeView> createState() => _VerifyCodeViewState();
}

class _VerifyCodeViewState extends State<VerifyCodeView> {
  late String _pin;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => instance<VerifyCodeBloc>()),
        BlocProvider(create: (context) => instance<ForgotPasswordBloc>()),
      ],
      child: BlocConsumer<VerifyCodeBloc, VerifyCodeState>(
        listener: (context, state) {
          _onVerifyCodeLoadingState(context, state);
          _onVerifyCodeSuccessState(context, state);
          _onVerifyCodeErrorState(context, state);
        },
        builder: (context, state) {
          return Scaffold(
            body: _buildBody(context),
          );
        },
      ),
    );
  }

  void _onVerifyCodeLoadingState(context, state) {
    if (state is VerifyCodeLoadingState) {
      LoadingState(
              stateRendererType: StateRendererType.popupLoadingState,
              message: AppStrings.loading)
          .getScreenWidget(context);
    }
  }

  void _onVerifyCodeSuccessState(context, state) {
    if (state is VerifyCodeSuccessState) {
      Navigator.pop(context);
      Navigator.pushNamed(context, Routes.resetPasswordRoute,
          arguments: {'email': widget.email, 'pin': _pin});
    }
  }

  void _onVerifyCodeErrorState(context, state) {
    if (state is VerifyCodeErrorState) {
      ErrorState(StateRendererType.popupErrorState, state.message)
          .getScreenWidget(
        context,
        retryActionFunction: () {
          Navigator.pop(context);
          Navigator.pushNamed(context, Routes.resetPasswordRoute,
              arguments: {'email': widget.email, 'pin': _pin});
        },
        buttonTitle: AppStrings.ok,
      );
    }
  }

  Widget _buildBody(context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _headerWidget(),
          _twoCaptions(),
          _otpWidget(context),
          _resendCodeWidget(context),
        ],
      ),
    );
  }

  Widget _headerWidget() {
    return AuthHeaderWidget(
      height: AppSize.s220.h,
      showIcon: true,
      icon: Icons.privacy_tip_outlined,
    );
  }

  Widget _twoCaptions() {
    return Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.symmetric(horizontal: AppPadding.p20.w),
      padding: EdgeInsets.symmetric(
          horizontal: AppPadding.p30.w, vertical: AppPadding.p40.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: AppPadding.p10.h),
            child: Text(
              AppStrings.verification,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          Text(
            AppStrings.enterVerifyCode,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }

  Widget _otpWidget(context) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppPadding.p40.h),
      child: OTPTextField(
        length: 4,
        width: 300,
        fieldWidth: 50,
        style: const TextStyle(fontSize: 30),
        textFieldAlignment: MainAxisAlignment.spaceAround,
        fieldStyle: FieldStyle.underline,
        onCompleted: (pin) {
          _pin = pin;
          BlocProvider.of<VerifyCodeBloc>(context)
              .add(PostVerifyCodeEvent(widget.email, pin));
        },
        onChanged: (value) {},
      ),
    );
  }

  Widget _resendCodeWidget(context) {
    return BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
      listener: (context, state) {
        _onForgotPasswordLoadingState(context, state);
        _onForgotPasswordErrorState(context, state);
      },
      builder: (context, state) => Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: AppStrings.didReceiveACode,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            TextSpan(
              text: 'Resend',
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  BlocProvider.of<ForgotPasswordBloc>(context)
                      .add(PostForgotPasswordEvent(widget.email));
                },
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: ColorManager.orange),
            ),
          ],
        ),
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

  void _onForgotPasswordErrorState(context, state) {
    if (state is ForgotPasswordErrorState) {
      ErrorState(StateRendererType.popupErrorState, state.message)
          .getScreenWidget(
        context,
        retryActionFunction: () {
          Navigator.pop(context);
        },
        buttonTitle: AppStrings.ok,
      );
    }
  }

  @override
  void dispose() {
    instance<ForgotPasswordBloc>().close();
    instance<VerifyCodeBloc>().close();
    super.dispose();
  }
}
