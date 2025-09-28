import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';

abstract class AboutAppRepository {
  Future<Either<Failure, String>> getContentOfAboutApp();
}
