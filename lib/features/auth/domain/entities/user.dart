import 'language.dart';

class User {
  const User({
    this.id,
    this.firstName,
    this.lastName,
    this.fullName,
    this.username,
    this.email,
    this.gender,
    this.birthDate,
    this.mobile,
    this.countryId,
    this.countryTitle,
    this.nationalityId,
    this.nationalityTitle,
    this.bio,
    this.languages,
    this.isSocialUser,
    this.profilePhoto,
    this.quranCertificate,
    this.role,
    this.bankDetails,
  });

  final int? id;
  final String? firstName;
  final String? lastName;
  final String? fullName;
  final String? username;
  final String? email;
  final String? gender;
  final String? birthDate;
  final String? mobile;
  final int? countryId;
  final String? countryTitle;
  final int? nationalityId;
  final String? nationalityTitle;
  final dynamic bio;
  final List<Language>? languages;
  final bool? isSocialUser;
  final String? profilePhoto;
  final String? quranCertificate;
  final String? role;
  final String? bankDetails;

  List<Object?> get props => [
        id,
        firstName,
        lastName,
        fullName,
        username,
        email,
        gender,
        birthDate,
        mobile,
        countryId,
        countryTitle,
        nationalityId,
        nationalityTitle,
        bio,
        languages,
        isSocialUser,
        profilePhoto,
        quranCertificate,
        role,
        bankDetails
      ];
}
