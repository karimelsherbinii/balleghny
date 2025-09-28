import 'language.dart';

class DefinitionModel {
  int? id;
  int? languageId;
  String? title;
  String? image;
  String? url;
  int? status;
  int? shares;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  int? idHash;
  String? humansDate;
  String? fullPathImage;
  Language? language;

  DefinitionModel({
    this.id,
    this.languageId,
    this.title,
    this.image,
    this.url,
    this.status,
    this.shares,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.idHash,
    this.humansDate,
    this.fullPathImage,
    this.language,
  });

  factory DefinitionModel.fromJson(Map<String, dynamic> json) =>
      DefinitionModel(
        id: json['id'] as int?,
        languageId: json['language_id'] as int?,
        title: json['title'] as String?,
        image: json['image'] as String?,
        url: json['url'] as String?,
        status: json['status'] as int?,
        shares: json['count_share'] as int?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
        deletedAt: json['deleted_at'] as dynamic,
        idHash: json['id_hash'] as int?,
        humansDate: json['humans_date'] as String?,
        fullPathImage: json['full_path_image'] as String?,
        language: json['language'] == null
            ? null
            : Language.fromJson(json['language'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'language_id': languageId,
        'title': title,
        'image': image,
        'url': url,
        'status': status,
        'count_share': shares,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'deleted_at': deletedAt,
        'id_hash': idHash,
        'humans_date': humansDate,
        'full_path_image': fullPathImage,
        'language': language?.toJson(),
      };
}
