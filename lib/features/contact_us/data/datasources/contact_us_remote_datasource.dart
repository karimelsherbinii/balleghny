import 'package:dio/dio.dart';
import 'package:ballaghny/core/api/api_consumer.dart';
import 'package:ballaghny/core/api/base_response.dart';
import 'package:ballaghny/core/api/end_points.dart';
import 'package:ballaghny/core/utils/app_strings.dart';
import 'package:ballaghny/core/utils/constants.dart';

abstract class ContactUsRemoteDataSource {
  Future<BaseResponse> contactUs({
    required String name,
    required String email,
    required String title,
    required String message,
  });
}

class ContactUsRemoteDataSourceImpl implements ContactUsRemoteDataSource {
  final ApiConsumer apiConsumer;

  ContactUsRemoteDataSourceImpl(this.apiConsumer);

  @override
  Future<BaseResponse> contactUs({
    required String name,
    required String email,
    required String title,
    required String message,
  }) async {
    Response response = await apiConsumer.post(EndPoints.contactUs, body: {
      AppStrings.name: name,
      AppStrings.email: email,
      AppStrings.title: title,
      AppStrings.message: message,
    });
    BaseResponse baseResponse = BaseResponse(statusCode: response.statusCode);
    final responseJson = Constants.decodeJson(response);
    baseResponse.status = responseJson['status'];

    if (response.statusCode == 200 && responseJson['status'] == true) {
      baseResponse.message = responseJson[AppStrings.message];
    } else {
      baseResponse.message = responseJson[AppStrings.message];
    }
    return baseResponse;
  }
}
