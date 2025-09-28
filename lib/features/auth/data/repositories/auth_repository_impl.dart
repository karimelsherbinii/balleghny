import 'package:dartz/dartz.dart';
import 'package:ballaghny/features/auth/data/models/user_model.dart';
import '../../../../core/api/base_response.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/utils/app_strings.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_data_source.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final AuthLocalDataSource authLocalDataSource;
  AuthRepositoryImpl({
    required this.authRemoteDataSource,
    required this.authLocalDataSource,
  });
  @override
  Future<Either<Failure, BaseResponse>> login({
    required String email,
    required String password,
    required String deviceType,
    required String firebaseToken,
  }) async {
    try {
      final response = await authRemoteDataSource.login(
        email: email,
        password: password,
        deviceType: deviceType,
        firebaseToken: firebaseToken,
      );
      return Right(response);
    } on ServerException catch (exception) {
      return Left(ServerFailure(message: exception.message!));
    }
  }

  @override
  Future<Either<Failure, UserModel?>> getSavedLoginCredentials() async {
    try {
      final response = await authLocalDataSource.getSavedLoginCredentials();
      return Right(response);
    } on CacheException {
      return const Left(CacheFailure(message: AppStrings.cacheFailure));
    }
  }

  @override
  Future<Either<Failure, bool>> saveLoginCredentials({
    required UserModel user,
  }) async {
    try {
      final response = await authLocalDataSource.saveLoginCredentials(
        userModel: user,
      );
      return Right(response);
    } on CacheException {
      return const Left(CacheFailure(message: AppStrings.cacheFailure));
    }
  }

  @override
  Future<Either<Failure, BaseResponse>> register({
    required String name,
    required String email,
    String? gender,
    required String password,
    required String phone,
    // required String firebaseToken,
    // required String deviceType,
  }) async {
    try {
      final response = await authRemoteDataSource.register(
        name: name,
        email: email,
        gender: gender,
        password: password,
        phone: phone,
        // firebaseToken: firebaseToken,
        // deviceType: deviceType,
      );
      return Right(response);
    } on ServerException catch (exception) {
      return Left(ServerFailure(message: exception.message!));
    }
  }

  @override
  Future<Either<Failure, bool>> logoutLocally() async {
    try {
      final response = await authLocalDataSource.logoutLocally();
      return Right(response);
    } on ServerException catch (exception) {
      return Left(ServerFailure(message: exception.message!));
    }
  }

  @override
  Future<Either<Failure, BaseResponse>> logout({
    required String firebaseToken,
  }) async {
    try {
      final response = await authRemoteDataSource.logout(
        firebaseToken: firebaseToken,
      );

      return Right(response);
    } on ServerException catch (exception) {
      return Left(ServerFailure(message: exception.message!));
    }
  }

  @override
  Future<Either<Failure, BaseResponse>> deActivateAccount() async {
    try {
      final response = await authRemoteDataSource.deActivateAccount();
      return Right(response);
    } on ServerException catch (exception) {
      return Left(ServerFailure(message: exception.message!));
    }
  }

  @override
  Future<Either<Failure, BaseResponse>> deleteAccount() async {
    try {
      final response = await authRemoteDataSource.deleteAccount();
      return Right(response);
    } on ServerException catch (exception) {
      return Left(ServerFailure(message: exception.message!));
    }
  }

  @override
  Future<Either<Failure, BaseResponse>> socialAuth({
    required String provider,
    required String socialToken,
  }) async {
    try {
      final response = await authRemoteDataSource.socialAuth(
        provider: provider,
        socialToken: socialToken,
      );
      return Right(response);
    } on ServerException catch (exception) {
      return Left(ServerFailure(message: exception.message!));
    }
  }

  @override
  Future<Either<Failure, BaseResponse>> resetPasswordWithCode({
    required String code,
    required String mobile,
    required String password,
  }) async {
    try {
      final response = await authRemoteDataSource.resetPasswordWithCode(
        code: code,
        mobile: mobile,
        password: password,
      );
      return Right(response);
    } on ServerException catch (exception) {
      return Left(ServerFailure(message: exception.message!));
    } on Exception catch (exception) {
      return Left(ServerFailure(message: exception.toString()));
    }
  }

  @override
  Future<Either<Failure, BaseResponse>> forgorSendCode({
    required String mobile,
  }) async {
    try {
      final response = await authRemoteDataSource.forgotSendCode(
        mobile: mobile,
      );
      return Right(response);
    } on ServerException catch (exception) {
      return Left(ServerFailure(message: exception.message!));
    }
  }

  @override
  Future<Either<Failure, BaseResponse>> verifyEmailCode({
    required String code,
  }) async {
    try {
      final response = await authRemoteDataSource.verifyEmailCode(code: code);
      return Right(response);
    } on ServerException catch (exception) {
      return Left(ServerFailure(message: exception.message!));
    }
  }

  @override
  Future<Either<Failure, BaseResponse>> verifyPasswordCode({
    required String code,
  }) async {
    try {
      final response = await authRemoteDataSource.verifyPasswordCode(
        code: code,
      );
      return Right(response);
    } on ServerException catch (exception) {
      return Left(ServerFailure(message: exception.message!));
    }
  }

  @override
  Future<Either<Failure, BaseResponse>> sendToken({
    required String token,
    required String deviceType,
  }) async {
    try {
      final response = await authRemoteDataSource.sendToken(
        firebaseToken: token,
        deviceType: deviceType,
      );
      return Right(response);
    } on ServerException catch (exception) {
      return Left(ServerFailure(message: exception.message!));
    }
  }
}
