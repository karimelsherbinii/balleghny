import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/api/base_response.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';

class VerifyEmailCode implements UseCase<BaseResponse, VerifyEmailCodeParams> {
  final AuthRepository authRepository;
  VerifyEmailCode({required this.authRepository});

  @override
  Future<Either<Failure, BaseResponse>> call(
          VerifyEmailCodeParams params) async =>
      await authRepository.verifyEmailCode(
        code: params.code,
      );
}

class VerifyEmailCodeParams extends Equatable {
  final String code;

  const VerifyEmailCodeParams({
    required this.code,
  });

  @override
  List<Object> get props => [code];
}
