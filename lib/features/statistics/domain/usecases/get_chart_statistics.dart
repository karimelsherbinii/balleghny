import 'package:ballaghny/core/api/base_response.dart';
import 'package:ballaghny/core/error/failures.dart';
import 'package:ballaghny/core/usecases/usecase.dart';
import 'package:ballaghny/features/statistics/domain/repositories/statistics_repository.dart';
import 'package:dartz/dartz.dart';

class GetChartStatistics extends UseCase<BaseResponse, NoParams> {
  final StatisticsRepository repository;

  GetChartStatistics(this.repository);

  @override
  Future<Either<Failure, BaseResponse>> call(NoParams params) async {
    return await repository.getChartStatistics();
  }
}
