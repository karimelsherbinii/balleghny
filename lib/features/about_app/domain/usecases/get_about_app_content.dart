import 'package:dartz/dartz.dart';
import 'package:ballaghny/features/about_app/domain/repositories/about_app_repository.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';

class GetAboutAppContent implements UseCase<String, NoParams> {
  final AboutAppRepository aboutAppRepository;
  GetAboutAppContent({required this.aboutAppRepository});

  @override
  Future<Either<Failure, String>> call(NoParams params) async =>
      await aboutAppRepository.getContentOfAboutApp();
}
