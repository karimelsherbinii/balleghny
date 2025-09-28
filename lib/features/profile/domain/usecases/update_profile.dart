import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:ballaghny/core/api/base_response.dart';
import 'package:ballaghny/core/error/failures.dart';
import 'package:ballaghny/core/usecases/usecase.dart';
import 'package:ballaghny/features/profile/domain/repositories/profile_repository.dart';

class UpdateProfileData extends UseCase<BaseResponse, UpdateProfileDataParams> {
  final ProfileRepository repository;
  UpdateProfileData(this.repository);
  @override
  Future<Either<Failure, BaseResponse>> call(UpdateProfileDataParams params) {
    return repository.updateProfileData(
      name: params.name,
      email: params.email,
      mobile: params.mobile,
      gender: params.gender,
      image: params.image,
    );
  }
}

class UpdateProfileDataParams extends Equatable {
  final String name;
  final String email;
  final String mobile;
  final String gender;
  final String? image;
  const UpdateProfileDataParams({
    required this.name,
    required this.email,
    required this.mobile,
    required this.gender,
    required this.image,
  });
  @override
  List<Object?> get props => [
        name,
        email,
        mobile,
        gender,
        image,
      ];
}
