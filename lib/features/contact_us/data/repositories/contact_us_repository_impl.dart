import 'package:ballaghny/core/error/exceptions.dart';
import 'package:ballaghny/features/contact_us/data/datasources/contact_us_remote_datasource.dart';
import 'package:ballaghny/features/contact_us/domain/repositories/contact_us_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:ballaghny/core/api/base_response.dart';
import 'package:ballaghny/core/error/failures.dart';

class ContactUsRepositoryImpl implements ContactUsRepository {
  final ContactUsRemoteDataSource profileRemoteDataSource;
  ContactUsRepositoryImpl({required this.profileRemoteDataSource});

  @override
  Future<Either<Failure, BaseResponse>> contactUs({
    required String name,
    required String email,
    required String title,
    required String message,
  }) async {
    try {
      final response = await profileRemoteDataSource.contactUs(
          name: name, email: email, title: title, message: message);
      return Right(response);
    } on ServerException catch (exception) {
      return Left(ServerFailure(message: exception.message!));
    }
  }
}
