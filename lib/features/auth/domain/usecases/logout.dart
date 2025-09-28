import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:ballaghny/core/api/base_response.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';

class Logout implements UseCase<BaseResponse, LogoutParams> {
  final AuthRepository authRepository;
  Logout({required this.authRepository});

  @override
  Future<Either<Failure, BaseResponse>> call(LogoutParams params) async =>
      await authRepository.logout(firebaseToken: params.firebaseToken);
}

class LogoutParams extends Equatable {
  final String firebaseToken;

  const LogoutParams({
    required this.firebaseToken,
  });

  @override
  List<Object> get props => [firebaseToken];
}
