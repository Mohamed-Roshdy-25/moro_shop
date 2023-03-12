import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moro_shop/presentation/bloc/forgot_password/forgot_password_bloc.dart';
import 'package:moro_shop/presentation/bloc/verify_code/verify_code_bloc.dart';
import 'package:moro_shop/presentation/common/state_renderer/state_renderer.dart';
import 'package:moro_shop/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:moro_shop/presentation/common/widgets/auth_header_widget.dart';
import 'package:moro_shop/presentation/resources/routes_manager.dart';
import 'package:moro_shop/presentation/resources/strings_manager.dart';
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
    return BlocConsumer<VerifyCodeBloc,VerifyCodeState>(
      listener: (context, state) {
        if (state is VerifyCodeLoadingState) {
          LoadingState(
                  stateRendererType: StateRendererType.popupLoadingState,
                  message: AppStrings.loading)
              .getScreenWidget(context);
        }
        if (state is VerifyCodeSuccessState) {
          Navigator.pop(context);
          Navigator.pushNamed(context, Routes.resetPasswordRoute,
              arguments: {'email': widget.email, 'pin': _pin});
        }
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
      },
      builder: (context, state) {
        return Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const AuthHeaderWidget(250, true, icon: Icons.privacy_tip_outlined),
                  SafeArea(
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Verification',
                                  style: TextStyle(
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Enter the verification code we just sent you on your email address.',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 40.0),
                          Column(
                            children: [
                              OTPTextField(
                                length: 4,
                                width: 300,
                                fieldWidth: 50,
                                style: const TextStyle(fontSize: 30),
                                textFieldAlignment:
                                    MainAxisAlignment.spaceAround,
                                fieldStyle: FieldStyle.underline,
                                onCompleted: (pin) {
                                  _pin = pin;
                                  BlocProvider.of<VerifyCodeBloc>(context).add(
                                      PostVerifyCodeEvent(widget.email, pin));
                                },
                                onChanged: (value) {},
                              ),
                              const SizedBox(height: 50.0),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    const TextSpan(
                                      text: "If you didn't receive a code! ",
                                      style: TextStyle(
                                        color: Colors.black38,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'Resend',
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          BlocProvider.of<ForgotPasswordBloc>(
                                                  context)
                                              .add(PostForgotPasswordEvent(
                                                  widget.email));
                                        },
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.orange),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 40.0),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ));
      },
    );
  }
}
