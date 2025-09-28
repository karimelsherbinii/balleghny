import 'package:dio/dio.dart';
import 'package:ballaghny/core/api/api_consumer.dart';
import 'package:ballaghny/core/api/end_points.dart';
import 'package:ballaghny/core/utils/app_strings.dart';
import 'package:ballaghny/core/utils/constants.dart';
import '../../../../core/api/base_response.dart';
import '../models/notifications_data_model/notification_model.dart';

abstract class NotificationsRemoteDataSource {
  Future<BaseResponse> getNotifications({required int pageNumber});
  Future<BaseResponse> readNotificatoin({int id});
}

class NotificationsRemoteDataSourceImplementation
    implements NotificationsRemoteDataSource {
  final ApiConsumer apiConsumer;
  NotificationsRemoteDataSourceImplementation({required this.apiConsumer});
  @override
  Future<BaseResponse> getNotifications({required int pageNumber}) async {
    final Response response = await apiConsumer.get(
      EndPoints.notifications,
      queryParameters: {
        AppStrings.pageSize: Constants.fetchLimit,
        AppStrings.pageNumber: pageNumber,
      },
    );
    BaseResponse baseResponse = BaseResponse(statusCode: response.statusCode);
    final responseJson = Constants.decodeJson(response);

    if (response.statusCode == 200) {
      Iterable iterable = responseJson['data']['data'];
      baseResponse.data =
          iterable.map((model) => NotificationModel.fromJson(model)).toList();
      baseResponse.currentPage = responseJson[AppStrings.currentPage];
      baseResponse.lastPage = responseJson[AppStrings.lastPage];
      baseResponse.unReadTotal = responseJson['unread_total'];
    } else {
      baseResponse.message = responseJson[AppStrings.message];
    }
    return baseResponse;
  }

  @override
  Future<BaseResponse> readNotificatoin({int? id}) async {
    final Response response = await apiConsumer.put(
      '${EndPoints.notifications}/$id',
    );
    BaseResponse baseResponse = BaseResponse(data: response.statusCode);
    final responseJson = Constants.decodeJson(response);
    baseResponse.message = responseJson[AppStrings.message];
    return baseResponse;
  }
}
