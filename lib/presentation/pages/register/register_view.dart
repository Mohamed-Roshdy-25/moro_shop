import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moro_shop/app/app_prefs.dart';
import 'package:moro_shop/app/di.dart';
import 'package:moro_shop/presentation/bloc/register/register_bloc.dart';
import 'package:moro_shop/presentation/common/state_renderer/state_renderer.dart';
import 'package:moro_shop/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:moro_shop/presentation/common/widgets/auth_header_widget.dart';
import 'package:moro_shop/presentation/resources/color_manager.dart';
import 'package:moro_shop/presentation/resources/routes_manager.dart';
import 'package:moro_shop/presentation/resources/strings_manager.dart';
import 'package:moro_shop/presentation/resources/values_manager.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  File? imageFile;


  AppPreferences? _appPreferences;

  @override
  void initState() {
    _isLoggedIn();
    super.initState();
  }

  _isLoggedIn() {
    RegisterBloc.isUserRegisteredSuccessfullyStreamController.stream
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
    RegisterBloc.isUserRegisteredSuccessfullyStreamController.close();
    _emailController.dispose();
    _passController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocProvider<RegisterBloc>(
      create: (_) => instance<RegisterBloc>(),
      child: BlocConsumer<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state is RegisterLoadingState) {
            LoadingState(stateRendererType: StateRendererType.popupLoadingState,message: AppStrings.loading).getScreenWidget(context);
          }
          if (state is RegisterErrorState) {
            ErrorState(StateRendererType.popupErrorState, state.message).getScreenWidget(context);
          }
          if (state is PickCameraPhotoState) {
            if (state.imageFile !=null) {
              imageFile = state.imageFile;
            }
            Navigator.pop(context);
          }
          if (state is PickGalleryPhotoState) {
            if (state.imageFile !=null) {
              imageFile = state.imageFile;
            }
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: _buildBody(context,size),
          );
        },
      ),
    );
  }

  _buildBody(context,size) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          Column(
            children: [
              const AuthHeaderWidget(200, false, Icons.login_rounded),
              _registerForm(context),
            ],
          ),
          Positioned(
            top: 100,
            right: 20,
            child: GestureDetector(
              onTap: () {
                _showImageDialog(context);
              },
              child: CircleAvatar(
                backgroundColor: Colors.blue.withOpacity(.7),
                radius: 60,
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
                  backgroundImage: imageFile == null
                      ? Image.network(
                    'https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_1280.png',
                    fit: BoxFit.cover,
                  ).image
                      : Image.file(
                    imageFile??File(""),
                    fit: BoxFit.fill,
                  ).image,
                ),
              ),
            ),)
        ],
      ),
    );
  }

  _registerForm(context) {
    return SafeArea(
      child: Container(
          padding: const EdgeInsets.fromLTRB(AppPadding.p20, AppPadding.p10, AppPadding.p20, AppPadding.p10),
          margin: const EdgeInsets.fromLTRB(AppMargin.m20, AppMargin.m10, AppMargin.m20, AppMargin.m10),
          child: Column(
            children: [
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
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
                          controller: _nameController,
                          decoration: const InputDecoration(
                            label: Text(AppStrings.name),
                            hintText: AppStrings.nameHintText,
                          ),
                          validator: (value) {
                            if (value?.isEmpty ?? false) {
                              return AppStrings.nameErrorText;
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
                          controller: _phoneController,
                          decoration: const InputDecoration(
                            label: Text(AppStrings.phone),
                            hintText: AppStrings.phoneHintText,
                          ),
                          validator: (value) {
                            if (value?.isEmpty ?? false) {
                              return AppStrings.phoneErrorText;
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
                            padding: const EdgeInsets.fromLTRB(AppPadding.p40, AppPadding.p10, AppPadding.p40, AppPadding.p10),
                            child: Text(
                              'Register'.toUpperCase(),
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              BlocProvider.of<RegisterBloc>(context).add(
                                  PostRegisterEvent(_emailController.text,
                                      _passController.text,_nameController.text,_phoneController.text,imageFile?.path??''));
                            }
                          },
                        ),
                      ),
                    ],
                  )),
            ],
          )),
    );
  }

   _showImageDialog(context) {
    showDialog(
        context: context,
        builder: (_) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSize.s14)),
            elevation: AppSize.s1_5,
            child: Container(
              decoration: BoxDecoration(
                  color: ColorManager.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(AppSize.s14),
                  boxShadow: const [BoxShadow(color: Colors.black26)]),
              padding: const EdgeInsets.all(AppPadding.p10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('Please choose an option'),
                  const SizedBox(height: AppSize.s12,),
                  InkWell(
                    onTap: () {
                      BlocProvider.of<RegisterBloc>(context).add(const PickCameraPhotoEvent());
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.camera,
                            color: Colors.blue,
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          Text(
                            'Camera',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSize.s8,),
                  InkWell(
                    onTap: () {
                      BlocProvider.of<RegisterBloc>(context).add(const PickGalleryPhotoEvent());
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.image,
                            color: Colors.blue,
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          Text(
                            'Gallery',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ],
                      ),
                    ),
                  ),

                ],
              ),
            ),
          );
        });
  }
}
