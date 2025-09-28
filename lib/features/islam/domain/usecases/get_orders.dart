import 'package:ballaghny/core/api/base_response.dart';
import 'package:ballaghny/core/error/failures.dart';
import 'package:ballaghny/core/usecases/usecase.dart';
import 'package:ballaghny/features/islam/domain/repositories/islam_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetOrders extends UseCase<BaseResponse, GetOrdersParams> {
  final IslamRepository repository;

  GetOrders(this.repository);

  @override
  Future<Either<Failure, BaseResponse>> call(GetOrdersParams params) async {
    return await repository.getOrders(
      page:  params.page,
    );
  }
}

class GetOrdersParams extends Equatable {
  final int page;

  const GetOrdersParams({required this.page});
  @override
  List<Object> get props => [page];
}