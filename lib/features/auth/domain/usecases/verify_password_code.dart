import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/api/base_response.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';

class VerifyPasswordCode
    implements UseCase<BaseResponse, VerifyPasswordCodeParams> {
  final AuthRepository authRepository;
  VerifyPasswordCode({required this.authRepository});

  @override
  Future<Either<Failure, BaseResponse>> call(
          VerifyPasswordCodeParams params) async =>
      await authRepository.verifyPasswordCode(
        code: params.code,
      );
}

class VerifyPasswordCodeParams extends Equatable {
  final String code;

  const VerifyPasswordCodeParams({
    required this.code,
  });

  @override
  List<Object> get props => [code];
}
