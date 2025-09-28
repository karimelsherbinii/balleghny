import 'dart:io';

import 'package:ballaghny/core/api/base_response.dart';
import 'package:ballaghny/core/error/failures.dart';
import 'package:ballaghny/core/usecases/usecase.dart';
import 'package:ballaghny/features/profile/domain/repositories/profile_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class UploadImage extends UseCase<BaseResponse, UploadImageParams> {
  final ProfileRepository repository;

  UploadImage(this.repository);

  @override
  Future<Either<Failure, BaseResponse>> call(UploadImageParams params) async {
    return await repository.uploadImage(
      image: params.image,
    );
  }
}

class UploadImageParams extends Equatable {
  final File image;

  const UploadImageParams({required this.image});

  @override
  List<Object> get props => [image];
}