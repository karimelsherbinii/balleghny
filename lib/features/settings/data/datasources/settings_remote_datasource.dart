import 'package:ballaghny/core/api/api_consumer.dart';
import 'package:ballaghny/core/api/base_response.dart';
import 'package:ballaghny/core/api/end_points.dart';
import 'package:ballaghny/core/utils/constants.dart';
import 'package:ballaghny/features/settings/data/models/dynamic_model.dart';

abstract class SettingsRemoteDataSource {
  Future<BaseResponse> getLanguages();
  Future<BaseResponse> getCountries();
  Future<BaseResponse> getReligions();
  Future<BaseResponse> getNationalities();
}

class SettingsRemoteDataSourceImplementation
    implements SettingsRemoteDataSource {
  final ApiConsumer apiConsumer;
  SettingsRemoteDataSourceImplementation({required this.apiConsumer});

  @override
  Future<BaseResponse> getCountries() async {
    final response = await apiConsumer.get(EndPoints.getCountries);
    BaseResponse baseResponse = BaseResponse(statusCode: response.statusCode);
    var jsonResponse = Constants.decodeJson(response);
    Iterable iterable = jsonResponse['data'];
    baseResponse.status = jsonResponse['status'];
    baseResponse.message = jsonResponse['message'];
    // if (response.statusCode == 200 && jsonResponse['status'] == 'true') {
      baseResponse.data =
          iterable.map((e) => DynamicModel.fromJson(e)).toList();
    // } else {
    //   baseResponse.message = jsonResponse['error'];
    // }
    return baseResponse;
  }

  @override
  Future<BaseResponse> getLanguages() async {
    final response = await apiConsumer.get(EndPoints.getLanguages);
    BaseResponse baseResponse = BaseResponse(statusCode: response.statusCode);
    var jsonResponse = Constants.decodeJson(response);
    Iterable iterable = jsonResponse['data'];
    baseResponse.status = jsonResponse['status'];
    baseResponse.message = jsonResponse['message'];
    // if (response.statusCode == 200 && jsonResponse['status'] == 'true') {
    baseResponse.data = iterable.map((e) => DynamicModel.fromJson(e)).toList();
    // } else {
    //   baseResponse.message = jsonResponse['error'];
    // }
    return baseResponse;
  }

  @override
  Future<BaseResponse> getNationalities() async {
    final response = await apiConsumer.get(EndPoints.getNationalities);
    BaseResponse baseResponse = BaseResponse(statusCode: response.statusCode);
    var jsonResponse = Constants.decodeJson(response);
    Iterable iterable = jsonResponse['data'];
    baseResponse.status = jsonResponse['status'];
    baseResponse.message = jsonResponse['message'];
    // if (response.statusCode == 200 && jsonResponse['status'] == 'true') {
    baseResponse.data = iterable.map((e) => DynamicModel.fromJson(e)).toList();
    // } else {
    //   baseResponse.message = jsonResponse['error'];
    // }
    return baseResponse;
  }

  @override
  Future<BaseResponse> getReligions() async {
    final response = await apiConsumer.get(EndPoints.getReligions);
    BaseResponse baseResponse = BaseResponse(statusCode: response.statusCode);
    var jsonResponse = Constants.decodeJson(response);
    Iterable iterable = jsonResponse['data'];
    baseResponse.status = jsonResponse['status'];
    baseResponse.message = jsonResponse['message'];
    // if (response.statusCode == 200 && jsonResponse['status'] == 'true') {
    baseResponse.data = iterable.map((e) => DynamicModel.fromJson(e)).toList();
    // } else {
    //   baseResponse.message = jsonResponse['error'];
    // }
    return baseResponse;
  }
}
