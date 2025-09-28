import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ballaghny/core/api/api_consumer.dart';
import 'package:ballaghny/core/api/base_response.dart';
import 'package:ballaghny/core/api/end_points.dart';
import 'package:ballaghny/core/utils/app_strings.dart';
import 'package:ballaghny/core/utils/constants.dart';
import 'package:ballaghny/features/auth/data/models/user_model.dart';

abstract class ProfileRemoteDataSource {
  Future<BaseResponse> getProfileData();

  Future<BaseResponse> updateProfileData({
    required String name,
    required String email,
    required String mobile,
    required String gender,
    String? image,
  });

  Future<BaseResponse> uploadImage({required File image});
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final ApiConsumer apiConsumer;

  ProfileRemoteDataSourceImpl(this.apiConsumer);

  @override
  Future<BaseResponse> getProfileData() async {
    Response response = await apiConsumer.get(EndPoints.profile);

    BaseResponse baseResponse = BaseResponse(statusCode: response.statusCode);
    final responseJson = Constants.decodeJson(response);
    baseResponse.status = responseJson['status'];
    if (response.statusCode == 200 && responseJson['status'] == true) {
      baseResponse.data = UserModel.fromJson(responseJson['data']);
      baseResponse.message = responseJson['message'];
    } else {
      baseResponse.message = responseJson.values.first.toString();
    }
    return baseResponse;
  }

  @override
  Future<BaseResponse> updateProfileData({
    required String name,
    required String email,
    required String mobile,
    required String gender,
    String? image,
  }) async {
    Response response = await apiConsumer.post(EndPoints.editProfile, body: {
      AppStrings.name: name,
      AppStrings.email: email,
      AppStrings.mobile: mobile,
      AppStrings.gender: gender,
      if (image != null) AppStrings.image: image,
    });
    BaseResponse baseResponse = BaseResponse(statusCode: response.statusCode);
    final responseJson = Constants.decodeJson(response);
    baseResponse.status = responseJson['status'];

    if (response.statusCode == 200 && responseJson['status'] == true) {
      baseResponse.data = UserModel.fromJson(responseJson['data']);
      baseResponse.message = responseJson[AppStrings.message];
    } else {
      baseResponse.message = responseJson[AppStrings.message];
    }
    return baseResponse;
  }

  @override
  Future<BaseResponse> uploadImage({required File image}) async {
    Response response = await apiConsumer
        .post(EndPoints.uploadImage, formDataIsEnabled: true, body: {
      'image': await MultipartFile.fromFile(
        image.path,
      )
    });

    BaseResponse baseResponse = BaseResponse(statusCode: response.statusCode);
    final responseJson = Constants.decodeJson(response);
    baseResponse.data = UserModel.fromJson(responseJson['data']);
    baseResponse.status = responseJson['status'];
    baseResponse.message = responseJson['message'];
    return baseResponse;
  }
}
