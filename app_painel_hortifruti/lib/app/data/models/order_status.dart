class OrderStatusModel {
  String name;
  DateTime createdAt;

  OrderStatusModel({
    required this.name,
    required this.createdAt,
  });

  factory OrderStatusModel.fromJson(Map<String, dynamic> json) =>
      OrderStatusModel(
        name: json['status']['status'],
        createdAt: DateTime.parse(json['created_at']),
      );
}
