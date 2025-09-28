import 'package:dartz/dartz.dart';
import 'package:ballaghny/features/auth/data/models/user_model.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';

class GetSavedLoginCredentials implements UseCase<UserModel?, NoParams> {
  final AuthRepository authRepository;
  GetSavedLoginCredentials({required this.authRepository});

  @override
  Future<Either<Failure, UserModel?>> call(NoParams noParams) async =>
      await authRepository.getSavedLoginCredentials();
}
