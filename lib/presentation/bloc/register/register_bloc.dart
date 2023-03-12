
import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moro_shop/app/app_prefs.dart';
import 'package:moro_shop/domain/models/models.dart';
import 'package:moro_shop/domain/use_case/register_use_case.dart';
import 'package:moro_shop/presentation/common/freezed_data_classes.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUseCase registerUseCase;
  var registerObject = RegisterObject('', '', '', '', '');
  File? imageFile;
  final AppPreferences appPreferences;
  LoginOrRegisterOrResetPasswordModel? loginOrRegisterOrResetPasswordModel;


  RegisterBloc({required this.registerUseCase,required this.appPreferences}) : super(RegisterInitial()) {
    on<RegisterEvent>((event, emit) async {
      if (event is PostRegisterEvent) {
        emit(RegisterLoadingState());

        registerObject = registerObject.copyWith(
            email: event.email,
            password: event.password,
            name: event.name,
            phone: event.phone,
            image: event.image);
        (await registerUseCase.execute(
          RegisterUseCaseInput(registerObject.email, registerObject.password,
              registerObject.name, registerObject.phone, registerObject.image),
        ))
            .fold((failure) {
          emit(RegisterErrorState(failure.message));
        }, (data)  {
          loginOrRegisterOrResetPasswordModel = data;
          appPreferences.saveToken(data.loginOrRegisterOrResetPasswordDataModel?.token??'');
           appPreferences.setUserLoggedIn();
          emit(RegisterSuccessState(data));
        });
      }
      if(event is PickCameraPhotoEvent){
         imageFile = await _pickImageWithCamera();
        emit(PickCameraPhotoState(imageFile));
      }
      if(event is PickGalleryPhotoEvent){
        imageFile = await _pickImageWithGallery();
        emit(PickCameraPhotoState(imageFile));
      }
    });
  }

  Future<File?> _pickImageWithGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery, maxWidth: 1080, maxHeight: 1080);

    if(pickedFile != null) {
      File? croppedImage = await _cropImage(pickedFile.path);
      return croppedImage;
    }
    return null;
  }

  Future<File?> _cropImage(filePath) async {
    CroppedFile? cropImage = await ImageCropper()
        .cropImage(sourcePath: filePath, maxHeight: 1080, maxWidth: 1080);
    if (cropImage != null) {

      imageFile = File(cropImage.path);
      return imageFile;
    }
    return null;
  }

  Future<File?> _pickImageWithCamera() async {
    XFile? pickedFile = await ImagePicker()
        .pickImage(source: ImageSource.camera, maxWidth: 1080, maxHeight: 1080);

    if(pickedFile != null) {
      File? croppedImage = await _cropImage(pickedFile.path);
      return croppedImage;
    }
     return null;

  }
  }
