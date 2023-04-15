import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moro_shop/app/di.dart';
import 'package:moro_shop/presentation/bloc/reset_password/reset_password_bloc.dart';
import 'package:moro_shop/presentation/common/state_renderer/state_renderer.dart';
import 'package:moro_shop/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:moro_shop/presentation/pages/widgets/auth_header_widget.dart';
import 'package:moro_shop/presentation/resources/routes_manager.dart';
import 'package:moro_shop/presentation/resources/strings_manager.dart';
import 'package:moro_shop/presentation/resources/values_manager.dart';

class ResetPasswordView extends StatefulWidget {
  final String email;
  final String code;
  const ResetPasswordView({Key? key, required this.email, required this.code})
      : super(key: key);

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _newPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ResetPasswordBloc>(
      create: (context) => instance<ResetPasswordBloc>(),
      child: BlocConsumer<ResetPasswordBloc, ResetPasswordState>(
        listener: (context, state) {
          _onResetPasswordLoadingState(context, state);
          _onResetPasswordSuccessState(context, state);
          _onResetPasswordErrorState(context, state);
        },
        builder: (context, state) {
          return Scaffold(
            body: _buildBOdy(context),
          );
        },
      ),
    );
  }

  void _onResetPasswordLoadingState(context, state) {
    if (state is ResetPasswordLoadingState) {
      LoadingState(
              stateRendererType: StateRendererType.popupLoadingState,
              message: AppStrings.loading)
          .getScreenWidget(context);
    }
  }

  void _onResetPasswordSuccessState(context, state) {
    if (state is ResetPasswordSuccessState) {
      Navigator.pushNamedAndRemoveUntil(
          context, Routes.mainRoute, ModalRoute.withName(Routes.splashRoute),
          arguments: state.loginOrRegisterOrResetPasswordModel
              .loginOrRegisterOrResetPasswordDataModel?.imageUrl);
    }
  }

  void _onResetPasswordErrorState(context, state) {
    if (state is ResetPasswordErrorState) {
      ErrorState(StateRendererType.popupErrorState, state.message)
          .getScreenWidget(context, retryActionFunction: () {
        Navigator.of(context).pop();
      }, buttonTitle: AppStrings.ok);
    }
  }

  Widget _buildBOdy(context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _headerWidget(),
          _twoCaptionsWidget(),
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
      icon: Icons.lock_reset_outlined,
    );
  }

  Widget _twoCaptionsWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: AppPadding.p20.h, horizontal: AppPadding.p40.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _firstCaption(),
          _secondCaption(),
        ],
      ),
    );
  }

  Widget _firstCaption() {
    return Padding(
      padding: EdgeInsets.only(bottom: AppPadding.p10.h),
      child: Text(
        AppStrings.resetPassword,
        style: Theme.of(context).textTheme.headlineMedium,
        // textAlign: TextAlign.center,
      ),
    );
  }

  Widget _secondCaption() {
    return Padding(
      padding: EdgeInsets.only(bottom: AppPadding.p10.h),
      child: Text(
        AppStrings.enterNewPassword,
        style: Theme.of(context).textTheme.headlineSmall,
      ),
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
            _newPassField(),
            _resetButton(context),
          ],
        ),
      ),
    );
  }

  Widget _newPassField() {
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
          controller: _newPassController,
          decoration: const InputDecoration(
            label: Text(AppStrings.newPassword),
            hintText: AppStrings.newPasswordHintText,
          ),
          validator: (val) {
            if (val!.isEmpty) {
              return AppStrings.newPasswordErrorText;
            }
            return null;
          },
        ),
      ),
    );
  }

  Widget _resetButton(context) {
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
        onPressed: () => _onTapResetButton(context),
        child: Padding(
          padding: EdgeInsets.fromLTRB(AppPadding.p40.w, AppPadding.p10.h,
              AppPadding.p40.w, AppPadding.p10.h),
          child: Text(
            AppStrings.reset.toUpperCase(),
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ),
    );
  }

  void _onTapResetButton(context) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<ResetPasswordBloc>(context).add(PostResetPasswordEvent(
          widget.email, widget.code, _newPassController.text));
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
    _newPassController.dispose();
    instance<ResetPasswordBloc>().close();
    super.dispose();
  }
}
