import 'package:ballaghny/core/api/base_response.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

abstract class SettingsRepository {
  Future<Either<Failure, bool>> changeDarkMode({required bool isDark});
  Future<Either<Failure, bool>> savedDarkMode();
  //remote
  Future<Either<Failure, BaseResponse>> getLanguages();
  Future<Either<Failure, BaseResponse>> getCountries();
  Future<Either<Failure, BaseResponse>> getNationalities();
  Future<Either<Failure, BaseResponse>> getReligions();
}
