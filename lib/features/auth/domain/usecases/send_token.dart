import 'package:ballaghny/core/api/base_response.dart';
import 'package:ballaghny/core/error/failures.dart';
import 'package:ballaghny/core/usecases/usecase.dart';
import 'package:ballaghny/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class SendToken extends UseCase<BaseResponse, SendTokenParams> {
  final AuthRepository repository;

  SendToken(this.repository);

  @override
  Future<Either<Failure, BaseResponse>> call(SendTokenParams params) async {
    return await repository.sendToken(token: params.token, deviceType: params.deviceType);
  }
}

class SendTokenParams extends Equatable {
  final String token;
  final String deviceType;

  const SendTokenParams({required this.token, required this.deviceType});

  @override
  List<Object> get props => [token, deviceType];
}
