import 'package:ballaghny/core/api/base_response.dart';
import 'package:ballaghny/core/error/failures.dart';
import 'package:dartz/dartz.dart';

abstract class IslamRepository {
  Future<Either<Failure, BaseResponse>> getIntroductions({
    required String search,
  });
  Future<Either<Failure, BaseResponse>> getOrders({
    required int page,
  });

  Future<Either<Failure, BaseResponse>> inviteToIslam({
    required String name,
    String? email,
    String? phoneNumber,
    String? gender,
    String? country,
    String? city,
    String? language,
    String? religion,
    String? socialMediaAccount,
  });

  Future<Either<Failure, BaseResponse>> share({
    required int id,
  });
}
