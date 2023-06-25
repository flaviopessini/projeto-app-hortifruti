class OrderStatusModel {
  int id;
  String name;
  DateTime createdAt;

  OrderStatusModel({
    required this.id,
    required this.name,
    required this.createdAt,
  });

  factory OrderStatusModel.fromJson(Map<String, dynamic> json) =>
      OrderStatusModel(
        id: json['status']['id'],
        name: json['status']['status'],
        createdAt: DateTime.parse(json['created_at']),
      );
}
