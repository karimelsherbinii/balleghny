import 'package:ballaghny/core/api/base_response.dart';
import 'package:ballaghny/core/error/failures.dart';
import 'package:ballaghny/core/usecases/usecase.dart';
import 'package:ballaghny/features/islam/domain/repositories/islam_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetIntroductions extends UseCase<BaseResponse, GetIntroductionsParams> {
  final IslamRepository repository;

  GetIntroductions(this.repository);

  @override
  Future<Either<Failure, BaseResponse>> call(GetIntroductionsParams params) async {
    return await repository.getIntroductions(
      search:  params.search,
    );
  }
}


class GetIntroductionsParams extends Equatable {
  final String search;

  const GetIntroductionsParams({required this.search});

  @override
  List<Object> get props => [search];
}