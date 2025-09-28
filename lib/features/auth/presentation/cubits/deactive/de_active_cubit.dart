import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/api/base_response.dart';
import '../../../../../core/api/status_code.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../domain/usecases/deactive_account.dart';

part 'de_active_state.dart';

class DeActiveCubit extends Cubit<DeActiveState> {
  final DeActiveAccount deActiveAccountUseCase;

  DeActiveCubit({
    required this.deActiveAccountUseCase,
  }) : super(DeActiveInitial());

  Future<String> deActiveAccount() async {
    emit(DeActiveLoading());
    Either<Failure, BaseResponse> response =
        await deActiveAccountUseCase.call(NoParams());
    response.fold((failure) => emit(DeActiveError(message: failure.message!)),
        (response) {
      if (response.statusCode == StatusCode.ok) {
        emit(DeActiveSuccess(message: response.message ?? 'Success DeActive'));
      } else {
        emit(DeActiveError(message: response.message ?? 'Failed DeActive'));
      }
    });
    return response.fold((failure) => failure.message!,
        (response) => response.message ?? 'Success DeActive');
  }
}
