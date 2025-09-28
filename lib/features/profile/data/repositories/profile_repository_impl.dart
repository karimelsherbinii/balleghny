import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ballaghny/core/api/base_response.dart';
import 'package:ballaghny/core/error/exceptions.dart';
import 'package:ballaghny/core/error/failures.dart';
import 'package:ballaghny/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:ballaghny/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource profileRemoteDataSource;
  ProfileRepositoryImpl({required this.profileRemoteDataSource});

  @override
  Future<Either<Failure, BaseResponse>> getProfileData() async {
    try {
      final response = await profileRemoteDataSource.getProfileData();
      return Right(response);
    } on ServerException catch (exeption) {
      return Left(ServerFailure(message: exeption.message));
    }
  }

  @override
  Future<Either<Failure, BaseResponse>> updateProfileData({
    required String name,
    required String email,
    required String mobile,
    required String gender,
    String? image,
  }) async {
    try {
      final response = await profileRemoteDataSource.updateProfileData(
        name: name,
        email: email,
        mobile: mobile,
        gender: gender,
        image: image,
      );
      return Right(response);
    } on ServerException catch (exeption) {
      return Left(ServerFailure(message: exeption.message));
    }
  }

  @override
  Future<Either<Failure, BaseResponse>> uploadImage({required File image})async {
     try {
      final response = await profileRemoteDataSource.uploadImage(image: image);
      return Right(response);
    } on ServerException catch (exeption) {
      return Left(ServerFailure(message: exeption.message));
    }
  }
}
