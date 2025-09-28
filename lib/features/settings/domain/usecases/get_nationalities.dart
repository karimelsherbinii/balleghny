import 'package:ballaghny/core/api/base_response.dart';
import 'package:dartz/dartz.dart';
import 'package:ballaghny/core/error/failures.dart';
import 'package:ballaghny/core/usecases/usecase.dart';
import 'package:ballaghny/features/settings/domain/repositories/settings_repository.dart';

class GetNationalities implements UseCase<BaseResponse, NoParams> {
  final SettingsRepository repository;
  GetNationalities({required this.repository});
  @override
  Future<Either<Failure, BaseResponse>> call(NoParams params) async {
    return await repository.getNationalities();
  }
}
