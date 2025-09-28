import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../domain/usecases/change_lang.dart';
import '../../domain/usecases/get_saved_lang.dart';

part 'locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  final GetSavedLang getSavedLangUseCase;
  final ChangeLang changeLangUseCase;
  LocaleCubit(
      {required this.getSavedLangUseCase, required this.changeLangUseCase})
      : super(const ChangeLocaleState(Locale(AppStrings.arabicCode)));

  String currentLangCode = AppStrings.arabicCode;

  static LocaleCubit get(context) => BlocProvider.of(context);

  Future<void> getSavedLang() async {
    final response = await getSavedLangUseCase.call(NoParams());
    response.fold((failure) => debugPrint(AppStrings.cacheFailure), (value) {
      currentLangCode = value;
      emit(ChangeLocaleState(Locale(currentLangCode)));
    });
  }

  Future<void> changeLang(String langCode) async {
    final response = await changeLangUseCase.call(langCode);
    response.fold((failure) => debugPrint(AppStrings.cacheFailure), (value) {
      currentLangCode = langCode;
      emit(ChangeLocaleState(Locale(currentLangCode)));
    });
  }

  void toEnglish() => changeLang(AppStrings.englishCode);

  void toArabic() => changeLang(AppStrings.arabicCode);
}
