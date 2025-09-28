import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/api/base_response.dart';
import '../../../../../core/api/status_code.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../domain/usecases/delete_account.dart';

part 'delete_account_state.dart';

class DeleteAccountCubit extends Cubit<DeleteAccountState> {
  final DeleteAccount deleteAccountUseCase;

  DeleteAccountCubit({required this.deleteAccountUseCase})
    : super(DeleteAccountInitial());

  Future<String> deleteAccount() async {
    emit(DeleteAccountLoading());
    Either<Failure, BaseResponse> response = await deleteAccountUseCase.call(
      NoParams(),
    );
    response.fold(
      (failure) => emit(DeleteAccountError(message: failure.message!)),
      (response) {
        if (response.statusCode == StatusCode.ok) {
          emit(
            DeleteAccountSuccess(
              message: response.message ?? 'تم حذف الحساب بنجاح',
            ),
          );
        } else {
          emit(
            DeleteAccountError(
              message: response.message ?? 'فشل في حذف الحساب',
            ),
          );
        }
      },
    );
    return response.fold(
      (failure) => failure.message!,
      (response) => response.message ?? 'تم حذف الحساب بنجاح',
    );
  }
}
