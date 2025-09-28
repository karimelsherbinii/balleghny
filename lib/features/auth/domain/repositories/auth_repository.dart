import 'package:dartz/dartz.dart';
import 'package:ballaghny/features/auth/data/models/user_model.dart';
import '../../../../core/api/base_response.dart';
import '../../../../core/error/failures.dart';

abstract class AuthRepository {
  Future<Either<Failure, BaseResponse>> login({
    required String email,
    required String password,
    required String deviceType,
    required String firebaseToken,
  });

  Future<Either<Failure, BaseResponse>> register({
    required String name,
    required String email,
    String? gender,
    required String password,
    required String phone,
    // required String firebaseToken,
    // required String deviceType,
  });
  Future<Either<Failure, bool>> saveLoginCredentials({required UserModel user});
  Future<Either<Failure, UserModel?>> getSavedLoginCredentials();
  Future<Either<Failure, bool>> logoutLocally();
  Future<Either<Failure, BaseResponse>> logout({required String firebaseToken});
  Future<Either<Failure, BaseResponse>> deActivateAccount();
  Future<Either<Failure, BaseResponse>> deleteAccount();

  // socialAuth
  Future<Either<Failure, BaseResponse>> socialAuth({
    required String provider,
    required String socialToken,
  });

  Future<Either<Failure, BaseResponse>> forgorSendCode({
    required String mobile,
  });
  Future<Either<Failure, BaseResponse>> verifyEmailCode({required String code});
  Future<Either<Failure, BaseResponse>> verifyPasswordCode({
    required String code,
  });
  Future<Either<Failure, BaseResponse>> resetPasswordWithCode({
    required String code,
    required String mobile,
    required String password,
  });

  Future<Either<Failure, BaseResponse>> sendToken({
    required String token,
    required String deviceType,
  });
}
