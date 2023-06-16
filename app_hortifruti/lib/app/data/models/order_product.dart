import 'package:app_hortifruti/app/data/models/product.dart';

class OrderProductModel {
  ProductModel product;
  num quantity;
  num value;
  String? observation;

  OrderProductModel({
    required this.product,
    required this.quantity,
    required this.value,
    this.observation,
  });

  num get total => value * quantity;

  factory OrderProductModel.fromJson(Map<String, dynamic> json) =>
      OrderProductModel(
        product: ProductModel.fromJson(json['produto']),
        quantity: num.parse(json['quantidade']),
        value: num.parse(json['valor']),
        observation: json['observacao'],
      );
}
