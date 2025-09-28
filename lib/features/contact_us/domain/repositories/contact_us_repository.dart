import 'package:dartz/dartz.dart';
import 'package:ballaghny/core/api/base_response.dart';
import 'package:ballaghny/core/error/failures.dart';

abstract class ContactUsRepository {
  Future<Either<Failure, BaseResponse>> contactUs({
    required String name,
    required String email,
    required String title,
    required String message,
  });
}
