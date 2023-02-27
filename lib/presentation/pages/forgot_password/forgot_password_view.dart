import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moro_shop/app/di.dart';
import 'package:moro_shop/presentation/bloc/forgot_password/forgot_password_bloc.dart';
import 'package:moro_shop/presentation/common/state_renderer/state_renderer.dart';
import 'package:moro_shop/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:moro_shop/presentation/common/widgets/auth_header_widget.dart';
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
      child: BlocConsumer<ForgotPasswordBloc,ForgotPasswordState>(
        listener: (context, state) {
          if (state is ForgotPasswordLoadingState) {
            LoadingState(stateRendererType: StateRendererType.popupLoadingState,message: AppStrings.loading).getScreenWidget(context);
          }
          if(state is ForgotPasswordSuccessState){
            SuccessState(state.message).getScreenWidget(context);
          }
          if (state is ForgotPasswordErrorState) {
            ErrorState(StateRendererType.popupErrorState, state.message).getScreenWidget(context,retryActionFunction: (){
              Navigator.pop(context);
              Navigator.pushNamed(context, Routes.verifyCodeRoute,arguments: _emailController.text);
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    const AuthHeaderWidget(250, true, Icons.password_rounded),
                    SafeArea(
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(AppPadding.p25, AppPadding.p10, AppPadding.p25, AppPadding.p10),
                        padding: const EdgeInsets.fromLTRB(AppPadding.p10, AppPadding.p0, AppPadding.p10, AppPadding.p0),
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              margin: const EdgeInsets.fromLTRB(AppPadding.p20, AppPadding.p0, AppPadding.p20, AppPadding.p0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(AppStrings.forgetPassword,
                                    style: TextStyle(
                                        fontSize: 35,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54
                                    ),
                                    // textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 10,),
                                  Text(AppStrings.enterEmailAddress,
                                    style: TextStyle(
                                      // fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54
                                    ),
                                    // textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: AppSize.s10,),
                                  Text(AppStrings.sendVerification,
                                    style: TextStyle(
                                      color: Colors.black38,
                                      // fontSize: 20,
                                    ),
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
                                      controller: _emailController,
                                      decoration: const InputDecoration(
                                        label: Text(AppStrings.email),
                                        hintText: AppStrings.emailHintText,
                                      ),
                                      validator: (val){
                                        if(val!.isEmpty){
                                          return AppStrings.emailErrorText;
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
                                          Theme.of(context).colorScheme.secondary,
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: ElevatedButton(
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            AppPadding.p40, AppPadding.p10, AppPadding.p40, AppPadding.p10),
                                        child: Text(
                                          AppStrings.send.toUpperCase(),
                                          style: const TextStyle(
                                            fontSize: AppSize.s20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      onPressed: () {
                                        if(_formKey.currentState!.validate()) {
                                          BlocProvider.of<ForgotPasswordBloc>(context).add(PostForgotPasswordEvent(_emailController.text));
                                        }
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 30.0),
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        const TextSpan(text: AppStrings.rememberYourPassword),
                                        TextSpan(
                                          text: AppStrings.login,
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              Navigator.pushNamed(context, Routes.loginRoute);
                                            },
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context).colorScheme.secondary,
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
              )
          );
        },
      ),
    );
  }
}
