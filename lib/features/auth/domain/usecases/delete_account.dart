import 'package:dartz/dartz.dart';
import 'package:ballaghny/core/api/base_response.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';

class DeleteAccount extends UseCase<BaseResponse, NoParams> {
  final AuthRepository repository;

  DeleteAccount({required this.repository});

  @override
  Future<Either<Failure, BaseResponse>> call(NoParams params) async {
    return await repository.deleteAccount();
  }
}
