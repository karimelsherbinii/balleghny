import 'dart:convert';
import 'dart:developer';

import 'package:ballaghny/core/models/country.dart';
import 'package:ballaghny/features/settings/data/models/dynamic_model.dart';
import 'package:ballaghny/features/settings/domain/usecases/get_%20religions.dart';
import 'package:ballaghny/features/settings/domain/usecases/get_countries.dart';
import 'package:ballaghny/features/settings/domain/usecases/get_languages.dart';
import 'package:ballaghny/features/settings/domain/usecases/get_nationalities.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ballaghny/core/utils/app_strings.dart';
import 'package:ballaghny/features/settings/domain/usecases/change_language_usecase.dart';
import 'package:ballaghny/features/settings/domain/usecases/get_saved_language.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/usecases/usecase.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final ChangeDarkModeUseCase changeDarkModeUseCase;
  final GetSavedDarkModeUseCase getSavedDarkModeUseCase;
  final GetLanguages getLanguagesUseCase;
  final GetCountries getCountriesUseCase;
  final GetNationalities getNationalitiesUseCase;
  final GetReligions getReligionsUseCase;
  SettingsCubit(
      {required this.changeDarkModeUseCase,
      required this.getSavedDarkModeUseCase,
      required this.getLanguagesUseCase,
      required this.getCountriesUseCase,
      required this.getNationalitiesUseCase,
      required this.getReligionsUseCase})
      : super(const ChangeDarkModeStateInitial(isDarkState: AppStrings.isDark));

  bool currentDarkModeState = AppStrings.isNotDark;

  Future<void> getSavedDarkMode() async {
    final response = await getSavedDarkModeUseCase.call(NoParams());
    response.fold((failure) => debugPrint(AppStrings.cacheFailure), (value) {
      currentDarkModeState = value;
      emit(ChangeDarkModeStateInitial(isDarkState: currentDarkModeState));
    });

    // change
  }

  Future<void> changeDarkMode({required bool isDark}) async {
    emit(ChangeDarkModeLoadingState(isDarkState: currentDarkModeState));
    final response = await changeDarkModeUseCase.call(isDark);
    response.fold((failure) => debugPrint(AppStrings.cacheFailure), (value) {
      currentDarkModeState = isDark;
      emit(ChangeDarkModeStateInitial(isDarkState: currentDarkModeState));
    });
  }

  List<DynamicModel> languages = [];
  List<DynamicModel> countries = [];
  List<DynamicModel> nationalities = [];
  List<DynamicModel> religions = [];
  Future<void> getLanguages() async {
    emit(GetLanguagesLoadingState());
    final response = await getLanguagesUseCase.call(NoParams());
    response.fold(
        (failure) => emit(GetLanguagesErrorState(message: failure.message!)),
        (value) {
      languages = value.data;
      emit(GetLanguagesLoadedState(languages: languages));
    });
  }

  Future<void> getCountries() async {
    emit(GetCountriesLoadingState());
    final response = await getCountriesUseCase.call(NoParams());
    response.fold(
        (failure) => emit(GetCountriesErrorState(message: failure.message!)),
        (value) {
      countries = value.data;
      emit(GetCountriesLoadedState(countries: countries));
    });
  }

  Future<void> getNationalities() async {
    emit(GetNationalitiesLoadingState());
    final response = await getNationalitiesUseCase.call(NoParams());
    response.fold(
        (failure) =>
            emit(GetNationalitiesErrorState(message: failure.message!)),
        (value) {
      nationalities = value.data;
      emit(GetNationalitiesLoadedState(nationalities: nationalities));
    });
  }

  Future<void> getReligions() async {
    emit(GetReligionsLoadingState());
    final response = await getReligionsUseCase.call(NoParams());
    response.fold(
        (failure) => emit(GetReligionsErrorState(message: failure.message!)),
        (value) {
      religions = value.data;
      emit(GetReligionsLoadedState(religions: religions));
    });
  }

  List<ContinentCountry> continentsCountries = [];
  List<String> availableContinents = [];
  // List<CountryModel> availableCountries = [];
  // List<CountryModel> allCountries = [];
  Future<void> loadContinentsAndCountries() async {
    try {
      emit(GetContinentsLoadingState());
      final sharedPreferences = await SharedPreferences.getInstance();
      final lang = sharedPreferences.getString(AppStrings.locale) ?? 'ar';
      final String response = await rootBundle.loadString(
        lang == 'ar' ? 'assets/countries_ar.json' : 'assets/countries.json',
      );
      final List<dynamic> data = json.decode(response);
      continentsCountries =
          data.map((json) => ContinentCountry.fromJson(json)).toList();
      availableContinents =
          continentsCountries.map((e) => e.continent).toList();
      
      emit(GetContinentsSuccessState(continents: continentsCountries));
    } catch (e) {
      log('Error loading continents and countries: $e');
      emit(GetContinentsErrorState(message: e.toString()));
    }
  }

  // Future<void> getAllCountries() async {
  //   emit(GetAllCountriesLoadingState());
  //   allCountries = continentsCountries
  //       .map((continent) => continent.countries)
  //       .expand((element) => element)
  //       .toList();
  //   emit(GetAllCountriesSuccessState(countries: allCountries));
  // }

  String selectedCountryCode = '+966';

  selectCountryCode(String code) {
    selectedCountryCode = code;
    emit(SelectCountryCodeState(code: code));
  }
}
