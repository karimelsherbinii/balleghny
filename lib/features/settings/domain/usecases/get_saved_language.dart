import 'package:dartz/dartz.dart';
import 'package:ballaghny/core/error/failures.dart';
import 'package:ballaghny/core/usecases/usecase.dart';
import 'package:ballaghny/features/settings/domain/repositories/settings_repository.dart';

class GetSavedDarkModeUseCase implements UseCase<bool, NoParams> {
  final SettingsRepository darkModeRepository;
  GetSavedDarkModeUseCase({required this.darkModeRepository});
  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await darkModeRepository.savedDarkMode();
  }
}
