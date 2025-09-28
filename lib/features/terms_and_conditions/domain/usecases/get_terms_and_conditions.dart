import 'package:dartz/dartz.dart';
import 'package:ballaghny/features/terms_and_conditions/domain/repositories/terms_and_conditions_repository.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';

class GetTermsAndConditions implements UseCase<String, NoParams> {
  final TermsAndConditionsRepository termsAndConditionsRepository;
  GetTermsAndConditions({required this.termsAndConditionsRepository});

  @override
  Future<Either<Failure, String>> call(NoParams params) async =>
      await termsAndConditionsRepository.getTermsAndConditions();
}
