import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moro_shop/app/di.dart';
import 'package:moro_shop/presentation/bloc/register/register_bloc.dart';
import 'package:moro_shop/presentation/common/state_renderer/state_renderer.dart';
import 'package:moro_shop/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:moro_shop/presentation/pages/widgets/auth_header_widget.dart';
import 'package:moro_shop/presentation/resources/assets_manager.dart';
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

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegisterBloc>(
      create: (context) => instance<RegisterBloc>(),
      child: BlocConsumer<RegisterBloc, RegisterState>(
        listener: (context, state) {
          _onRegisterLoadingState(context, state);
          _onRegisterSuccessState(context, state);
          _onRegisterErrorState(context, state);
          _onPickCameraPhotoState(context, state);
          _onPickGalleryPhotoState(context, state);
        },
        builder: (context, state) {
          return Scaffold(
            body: _buildBody(context),
          );
        },
      ),
    );
  }

  void _onRegisterLoadingState(context, state) {
    if (state is RegisterLoadingState) {
      LoadingState(
        stateRendererType: StateRendererType.popupLoadingState,
        message: AppStrings.loading,
      ).getScreenWidget(context);
    }
  }

  void _onRegisterSuccessState(context, state) {
    if (state is RegisterSuccessState) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        Routes.mainRoute,
        ModalRoute.withName(Routes.splashRoute),
      );
    }
  }

  void _onRegisterErrorState(context, state) {
    if (state is RegisterErrorState) {
      ErrorState(StateRendererType.popupErrorState, state.message)
          .getScreenWidget(
        context,
        retryActionFunction: () => Navigator.pop(context),
        buttonTitle: AppStrings.ok,
      );
    }
  }

  void _onPickCameraPhotoState(context, state) {
    if (state is PickCameraPhotoState) {
      if (state.imageFile != null) {
        imageFile = state.imageFile;
      }
      Navigator.pop(context);
    }
  }

  void _onPickGalleryPhotoState(context, state) {
    if (state is PickGalleryPhotoState) {
      if (state.imageFile != null) {
        imageFile = state.imageFile;
      }
      Navigator.pop(context);
    }
  }

  Widget _buildBody(context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          _headerAndForm(context),
          _pickedImage(context),
        ],
      ),
    );
  }

  Widget _pickedImage(context) {
    return Positioned(
      top: AppSize.s100.h,
      right: AppSize.s20.w,
      child: GestureDetector(
        onTap: () => _showImageDialog(context),
        child: Stack(
          children: [
            _imageWidget(),
            _cameraIcon(),
          ],
        ),
      ),
    );
  }

  Widget _imageWidget() {
    return CircleAvatar(
      backgroundColor:
      Theme.of(context).colorScheme.secondary.withOpacity(.5),
      radius: AppSize.s55.sp,
      child: CircleAvatar(
        radius: AppSize.s50.sp,
        backgroundColor: ColorManager.white,
        backgroundImage: imageFile == null
            ? Image.asset(
          ImagesAssets.defaultProfilePic,
          fit: BoxFit.cover,
        ).image
            : Image.file(
          imageFile!,
          fit: BoxFit.fill,
        ).image,
      ),
    );
  }

  Widget _cameraIcon() {
    return Positioned(
      top: 0,
      right: AppSize.s5.w,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppPadding.p3.w,vertical: AppPadding.p3.h),
        child: Icon(
          imageFile == null ? Icons.add_a_photo : Icons.edit_outlined,
          size: AppSize.s18.sp,
          color: ColorManager.white,
        ),
      ),
    );
  }

  void _showImageDialog(context) {
    showDialog(
        context: context,
        builder: (_) => Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSize.s14.sp),),
          elevation: AppSize.s1_5,
          child: Container(
            decoration: BoxDecoration(
                color: ColorManager.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(AppSize.s14.sp),
                boxShadow: [BoxShadow(color: ColorManager.primary)]),
            padding: EdgeInsets.all(AppPadding.p10.sp),
            child: _dialogBody(context),
          ),
        ),);
  }

  Widget _dialogBody(context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          AppStrings.imageDialogTitle,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Padding(padding: EdgeInsets.symmetric(vertical: AppPadding.p12.h),
          child: InkWell(
            onTap: () {
              BlocProvider.of<RegisterBloc>(context)
                  .add(PickCameraPhotoEvent());
            },
            child: Padding(
              padding: EdgeInsets.all(AppPadding.p4.sp),
              child: Row(
                children: [
                  Icon(
                    Icons.camera,
                    color: ColorManager.blue,
                  ),
                  Padding(padding: EdgeInsets.symmetric(horizontal: AppPadding.p7.w),
                      child: Text(
                        AppStrings.camera,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),),
                ],
              ),
            ),
          ),),
        InkWell(
          onTap: () {
            BlocProvider.of<RegisterBloc>(context)
                .add(PickGalleryPhotoEvent());
          },
          child: Padding(
            padding: EdgeInsets.all(AppPadding.p4.sp),
            child: Row(
              children: [
                Icon(
                  Icons.image,
                  color: ColorManager.blue,
                ),
                Padding(padding: EdgeInsets.symmetric(horizontal: AppPadding.p7.w),
                    child: Text(
                      AppStrings.gallery,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _headerAndForm(context) {
    return Column(
      children: [
        _registerHeader(),
        _registerForm(context),
      ],
    );
  }

  Widget _registerHeader() {
    return AuthHeaderWidget(
        height: AppSize.s190.h, showIcon: false, icon: Icons.login_rounded);
  }

  Widget _registerForm(context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.fromLTRB(
            AppPadding.p20.w, AppPadding.p10.h, AppPadding.p20.w, AppPadding.p10.h),
        margin: EdgeInsets.fromLTRB(
            AppMargin.m20.w, AppMargin.m10.h, AppMargin.m20.w, AppMargin.m10.h),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  _nameField(),
                  _emailField(),
                  _passField(),
                  _phoneField(),
                  _registerButton(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _nameField() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppPadding.p30.h),
      child: Container(
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
    );
  }

  Widget _emailField() {
    return Padding(
      padding: EdgeInsets.only(bottom: AppPadding.p30.h),
      child: Container(
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
    );
  }

  Widget _passField() {
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
    );
  }

  Widget _phoneField() {
    return Padding(
      padding: EdgeInsets.only(bottom: AppPadding.p40.h),
      child: Container(
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
    );
  }

  Widget _registerButton(context) {
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
        borderRadius: BorderRadius.circular(AppSize.s30.sp),
      ),
      child: ElevatedButton(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              AppPadding.p40.w, AppPadding.p10.h, AppPadding.p40.w, AppPadding.p10.h),
          child: Text(
            AppStrings.register.toUpperCase(),
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        onPressed: () {
          String imageUrl = base64Encode((imageFile?.readAsBytesSync() ?? []));

          if (_formKey.currentState!.validate()) {
            BlocProvider.of<RegisterBloc>(context).add(
              PostRegisterEvent(
                _emailController.text,
                _passController.text,
                _nameController.text,
                _phoneController.text,
                imageUrl,
              ),
            );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    instance<RegisterBloc>().close();
    super.dispose();
  }
}
