import 'package:ballaghny/features/contact_us/domain/usecases/contact_us_profile.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'contact_us_state.dart';

class ContactUsCubit extends Cubit<ContactUsState> {
  final ContactUs contactUsUseCase;
  ContactUsCubit({required this.contactUsUseCase}) : super(ContactUsInitial());

  Future<void> contactUs({
    required String name,
    required String email,
    required String title,
    required String message,
  }) async {
    emit(ContactUsLoadingState());
    final result = await contactUsUseCase(ContactUsParams(
      name: name,
      email: email,
      title: title,
      message: message,
    ));
    result
        .fold((failure) => emit(ContactUsErrorState(message: failure.message!)),
            (data) {
      if (data.statusCode == 200) {
        emit(ContactUsSuccessState(message: data.message!));
      } else {
        emit(ContactUsErrorState(message: data.message!));
      }
    });
  }
}
