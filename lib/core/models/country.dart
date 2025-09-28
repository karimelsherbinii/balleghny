class ContinentCountry {
  final String continent;
  final List<CountryModel> countries;

  ContinentCountry({required this.continent, required this.countries});

  // Factory method to create a ContinentCountry object from JSON
  factory ContinentCountry.fromJson(Map<String, dynamic> json) {
    return ContinentCountry(
      continent: json['continent'],
      countries: (json['countries'] as List)
          .map((country) => CountryModel.fromJson(country))
          .toList(),
    );
  }

  // Method to convert ContinentCountry object to JSON format
  Map<String, dynamic> toJson() {
    return {
      'continent': continent,
      'countries': countries.map((country) => country.toJson()).toList(),
    };
  }
}

class CountryModel {
  final String name;
  final String code;
  final String phoneCode;

  CountryModel({required this.name, required this.code, required this.phoneCode});

  // Factory method to create a CountryModel object from JSON
  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      name: json['name'],
      code: json['code'],
      phoneCode: json['phone_code'],
    );
  }

  // Method to convert CountryModel object to JSON format
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'code': code,
      'phone_code': phoneCode,
    };
  }
}
