import 'package:ballaghny/features/auth/data/models/user_model.dart';
import 'package:ballaghny/features/auth/domain/entities/user.dart';
import 'package:ballaghny/features/auth/domain/usecases/save_login_credentials.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/api/base_response.dart';
import '../../../domain/usecases/register.dart';
import '../../../../../core/api/status_code.dart';
import '../../../../../core/error/failures.dart';
part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final Register registerUseCase;
  final SaveLoginCredentials saveLoginCredentials;

  RegisterCubit({
    required this.registerUseCase,
    required this.saveLoginCredentials,
  }) : super(RegisterInitial());

  bool isloading = false;

  UserModel? authenticatedUser;

  Future<void> register({
    required GlobalKey<FormState> formKey,
    required String name,
    required String email,
    required String? gender,
    required String phone,
    required String password,
    // required String deviceType,
    // required String firebaseToken,
  }) async {
    if (formKey.currentState!.validate()) {
      changeRegisterView();
      Either<Failure, BaseResponse> response = await registerUseCase.call(
          RegisterParams(
              name: name,
              email: email,
              password: password,
              gender: gender!,
              phone: phone));
      changeRegisterView();
      response
          .fold((failure) => emit(RegisterFailed(message: failure.message!)),
              (response) async {
        if (response.statusCode == StatusCode.ok && response.status == true) {
          authenticatedUser = response.data as UserModel?;

          await saveLoginCredentials
              .call(SaveLoginCredentialsParams(user: response.data!));
          emit(RegisterSuccess(
              user: response.data!, message: response.message!));
        } else {
          emit(RegisterFailed(message: response.message ?? 'Failed'));
        }
      });
    } else {
      emit(RegisterValidatation(isValidate: true));
    }
  }

  void changeRegisterView() {
    isloading = !isloading;
    emit(RegisterLoading(isloading));
  }
}
