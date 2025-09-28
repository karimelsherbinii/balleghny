import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/api/base_response.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';

class Register implements UseCase<BaseResponse, RegisterParams> {
  final AuthRepository authRepository;
  Register({required this.authRepository});

  @override
  Future<Either<Failure, BaseResponse>> call(RegisterParams params) async =>
      await authRepository.register(
        name: params.name,
        email: params.email,
        password: params.password,
        gender: params.gender,
        phone: params.phone,
      );
}

class RegisterParams extends Equatable {
  final String name;
  final String email;
  final String password;
  final String gender;
  final String phone;
  // final String firebaseToken;
  // final String deviceType;

  const RegisterParams({
    required this.name,
    required this.email,
    required this.password,
    required this.gender,
    required this.phone,
  });

  @override
  List<Object> get props => [
        name,
        email,
        password,
        gender,
        phone,
      ];
}
