import 'package:dartz/dartz.dart';
import 'package:ballaghny/core/error/failures.dart';
import 'package:ballaghny/core/usecases/usecase.dart';

import '../repositories/settings_repository.dart';

class ChangeDarkModeUseCase implements UseCase<bool, bool> {
  final SettingsRepository darkModeRepository;
  ChangeDarkModeUseCase({required this.darkModeRepository});
  @override
  Future<Either<Failure, bool>> call(bool isDark) async {
    return await darkModeRepository.changeDarkMode(isDark: isDark);
  }
}
