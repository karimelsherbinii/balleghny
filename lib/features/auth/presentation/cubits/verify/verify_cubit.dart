import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:ballaghny/core/api/base_response.dart';
import 'package:ballaghny/core/api/status_code.dart';
import 'package:ballaghny/core/error/failures.dart';
import 'package:ballaghny/features/auth/domain/usecases/send_code.dart';
import 'package:ballaghny/features/auth/domain/usecases/verify_email_code.dart';

part 'verify_state.dart';

class VerifyCubit extends Cubit<VerifyState> {
  final SendCode sendCodeUseCase;
  final VerifyEmailCode verifyEmailCodeUseCase;
  VerifyCubit(
      {required this.sendCodeUseCase, required this.verifyEmailCodeUseCase})
      : super(VerifyInitial());

  Future<void> sendCode({
    required String mobile,
  }) async {
    emit(SendCodeLoadingState());
    Either<Failure, BaseResponse> response = await sendCodeUseCase.call(
      SendCodeParams(
        mobile: mobile,
      ),
    );
    response.fold(
        (failure) => emit(SendCodeErrorState(message: failure.message!)),
        (response) => emit(SendCodeSuccessState(message: response.message!)));
  }

  Future<void> verifyCode(String code) async {
    emit(VerifyLoadingState());
    Either<Failure, BaseResponse> response =
        await verifyEmailCodeUseCase.call(VerifyEmailCodeParams(code: code));
    response.fold(
        (failure) => emit(VerifyEmailCodeErrorState(message: failure.message!)),
        (response) {
      if (response.statusCode == StatusCode.ok) {
        emit(VerifyEmailCodeSuccessState(message: response.message!));
      } else {
        emit(VerifyEmailCodeErrorState(message: response.message!));
      }
    });
  }
}
