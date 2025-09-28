class DynamicModel {
  final int id;
  final dynamic name;

  DynamicModel({
    required this.id,
    required this.name,
  });

  factory DynamicModel.fromJson(Map<String, dynamic> json) {
    return DynamicModel(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
