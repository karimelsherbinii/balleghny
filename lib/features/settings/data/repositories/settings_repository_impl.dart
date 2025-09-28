import 'package:ballaghny/core/api/base_response.dart';
import 'package:ballaghny/features/settings/data/datasources/settings_remote_datasource.dart';
import 'package:dartz/dartz.dart';
import 'package:ballaghny/core/error/exceptions.dart';

import '../../../../core/error/failures.dart';
import '../../domain/repositories/settings_repository.dart';
import '../datasources/settings_local_datasource.dart';

class SettingsRepositoryImplementation implements SettingsRepository {
  final SettingsLocalDataSource darkModeLocalDataSource;
  final SettingsRemoteDataSource settingsRemoteDataSource;
  SettingsRepositoryImplementation(
      {required this.darkModeLocalDataSource,
      required this.settingsRemoteDataSource});
  @override
  Future<Either<Failure, bool>> changeDarkMode({required bool isDark}) async {
    try {
      final isDarkChanged =
          await darkModeLocalDataSource.changeDarkMode(isDark: isDark);
      return Right(isDarkChanged);
    } on CacheException {
      return const Left(CacheFailure());
    }
  }

// 2
  @override
  Future<Either<Failure, bool>> savedDarkMode() async {
    try {
      final isDark = await darkModeLocalDataSource.getSavedDarkMode();
      return Right(isDark);
    } on CacheException {
      return const Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse>> getCountries() async {
    try {
      final response = await settingsRemoteDataSource.getCountries();
      return Right(response);
    } on ServerException catch (error) {
      return Left(ServerFailure(message: error.message));
    }
  }

  @override
  Future<Either<Failure, BaseResponse>> getLanguages() async {
    try {
      final response = await settingsRemoteDataSource.getLanguages();
      return Right(response);
    } on ServerException catch (error) {
      return Left(ServerFailure(message: error.message));
    }
  }

  @override
  Future<Either<Failure, BaseResponse>> getNationalities() async {
    try {
      final response = await settingsRemoteDataSource.getNationalities();
      return Right(response);
    } on ServerException catch (error) {
      return Left(ServerFailure(message: error.message));
    }
  }

  @override
  Future<Either<Failure, BaseResponse>> getReligions() async {
    try {
      final response = await settingsRemoteDataSource.getReligions();
      return Right(response);
    } on ServerException catch (error) {
      return Left(ServerFailure(message: error.message));
    }
  }
}
