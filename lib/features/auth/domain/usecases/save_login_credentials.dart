import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:ballaghny/features/auth/data/models/user_model.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';

class SaveLoginCredentials
    implements UseCase<bool, SaveLoginCredentialsParams> {
  final AuthRepository authRepository;
  SaveLoginCredentials({required this.authRepository});

  @override
  Future<Either<Failure, bool>> call(SaveLoginCredentialsParams params) async =>
      await authRepository.saveLoginCredentials(user: params.user);
}

class SaveLoginCredentialsParams extends Equatable {
  final UserModel user;

  const SaveLoginCredentialsParams({
    required this.user,
  });

  @override
  List<Object> get props => [
        user,
      ];
}
