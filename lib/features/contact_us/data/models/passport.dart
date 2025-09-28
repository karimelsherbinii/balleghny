class PassportModel {
  String? passportHolderName;
  String? passportNumber;
  String? nationality;
  String? issueDate;
  String? expiryDate;
  String? issuePlace;
  String? birthDate;
  String? birthPlace;
  String? nationalId;

  PassportModel({
    this.passportHolderName,
    this.passportNumber,
    this.nationality,
    this.issueDate,
    this.expiryDate,
    this.issuePlace,
    this.birthDate,
    this.birthPlace,
    this.nationalId,
  });

  factory PassportModel.fromJson(Map<String, dynamic> json) => PassportModel(
        passportHolderName: json['passport_holder_name'] as String?,
        passportNumber: json['passport_number'] as String?,
        nationality: json['nationality'] as String?,
        issueDate: json['issue_date'] as String?,
        expiryDate: json['expiry_date'] as String?,
        issuePlace: json['issue_place'] as String?,
        birthDate: json['birth_date'] as String?,
        birthPlace: json['birth_place'] as String?,
        nationalId: json['national_id'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'passport_holder_name': passportHolderName,
        'passport_number': passportNumber,
        'nationality': nationality,
        'issue_date': issueDate,
        'expiry_date': expiryDate,
        'issue_place': issuePlace,
        'birth_date': birthDate,
        'birth_place': birthPlace,
        'national_id': nationalId,
      };
}
