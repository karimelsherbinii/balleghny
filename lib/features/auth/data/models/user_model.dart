class UserModel {
  int? id;
  String? name;
  String? firstName;
  String? lastName;
  String? userName;
  String? accessToken;
  String? email;
  String? emailVerifiedAt;
  String? gender;
  String? mobile;
  String? image;

  UserModel({
    this.id,
    this.name,
    this.firstName,
    this.lastName,
    this.userName,
    this.accessToken,
    this.email,
    this.emailVerifiedAt,
    this.gender,
    this.mobile,
    this.image,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        name: json["name"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        userName: json["user_name"],
        accessToken: json["access_token"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        gender: json["gender"],
        mobile: json["mobile"],
        image: json["full_path_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "first_name": firstName,
        "last_name": lastName,
        "user_name": userName,
        "access_token": accessToken,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "gender": gender,
        "mobile": mobile,
        "full_path_image": image,
      };
}

class Language {
  Language({this.id, this.name, this.languageCode, this.isSelected = false});

  int? id;
  String? name;
  String? languageCode;
  bool isSelected;

  factory Language.fromJson(Map<String, dynamic> json) => Language(
        id: json["id"],
        name: json["name"],
        languageCode: json["iso"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "iso": languageCode,
      };
}

class Country {
  Country({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
