import 'package:ballaghny/core/api/base_response.dart';
import 'package:ballaghny/core/error/failures.dart';
import 'package:dartz/dartz.dart';

abstract class StatisticsRepository {
  Future<Either<Failure, BaseResponse>> getStatistics();
  Future<Either<Failure, BaseResponse>> getChartStatistics();
}
