import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ballaghny/core/usecases/usecase.dart';
import '../../../../core/error/failures.dart';
import '../../domain/usecases/get_about_app_content.dart';
part 'about_app_state.dart';

class AboutAppCubit extends Cubit<AboutAppState> {
  final GetAboutAppContent getAboutAppContent;
  AboutAppCubit({required this.getAboutAppContent}) : super(AboutAppInitial());

  Future<void> getContentOfAboutApp() async {
    emit(AboutAppContentIsLoading());
    Either<Failure, String> response =
        await getAboutAppContent.call(NoParams());
    emit(response.fold((failure) => AboutAppError(message: failure.message),
        (content) => AboutAppContentLoaded(content: content)));
  }
}
