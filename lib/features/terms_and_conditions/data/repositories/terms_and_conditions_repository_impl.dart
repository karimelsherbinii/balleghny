import 'package:dartz/dartz.dart';
import '../../domain/repositories/terms_and_conditions_repository.dart';
import '../datasources/terms_and_conditions_remote_data_source.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';

class TermsAndConditionsRepositoryImpl implements TermsAndConditionsRepository {
  final TermsAndConditionsRemoteDataSource termsAndConditionsRemoteDataSource;

  TermsAndConditionsRepositoryImpl({
    required this.termsAndConditionsRemoteDataSource,
  });
  @override
  Future<Either<Failure, String>> getTermsAndConditions() async {
    try {
      final response =
          await termsAndConditionsRemoteDataSource.getTermsAndConditions();
      return Right(response);
    } on ServerException catch (exception) {
      return Left(ServerFailure(message: exception.message));
    }
  }
}
