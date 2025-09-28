import 'package:ballaghny/features/contact_us/domain/repositories/contact_us_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:ballaghny/core/api/base_response.dart';
import 'package:ballaghny/core/error/failures.dart';
import 'package:ballaghny/core/usecases/usecase.dart';

class ContactUs extends UseCase<BaseResponse, ContactUsParams> {
  final ContactUsRepository repository;
  ContactUs(this.repository);
  @override
  Future<Either<Failure, BaseResponse>> call(ContactUsParams params) {
    return repository.contactUs(
        name: params.name,
        email: params.email,
        title: params.title,
        message: params.message);
  }
}

class ContactUsParams extends Equatable {
  final String name;
  final String email;
  final String title;
  final String message;
  const ContactUsParams({
    required this.name,
    required this.email,
    required this.title,
    required this.message,
  });
  @override
  List<Object?> get props => [
        name,
        email,
        title,
        message,
      ];
}
