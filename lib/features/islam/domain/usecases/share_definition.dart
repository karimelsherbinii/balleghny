import 'package:ballaghny/core/api/base_response.dart';
import 'package:ballaghny/core/error/failures.dart';
import 'package:ballaghny/core/usecases/usecase.dart';
import 'package:ballaghny/features/islam/domain/repositories/islam_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class ShareDefinition extends UseCase<BaseResponse, ShareDefinitionParams> {
  final IslamRepository repository;

  ShareDefinition(this.repository);

  @override
  Future<Either<Failure, BaseResponse>> call(ShareDefinitionParams params) async {
    return await repository.share(
        id: params.id,
    );
  }

}

class ShareDefinitionParams extends Equatable {
  final int id;

  const ShareDefinitionParams({
    required this.id,
  });

  @override
  List<Object> get props => [
    id,
  ];
}