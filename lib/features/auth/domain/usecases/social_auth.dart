import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:ballaghny/core/api/base_response.dart';
import 'package:ballaghny/core/error/failures.dart';
import 'package:ballaghny/core/usecases/usecase.dart';
import 'package:ballaghny/features/auth/domain/repositories/auth_repository.dart';

class SocialAuth extends UseCase<BaseResponse, SocialAuthParams> {
  final AuthRepository authRepository;

  SocialAuth({required this.authRepository});

  @override
  Future<Either<Failure, BaseResponse>> call(SocialAuthParams params) async =>
      await authRepository.socialAuth(
        provider: params.provider,
        socialToken: params.socialToken,
      );
}

class SocialAuthParams extends Equatable {
  final String provider;
  final String socialToken;

  const SocialAuthParams({
    required this.provider,
    required this.socialToken,
  });

  @override
  List<Object> get props => [provider, socialToken];
}
