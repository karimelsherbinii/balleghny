class OrderModel {
  final int id;
  final String firstName;
  final String status;
  final dynamic result;
  final String createdAt;
  final String updatedAt;

  OrderModel({
    required this.id,
    required this.firstName,
    required this.status,
    this.result,
    required this.createdAt,
    required this.updatedAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      firstName: json['first_name'],
      status: json['status'],
      result: json['result'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
