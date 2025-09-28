import 'package:ballaghny/core/api/base_response.dart';
import 'package:ballaghny/core/error/failures.dart';
import 'package:ballaghny/core/usecases/usecase.dart';
import 'package:ballaghny/features/islam/domain/repositories/islam_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class InviteToIslam extends UseCase<BaseResponse, InviteToIslamParams> {
  final IslamRepository repository;

  InviteToIslam(this.repository);

  @override
  Future<Either<Failure, BaseResponse>> call(InviteToIslamParams params) async {
    return await repository.inviteToIslam(
        name: params.name,
        email: params.email,
        phoneNumber: params.phoneNumber,
        gender: params.gender,
        country: params.country,
        city: params.city,
        language: params.language,
        religion: params.religion,
        socialMediaAccount: params.socialMediaAccount);
  }
}

class InviteToIslamParams extends Equatable {
  final String name;
  final String? email;
  final String? phoneNumber;
  final String? gender;
  final String? country;
  final String? city;
  final String? language;
  final String? religion;
  final String? socialMediaAccount;

  const InviteToIslamParams(
      {required this.name,
      this.email,
      this.phoneNumber,
      this.gender,
      this.country,
      this.city,
      this.language,
      this.religion,
      this.socialMediaAccount});

  @override
  List<Object> get props => [
        name,
        email ?? '',
        phoneNumber ?? '',
        gender ?? '',
        country ?? '',
        city ?? '',
        language ?? '',
        religion ?? '',
        socialMediaAccount ?? ''
      ];
}
