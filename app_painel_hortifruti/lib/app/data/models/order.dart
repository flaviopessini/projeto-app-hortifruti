import 'package:app_painel_hortifruti/app/data/models/address.dart';
import 'package:app_painel_hortifruti/app/data/models/order_product.dart';
import 'package:app_painel_hortifruti/app/data/models/order_status.dart';
import 'package:app_painel_hortifruti/app/data/models/payment_method.dart';
import 'package:app_painel_hortifruti/app/data/models/store.dart';

class OrderModel {
  String hashId;
  num value;
  num deliveryCost;
  String? observation;
  DateTime createdAt;
  List<OrderStatusModel> statusList;
  AddressModel? address;
  PaymentMethodModel? paymentMethod;
  List<OrderProductModel> productList;

  OrderModel({
    required this.hashId,
    required this.value,
    required this.deliveryCost,
    required this.createdAt,
    required this.statusList,
    required this.productList,
    this.address,
    this.paymentMethod,
    this.observation,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        hashId: json['hash_id'],
        value: num.parse(json['valor']),
        deliveryCost: num.parse(json['custo_entrega']),
        statusList: json['pedidoStatus'] == null
            ? []
            : List<OrderStatusModel>.from(json['pedidoStatus']
                .map((status) => OrderStatusModel.fromJson(status))),
        productList: json['produtos'] == null
            ? []
            : List<OrderProductModel>.from(json['produtos']
                .map((product) => OrderProductModel.fromJson(product))),
        address: json['endereco'] == null
            ? null
            : AddressModel.fromJson(json['endereco']),
        paymentMethod: json['meioPagamento'] == null
            ? null
            : PaymentMethodModel.fromJson(json['meioPagamento']),
        observation: json['observacao'],
        createdAt: DateTime.parse(json['created_at']),
      );
}
