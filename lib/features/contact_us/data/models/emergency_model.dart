class EmergenceNumberModel {
  int? userId;
  String? name;
  String? phone;
  String? relationship;
  String? updatedAt;
  String? createdAt;
  int? id;

  EmergenceNumberModel({
    this.userId,
    this.name,
    this.phone,
    this.relationship,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory EmergenceNumberModel.fromJson(Map<String, dynamic> json) {
    return EmergenceNumberModel(
      userId: json['user_id'] as int?,
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      relationship: json['relationship'] as String?,
      updatedAt: json['updated_at'] as String?,
      createdAt: json['created_at'] as String?,
      id: json['id'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'user_id': userId,
        'name': name,
        'phone': phone,
        'relationship': relationship,
        'updated_at': updatedAt,
        'created_at': createdAt,
        'id': id,
      };
}
