import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/api/base_response.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';

class ResetPassword implements UseCase<BaseResponse, ResetPasswordParams> {
  final AuthRepository authRepository;
  ResetPassword({required this.authRepository});

  @override
  Future<Either<Failure, BaseResponse>> call(
          ResetPasswordParams params) async =>
      await authRepository.resetPasswordWithCode(
        code: params.code,
        mobile: params.mobile,
        password: params.password,
      );
}

class ResetPasswordParams extends Equatable {
  final String code;
  final String mobile;
  final String password;

  const ResetPasswordParams({
    required this.code,
    required this.mobile,
    required this.password,
  });

  @override
  List<Object> get props => [code, mobile, password];
}
