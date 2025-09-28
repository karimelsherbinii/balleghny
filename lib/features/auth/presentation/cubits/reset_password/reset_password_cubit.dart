import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ballaghny/features/auth/domain/usecases/verify_password_code.dart';
import '../../../../../core/api/base_response.dart';
import '../../../domain/usecases/reset_password.dart';
import '../../../../../core/api/status_code.dart';
import '../../../../../core/error/failures.dart';
part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final ResetPassword resetPasswordUseCase;
  final VerifyPasswordCode verifyPasswordCodeUseCase;

  ResetPasswordCubit(
      {required this.resetPasswordUseCase,
      required this.verifyPasswordCodeUseCase})
      : super(ResetPasswordInitial());

  bool isloading = false;

  Future<void> resetPassword({
    required GlobalKey<FormState> formKey,
    required String code,
    required String mobile,
    required String password,
  }) async {
    if (formKey.currentState!.validate()) {
      changeResetPasswordView();
      Either<Failure, BaseResponse> response = await resetPasswordUseCase.call(
          ResetPasswordParams(code: code, mobile: mobile, password: password));
      changeResetPasswordView();
      response.fold(
          (failure) => emit(ResetPasswordFailed(message: failure.message!)),
          (response) async {
        if (response.statusCode == StatusCode.ok) {
          emit(ResetPasswordSuccess(message: response.message!));
        } else {
          emit(ResetPasswordFailed(message: response.message ?? 'Failed'));
        }
      });
    } else {
      emit(ResetPasswordValidatation(isValidate: true));
    }
  }

  Future<void> verifyPasswordCode(String code) async {
    emit(VerifyPasswordCodeLoading());
    Either<Failure, BaseResponse> response = await verifyPasswordCodeUseCase
        .call(VerifyPasswordCodeParams(code: code));
    response.fold(
        (failure) =>
            emit(VerifyPasswordCodeErrorState(message: failure.message!)),
        (response) {
      if (response.statusCode == StatusCode.ok) {
        emit(VerifyPasswordCodeSuccessState(
            message: response.message!, code: response.data!));
      } else {
        emit(VerifyPasswordCodeErrorState(message: response.message!));
      }
    });
  }

  void changeResetPasswordView() {
    isloading = !isloading;
    emit(ResetPasswordLoading(isloading));
  }
}
