part of 'settings_cubit.dart';

abstract class SettingsState extends Equatable {
  final bool isDarkState;
  const SettingsState(this.isDarkState);
  @override
  List<Object?> get props => [isDarkState];
}

// class SettingsInitial extends SettingsState {
//   const SettingsInitial({required bool isDarkState}) : super(isDarkState);
// }
class ChangeDarkModeStateInitial extends SettingsState {
  const ChangeDarkModeStateInitial({required bool isDarkState})
      : super(isDarkState);
}

class ChangeDarkModeLoadingState extends SettingsState {
  const ChangeDarkModeLoadingState({required bool isDarkState})
      : super(isDarkState);
}

class GetLanguagesLoadingState extends SettingsState {
  const GetLanguagesLoadingState() : super(false);
}

class GetLanguagesLoadedState extends SettingsState {
  final List<DynamicModel> languages;
  const GetLanguagesLoadedState({required this.languages}) : super(false);
}

class GetLanguagesErrorState extends SettingsState {
  final String message;
  const GetLanguagesErrorState({required this.message}) : super(false);
}

class GetCountriesLoadingState extends SettingsState {
  const GetCountriesLoadingState() : super(false);
}

class GetCountriesLoadedState extends SettingsState {
  final List<DynamicModel> countries;
  const GetCountriesLoadedState({required this.countries}) : super(false);
}

class GetCountriesErrorState extends SettingsState {
  final String message;
  const GetCountriesErrorState({required this.message}) : super(false);
}

class GetNationalitiesLoadingState extends SettingsState {
  const GetNationalitiesLoadingState() : super(false);
}

class GetNationalitiesLoadedState extends SettingsState {
  final List<DynamicModel> nationalities;
  const GetNationalitiesLoadedState({required this.nationalities})
      : super(false);
}

class GetNationalitiesErrorState extends SettingsState {
  final String message;
  const GetNationalitiesErrorState({required this.message}) : super(false);
}

class GetReligionsLoadingState extends SettingsState {
  const GetReligionsLoadingState() : super(false);
}

class GetReligionsLoadedState extends SettingsState {
  final List<DynamicModel> religions;
  const GetReligionsLoadedState({required this.religions}) : super(false);
}

class GetReligionsErrorState extends SettingsState {
  final String message;
  const GetReligionsErrorState({required this.message}) : super(false);
}

class GetContinentsLoadingState extends SettingsState {
  const GetContinentsLoadingState() : super(false);
}

class GetContinentsSuccessState extends SettingsState {
  final List<ContinentCountry> continents;
  const GetContinentsSuccessState({required this.continents}) : super(false);

  @override
  List<Object> get props => [continents];
}

class GetContinentsErrorState extends SettingsState {
  final String message;
  const GetContinentsErrorState({required this.message}) : super(false);
}

class GetAllCountriesLoadingState extends SettingsState {
  const GetAllCountriesLoadingState() : super(false);
}

class GetAllCountriesSuccessState extends SettingsState {
  final List<CountryModel> countries;

  const GetAllCountriesSuccessState({required this.countries}) : super(false);
  @override
  List<Object> get props => [countries];
}

class GetAllCountriesErrorState extends SettingsState {
  final String message;

  const GetAllCountriesErrorState({required this.message}) : super(false);
}

class SelectCountryCodeState extends SettingsState {
  final String code;

  const SelectCountryCodeState({required this.code}) : super(false);
  @override
  List<Object> get props => [code];
}