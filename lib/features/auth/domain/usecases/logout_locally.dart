import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';

class LogoutLoacally implements UseCase<bool, NoParams> {
  final AuthRepository authRepository;
  LogoutLoacally({required this.authRepository});

  @override
  Future<Either<Failure, bool>> call(NoParams params) async =>
      await authRepository.logoutLocally();
}
