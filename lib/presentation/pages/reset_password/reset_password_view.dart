import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moro_shop/app/di.dart';
import 'package:moro_shop/presentation/bloc/reset_password/reset_password_bloc.dart';
import 'package:moro_shop/presentation/common/state_renderer/state_renderer.dart';
import 'package:moro_shop/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:moro_shop/presentation/common/widgets/auth_header_widget.dart';
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
          if (state is ResetPasswordLoadingState) {
            LoadingState(
                    stateRendererType: StateRendererType.popupLoadingState,
                    message: AppStrings.loading)
                .getScreenWidget(context);
          }
          if (state is ResetPasswordSuccessState) {
            Navigator.pushNamedAndRemoveUntil(context, Routes.mainRoute,
                ModalRoute.withName(Routes.splashRoute),
                arguments: state.loginOrRegisterOrResetPasswordModel
                    .loginOrRegisterOrResetPasswordDataModel?.imageUrl);
          }
          if (state is ResetPasswordErrorState) {
            ErrorState(StateRendererType.popupErrorState, state.message)
                .getScreenWidget(context, retryActionFunction: () {
              Navigator.of(context).pop();
            }, buttonTitle: AppStrings.ok);
          }
        },
        builder: (context, state) {
          return Scaffold(
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    const AuthHeaderWidget(250, true,
                        icon: Icons.lock_reset_outlined),
                    SafeArea(
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(AppPadding.p25,
                            AppPadding.p10, AppPadding.p25, AppPadding.p10),
                        padding: const EdgeInsets.fromLTRB(AppPadding.p10,
                            AppPadding.p0, AppPadding.p10, AppPadding.p0),
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              margin: const EdgeInsets.fromLTRB(AppPadding.p20,
                                  AppPadding.p0, AppPadding.p20, AppPadding.p0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    AppStrings.resetPassword,
                                    style: TextStyle(
                                        fontSize: 35,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54),
                                    // textAlign: TextAlign.center,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    AppStrings.enterNewPassword,
                                    style: TextStyle(
                                        // fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54),
                                    // textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: AppSize.s40),
                            Form(
                              key: _formKey,
                              child: Column(
                                children: <Widget>[
                                  Container(
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
                                        hintText:
                                            AppStrings.newPasswordHintText,
                                      ),
                                      validator: (val) {
                                        if (val!.isEmpty) {
                                          return AppStrings
                                              .newPasswordErrorText;
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: AppSize.s40),
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
                                          Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: ElevatedButton(
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            AppPadding.p40,
                                            AppPadding.p10,
                                            AppPadding.p40,
                                            AppPadding.p10),
                                        child: Text(
                                          AppStrings.reset.toUpperCase(),
                                          style: const TextStyle(
                                            fontSize: AppSize.s20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          BlocProvider.of<ResetPasswordBloc>(
                                                  context)
                                              .add(PostResetPasswordEvent(
                                                  widget.email,
                                                  widget.code,
                                                  _newPassController.text));
                                        }
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 30.0),
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        const TextSpan(
                                            text: AppStrings
                                                .rememberYourPassword),
                                        TextSpan(
                                          text: AppStrings.login,
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              Navigator.pushNamedAndRemoveUntil(
                                                  context,
                                                  Routes.loginRoute,
                                                  ModalRoute.withName(
                                                      Routes.splashRoute));
                                            },
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ));
        },
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
