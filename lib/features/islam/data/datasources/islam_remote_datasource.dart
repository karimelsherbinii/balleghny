import 'dart:developer';

import 'package:ballaghny/core/api/api_consumer.dart';
import 'package:ballaghny/core/api/base_response.dart';
import 'package:ballaghny/core/api/end_points.dart';
import 'package:ballaghny/core/utils/constants.dart';
import 'package:ballaghny/features/islam/data/models/difination/definitio_model.dart';
import 'package:ballaghny/features/islam/data/models/order_model.dart';

abstract class IslamRemoteDataSource {
  Future<BaseResponse> getIntroductions({
    required String search,
  });
  //get orders
  Future<BaseResponse> getOrders({
    required int page,
  });
  Future<BaseResponse> inviteToIslam({
    required String name,
    String? email,
    String? phoneNumber,
    String? gender,
    String? country,
    String? city,
    String? language,
    String? religion,
    String? socialMediaAccount,
  });

  Future<BaseResponse> share({
    required int id,
  });
}

class IslamRemoteDataSourceImpl implements IslamRemoteDataSource {
  final ApiConsumer apiConsumer;
  IslamRemoteDataSourceImpl({required this.apiConsumer});
  @override
  Future<BaseResponse> getIntroductions({
    required String search,
  }) async {
    final response =
        await apiConsumer.get(EndPoints.introductions, queryParameters: {
      'search': search,
    });
    BaseResponse baseResponse = BaseResponse(statusCode: response.statusCode);
    var jsonResponse = Constants.decodeJson(response);
    Iterable iterable = jsonResponse['data'];
    baseResponse.status = jsonResponse['status'];
    baseResponse.message = jsonResponse['message'];
    // if (response.statusCode == 200 && jsonResponse['status'] == 'true') {
    log('success data: $iterable');
    baseResponse.data =
        iterable.map((e) => DefinitionModel.fromJson(e)).toList();
    // } else {
    baseResponse.message = jsonResponse['error'];
    // }
    return baseResponse;
  }

  @override
  Future<BaseResponse> inviteToIslam({
    required String name,
    String? email,
    String? phoneNumber,
    String? gender,
    String? country,
    String? city,
    String? language,
    String? religion,
    String? socialMediaAccount,
  }) async {
    final response = await apiConsumer.post(EndPoints.invitations, body: {
      'first_name': name,
      'mobile': phoneNumber,
      'email': email,
      'language_id': language,
      'religion_id': religion,
      'gender': gender,
      'country_id': country,
      'social_media_account': socialMediaAccount,
    });

    BaseResponse baseResponse = BaseResponse(statusCode: response.statusCode);
    var jsonResponse = Constants.decodeJson(response);
    baseResponse.status = jsonResponse['status'];
    baseResponse.message = jsonResponse['message'];
    if (response.statusCode == 200 && jsonResponse['status'] == 'true') {
      baseResponse.data = jsonResponse['data'];
    } else {
      baseResponse.message = jsonResponse['message'];
    }

    return baseResponse;
  }

  @override
  Future<BaseResponse> getOrders({
    required int page,
  }) async {
    final response = await apiConsumer.get(EndPoints.orders, queryParameters: {
      'page': page,
      'per_page': Constants.fetchLimit,
    });
    BaseResponse baseResponse = BaseResponse(statusCode: response.statusCode);
    var jsonResponse = Constants.decodeJson(response);
    Iterable iterable = jsonResponse['data']['invitations'];
    baseResponse.status = jsonResponse['status'];
    baseResponse.message = jsonResponse['message'];
    baseResponse.lastPage = jsonResponse['data']['pages'];
    baseResponse.currentPage = jsonResponse['data']['current_page'];
    log('success data: $iterable');
    baseResponse.data = iterable.map((e) => OrderModel.fromJson(e)).toList();

    return baseResponse;
  }

  @override
  Future<BaseResponse> share({required int id}) async {
    final response = await apiConsumer.post(
      '${EndPoints.share}/$id',
    );

    BaseResponse baseResponse = BaseResponse(statusCode: response.statusCode);
    var jsonResponse = Constants.decodeJson(response);
    baseResponse.status = jsonResponse['status'];
    baseResponse.message = jsonResponse['message'];
    if (response.statusCode == 200 && jsonResponse['status'] == 'true') {
      baseResponse.data = jsonResponse['data'];
    } else {
      baseResponse.message = jsonResponse['message'];
    }

    return baseResponse;
  }
}
