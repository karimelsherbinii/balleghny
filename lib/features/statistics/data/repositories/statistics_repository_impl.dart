import 'package:ballaghny/core/api/base_response.dart';
import 'package:ballaghny/core/error/exceptions.dart';
import 'package:ballaghny/core/error/failures.dart';
import 'package:ballaghny/features/statistics/data/datasources/statistics_remote_datasource.dart';
import 'package:ballaghny/features/statistics/domain/repositories/statistics_repository.dart';
import 'package:dartz/dartz.dart';

class StatisticsRepositoryImpl implements StatisticsRepository {
  final StatisticsRemoteDatasource remoteDataSource;

  StatisticsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, BaseResponse>> getStatistics() async {
    try {
      final response = await remoteDataSource.getStatistics();
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, BaseResponse>> getChartStatistics() async {
    try {
      final response = await remoteDataSource.getChartStatistics();
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
