import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ballaghny/core/api/base_response.dart';
import 'package:ballaghny/core/error/failures.dart';

abstract class ProfileRepository {
  Future<Either<Failure, BaseResponse>> getProfileData();

  Future<Either<Failure, BaseResponse>> updateProfileData({
    required String name,
    required String email,
    required String mobile,
    required String gender,
    String? image,
  });

  Future<Either<Failure, BaseResponse>> uploadImage({required File image});
}
