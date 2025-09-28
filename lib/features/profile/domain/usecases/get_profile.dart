import 'package:dartz/dartz.dart';
import 'package:ballaghny/core/api/base_response.dart';
import 'package:ballaghny/core/error/failures.dart';
import 'package:ballaghny/core/usecases/usecase.dart';
import 'package:ballaghny/features/profile/domain/repositories/profile_repository.dart';

class GetProfileData extends UseCase<BaseResponse, NoParams> {
  final ProfileRepository repository;
  GetProfileData(this.repository);
  @override
  Future<Either<Failure, BaseResponse>> call(NoParams params) {
    return repository.getProfileData();
  }
}
