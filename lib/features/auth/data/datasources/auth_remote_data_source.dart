import 'package:dio/dio.dart';
import 'package:ballaghny/core/api/cache_helper.dart';
import 'package:ballaghny/features/auth/data/models/user_model.dart';
import '../../../../core/api/base_response.dart';
import '../../../../core/api/status_code.dart';
import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_points.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/constants.dart';

abstract class AuthRemoteDataSource {
  Future<BaseResponse> login({
    required String email,
    required String password,
    required String firebaseToken,
    required String deviceType,
  });

  //send token
  Future<BaseResponse> sendToken({
    required String firebaseToken,
    required String deviceType,
  });

  Future<BaseResponse> register({
    required String name,
    required String email,
    String? gender,
    required String password,
    required String phone,
    // required String firebaseToken,
    // required String deviceType,
  });

  Future<BaseResponse> logout({required String firebaseToken});
  Future<BaseResponse> deActivateAccount();

  // delete account
  Future<BaseResponse> deleteAccount();

  // socialAuth
  Future<BaseResponse> socialAuth({
    required String provider,
    required String socialToken,
  });
  //SendCodeToVerifyOrResetPassword
  Future<BaseResponse> forgotSendCode({
    required String mobile,
    // required String type,
  });
  Future<BaseResponse> verifyEmailCode({required String code});
  //will return token
  Future<BaseResponse> verifyPasswordCode({required String code});
  Future<BaseResponse> resetPasswordWithCode({
    required String mobile,
    required String code,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiConsumer apiConsumer;
  AuthRemoteDataSourceImpl({required this.apiConsumer});
  @override
  Future<BaseResponse> login({
    required String email,
    required String password,
    required String firebaseToken,
    required String deviceType,
  }) async {
    final response = await apiConsumer.post(
      EndPoints.login,
      body: {
        AppStrings.email: email,
        AppStrings.password: password,
        // AppStrings.mobileToken: firebaseToken,
        // AppStrings.deviceType: deviceType
      },
    );
    BaseResponse baseResponse = BaseResponse(statusCode: response.statusCode);
    final responseJson = Constants.decodeJson(response);
    baseResponse.status = responseJson['status'];
    if (response.statusCode == StatusCode.ok &&
        responseJson['status'] == true) {
      String accessToken = responseJson['data']['token'];
      accessToken =
          AppStrings.bearer +
          accessToken.replaceAll("[", '').replaceAll("]", '');
      UserModel userModel = UserModel.fromJson(responseJson['data']);
      userModel.accessToken = accessToken;
      baseResponse.data = userModel;
      CacheHelper.saveData(key: AppStrings.token, value: accessToken);
    } else if (response.statusCode == 422) {
      baseResponse.message = responseJson[AppStrings.checkForm];
    } else {
      baseResponse.message = responseJson[AppStrings.message];
    }
    return baseResponse;
  }

  @override
  Future<BaseResponse> register({
    required String name,
    required String email,
    String? gender,
    required String password,
    required String phone,
    // required String firebaseToken,
    // required String deviceType,
  }) async {
    Response response = await apiConsumer.post(
      EndPoints.register,
      body: {
        AppStrings.name: name,
        AppStrings.email: email,
        AppStrings.password: password,
        AppStrings.passwordConfirmation: password,
        AppStrings.gender: gender,
        // AppStrings.mobileToken: firebaseToken,
        // AppStrings.deviceType: deviceType,
        AppStrings.mobile: phone,
      },
    );
    BaseResponse baseResponse = BaseResponse(statusCode: response.statusCode);
    final responseJson = Constants.decodeJson(response);
    baseResponse.status = responseJson['status'];
    if (response.statusCode == StatusCode.ok &&
        responseJson['status'] == true) {
      String accessToken = responseJson['data']['token'];
      accessToken =
          AppStrings.bearer +
          accessToken.replaceAll("[", '').replaceAll("]", '');
      UserModel userModel = UserModel.fromJson(responseJson['data']);
      userModel.accessToken = accessToken;
      baseResponse.data = userModel;
      CacheHelper.saveData(key: AppStrings.token, value: accessToken);
      baseResponse.message = responseJson[AppStrings.message];
    } else if (response.statusCode == 422) {
      baseResponse.message = responseJson[AppStrings.checkForm];
    } else {
      baseResponse.message = responseJson[AppStrings.message];
    }
    return baseResponse;
  }

  @override
  Future<BaseResponse> logout({required String firebaseToken}) async {
    final response = await apiConsumer.post(
      EndPoints.logout,
      body: {AppStrings.mobileToken: firebaseToken},
    );
    BaseResponse baseResponse = BaseResponse(statusCode: response.statusCode);
    final responseJson = Constants.decodeJson(response);
    baseResponse.message = responseJson[AppStrings.message];

    return baseResponse;
  }

  @override
  Future<BaseResponse> deActivateAccount() async {
    final response = await apiConsumer.post(EndPoints.deActivateAccount);
    BaseResponse baseResponse = BaseResponse(statusCode: response.statusCode);
    final responseJson = Constants.decodeJson(response);
    if (response.statusCode == StatusCode.ok) {
      baseResponse.message = responseJson[AppStrings.message];
    } else if (response.statusCode == 422) {
      baseResponse.message = responseJson[AppStrings.checkForm];
    } else {
      baseResponse.message = responseJson[AppStrings.message];
    }
    return baseResponse;
  }

  @override
  Future<BaseResponse> socialAuth({
    required String provider,
    required String socialToken,
  }) async {
    final response = await apiConsumer.post(
      EndPoints.socialAuth,
      body: {
        AppStrings.provider: provider,
        AppStrings.socialToken: socialToken,
      },
    );
    BaseResponse baseResponse = BaseResponse(statusCode: response.statusCode);
    final responseJson = Constants.decodeJson(response);
    if (response.statusCode == StatusCode.ok) {
      String accessToken = response.headers[AppStrings.token].toString();
      // String userId = response.headers[AppStrings.token].toString();
      accessToken =
          AppStrings.bearer +
          accessToken.replaceAll("[", '').replaceAll("]", '');
      UserModel userModel = UserModel.fromJson(responseJson);
      userModel.accessToken = accessToken;
      baseResponse.data = userModel;
      CacheHelper.saveData(key: AppStrings.token, value: accessToken);
    } else if (response.statusCode == 422) {
      baseResponse.message = responseJson[AppStrings.checkForm];
    } else {
      baseResponse.message = responseJson[AppStrings.message];
    }
    return baseResponse;
  }

  @override
  Future<BaseResponse> resetPasswordWithCode({
    required String mobile,
    required String code,
    required String password,
  }) async {
    final response = await apiConsumer.post(
      EndPoints.resetPasswordWithCode,
      body: {
        AppStrings.mobile: mobile,
        'activation_token': code,
        AppStrings.password: password,
        AppStrings.passwordConfirmation: password,
      },
    );
    BaseResponse baseResponse = BaseResponse(statusCode: response.statusCode);
    final responseJson = Constants.decodeJson(response);
    if (response.statusCode == StatusCode.ok) {
      baseResponse.message = responseJson[AppStrings.message];
    } else if (response.statusCode == StatusCode.unprocessableEntity) {
      baseResponse.message = responseJson[AppStrings.token][0];
      baseResponse.message = responseJson[AppStrings.password][0];
    } else {
      baseResponse.message = responseJson[AppStrings.message];
    }
    return baseResponse;
  }

  @override
  Future<BaseResponse> forgotSendCode({required String mobile}) async {
    Response response = await apiConsumer.post(
      EndPoints.forgotSendCode,
      body: {
        AppStrings.mobile: mobile,
        // AppStrings.type: type
      },
    ); //type: verify or reset_password
    BaseResponse baseResponse = BaseResponse(statusCode: response.statusCode);
    final responseJson = Constants.decodeJson(response);
    if (response.statusCode == StatusCode.ok) {
      baseResponse.message = responseJson[AppStrings.message];
    } else {
      baseResponse.message = responseJson[AppStrings.message];
    }
    return baseResponse;
  }

  @override
  Future<BaseResponse> verifyEmailCode({required String code}) async {
    Response response = await apiConsumer.post(
      '${EndPoints.verifyEmailCode}/$code',
    );
    BaseResponse baseResponse = BaseResponse(statusCode: response.statusCode);
    final responseJson = Constants.decodeJson(response);
    baseResponse.message = responseJson[AppStrings.message];

    return baseResponse;
  }

  @override
  Future<BaseResponse> verifyPasswordCode({required String code}) async {
    Response response = await apiConsumer.post(
      '${EndPoints.verifyPasswordCode}/$code',
    );
    BaseResponse baseResponse = BaseResponse(statusCode: response.statusCode);
    final responseJson = Constants.decodeJson(response);
    baseResponse.message = responseJson[AppStrings.message];
    if (response.statusCode == StatusCode.unprocessableEntity) {
      baseResponse.message = responseJson[AppStrings.token][0];
    }
    if (responseJson[AppStrings.data] != null) {
      baseResponse.data = responseJson[AppStrings.data]['token'];
    }

    return baseResponse;
  }

  @override
  Future<BaseResponse> sendToken({
    required String firebaseToken,
    required String deviceType,
  }) async {
    Response response = await apiConsumer.post(
      EndPoints.sendToken,
      body: {AppStrings.token: firebaseToken, AppStrings.platform: deviceType},
    );
    BaseResponse baseResponse = BaseResponse(statusCode: response.statusCode);
    final responseJson = Constants.decodeJson(response);
    baseResponse.message = responseJson[AppStrings.message];
    return baseResponse;
  }

  @override
  Future<BaseResponse> deleteAccount() async {
    final response = await apiConsumer.post(EndPoints.deleteAccount);
    BaseResponse baseResponse = BaseResponse(statusCode: response.statusCode);
    final responseJson = Constants.decodeJson(response);
    baseResponse.status = responseJson['status'];
    if (response.statusCode == StatusCode.ok) {
      baseResponse.message = responseJson[AppStrings.message];
    } else if (response.statusCode == 422) {
      baseResponse.message = responseJson[AppStrings.checkForm];
    } else {
      baseResponse.message = responseJson[AppStrings.message];
    }
    return baseResponse;
  }
}
