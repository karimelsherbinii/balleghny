import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/api/base_response.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';

class SendCode implements UseCase<BaseResponse, SendCodeParams> {
  final AuthRepository authRepository;
  SendCode({required this.authRepository});

  @override
  Future<Either<Failure, BaseResponse>> call(SendCodeParams params) async =>
      await authRepository.forgorSendCode(
        mobile: params.mobile,
      );
}

class SendCodeParams extends Equatable {
  final String mobile;

  const SendCodeParams({required this.mobile});

  @override
  List<Object> get props => [mobile];
}
