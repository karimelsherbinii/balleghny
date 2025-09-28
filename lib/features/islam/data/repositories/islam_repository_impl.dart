import 'package:ballaghny/core/api/base_response.dart';
import 'package:ballaghny/core/error/exceptions.dart';
import 'package:ballaghny/core/error/failures.dart';
import 'package:ballaghny/features/islam/data/datasources/islam_remote_datasource.dart';
import 'package:ballaghny/features/islam/domain/repositories/islam_repository.dart';
import 'package:dartz/dartz.dart';

class IslamRepositoryImpl implements IslamRepository {
  final IslamRemoteDataSource remoteDataSource;

  IslamRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, BaseResponse>> getIntroductions({
    required String search,
  }) async {
    try {
      final response = await remoteDataSource.getIntroductions(
        search: search,
      );
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, BaseResponse>> inviteToIslam(
      {required String name,
      String? email,
      String? phoneNumber,
      String? gender,
      String? country,
      String? city,
      String? language,
      String? religion,
      String? socialMediaAccount}) async {
    try {
      final response = await remoteDataSource.inviteToIslam(
          name: name,
          email: email,
          phoneNumber: phoneNumber,
          gender: gender,
          country: country,
          city: city,
          language: language,
          religion: religion,
          socialMediaAccount: socialMediaAccount);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, BaseResponse>> getOrders({
    required int page,
  }) async {
    try {
      final response = await remoteDataSource.getOrders(
        page: page,
      );
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, BaseResponse>> share({required int id}) async {
    try {
      final response = await remoteDataSource.share(
        id: id,
      );
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
