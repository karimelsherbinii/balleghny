class Language {
  int? id;
  int? idHash;
  String? humansDate;
  String? name;

  Language({this.id, this.idHash, this.humansDate, this.name});

  factory Language.fromJson(Map<String, dynamic> json) => Language(
        id: json['id'] as int?,
        idHash: json['id_hash'] as int?,
        humansDate: json['humans_date'] as String?,
        name: json['name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'id_hash': idHash,
        'humans_date': humansDate,
        'name': name,
      };
}
