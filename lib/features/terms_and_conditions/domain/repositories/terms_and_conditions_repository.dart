import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';

abstract class TermsAndConditionsRepository {
  Future<Either<Failure, String>> getTermsAndConditions();
}
