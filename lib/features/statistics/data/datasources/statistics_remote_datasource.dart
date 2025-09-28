import 'package:ballaghny/core/api/api_consumer.dart';
import 'package:ballaghny/core/api/base_response.dart';
import 'package:ballaghny/core/api/end_points.dart';
import 'package:ballaghny/core/utils/constants.dart';
import 'package:ballaghny/features/statistics/data/models/dashboard_model.dart';
import 'package:ballaghny/features/statistics/data/models/statistic_model.dart';

abstract class StatisticsRemoteDatasource {
  Future<BaseResponse> getStatistics();
  Future<BaseResponse> getChartStatistics();
}

class StatisticsRemoteDatasourceImpl implements StatisticsRemoteDatasource {
  final ApiConsumer apiConsumer;
  StatisticsRemoteDatasourceImpl({required this.apiConsumer});
  @override
  Future<BaseResponse> getStatistics() async {
    final response = await apiConsumer.get(EndPoints.statistics);

    BaseResponse baseResponse = BaseResponse(
      statusCode: response.statusCode,
    );
    var jsonResponse = Constants.decodeJson(response);
    baseResponse.status = jsonResponse['status'];
    if (response.statusCode == 200) {
      baseResponse.data = DashboardModel.fromJson(jsonResponse['data']);
    } else {
      baseResponse.message = jsonResponse['message'];
    }
    return baseResponse;
  }

  @override
  Future<BaseResponse> getChartStatistics() async {
    final response = await apiConsumer.get(EndPoints.chartStatistics);
    BaseResponse baseResponse = BaseResponse(
      statusCode: response.statusCode,
    );
    var jsonResponse = Constants.decodeJson(response);
    baseResponse.status = jsonResponse['status'];
    if (response.statusCode == 200) {
      baseResponse.data = StatisticModel.fromJson(jsonResponse['data']);
    } else {
      baseResponse.message = jsonResponse['message'];
    }
    return baseResponse;
  }
}
