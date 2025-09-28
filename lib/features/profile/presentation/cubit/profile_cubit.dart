import 'dart:developer';
import 'dart:io';

import 'package:ballaghny/features/auth/domain/usecases/save_login_credentials.dart';
import 'package:ballaghny/features/profile/domain/usecases/upload_image.dart';
import 'package:ballaghny/injection_container.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ballaghny/core/usecases/usecase.dart';
import 'package:ballaghny/features/auth/data/models/user_model.dart';

import 'package:ballaghny/features/profile/domain/usecases/get_profile.dart';
import 'package:ballaghny/features/profile/domain/usecases/update_profile.dart';
import 'package:image_picker/image_picker.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetProfileData getProfileDataUseCase;
  final UpdateProfileData updateProfileDataUseCase;
  final UploadImage uploadImageUseCase;
  ProfileCubit(
    this.getProfileDataUseCase,
    this.updateProfileDataUseCase,
    this.uploadImageUseCase,
  ) : super(ProfileInitial());

  UserModel? user;

  Future<void> getProfile() async {
    emit(GetProfileDataLoadingState());
    final result = await getProfileDataUseCase(NoParams());
    result.fold(
      (failure) => emit(GetProfileDataErrorState(message: failure.message!)),
      (data) {
        if (data.statusCode == 200) {
          user = data.data;
          emit(GetProfileDataLoadedState(profile: data.data));
        } else {
          emit(GetProfileDataErrorState(message: data.message!));
        }
      },
    );
  }

  Future<void> updateProfile({
    required String name,
    required String email,
    required String mobile,
    required String gender,
    String? image,
  }) async {
    emit(UpdateProfileDataLoadingState());
    final result = await updateProfileDataUseCase(UpdateProfileDataParams(
      name: name,
      email: email,
      mobile: mobile,
      gender: gender,
      image: image,
    ));
    result.fold(
        (failure) =>
            emit(UpdateProfileDataErrorState(message: failure.message!)),
        (data) {
      if (data.statusCode == 200 && data.status == true) {
        emit(UpdateProfileDataSuccessState(
            profile: data.data, message: data.message!));
      } else {
        emit(UpdateProfileDataErrorState(message: data.message!));
      }
    });
  }

  Future<void> uploadImage({
    required File image,
  }) async {
    emit(UploadImageLoadingState());
    final result = await uploadImageUseCase(UploadImageParams(image: image));
    result.fold(
        (failure) => emit(UploadImageErrorState(message: failure.message!)),
        (data) {
      if (data.statusCode == 200) {
        final saveLoginCredentials = sl<SaveLoginCredentials>();
        saveLoginCredentials.call(SaveLoginCredentialsParams(user: data.data!));

        emit(UploadImageSuccessState(message: data.message!));
      } else {
        emit(UploadImageErrorState(message: data.message!));
      }
    });
  }

  File pickedImage = File('');
  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );

    if (pickedFile != null) {
      pickedImage = File(pickedFile.path);
      uploadImage(image: pickedImage);
    } else {
      log('No image selected.');
    }
  }
}
