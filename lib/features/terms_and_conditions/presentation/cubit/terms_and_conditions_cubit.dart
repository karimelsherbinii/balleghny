import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ballaghny/core/usecases/usecase.dart';
import '../../../../core/error/failures.dart';
import '../../domain/usecases/get_terms_and_conditions.dart';
part 'terms_and_conditions_state.dart';

class TermsAndConditionsCubit extends Cubit<TermsAndConditionsState> {
  final GetTermsAndConditions useCase;
  TermsAndConditionsCubit({required this.useCase})
      : super(TermsAndConditionsInitial());

  Future<void> getTermsAndConditions() async {
    emit(TermsAndConditionstIsLoading());
    Either<Failure, String> response = await useCase.call(NoParams());
    emit(response.fold(
        (failure) => TermsAndConditionsError(message: failure.message),
        (content) => TermsAndConditionsLoaded(content: content)));
  }
}
