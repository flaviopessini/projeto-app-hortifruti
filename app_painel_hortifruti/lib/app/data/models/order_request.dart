import 'package:app_painel_hortifruti/app/data/models/address.dart';
import 'package:app_painel_hortifruti/app/data/models/cart_product.dart';
import 'package:app_painel_hortifruti/app/data/models/payment_method.dart';
import 'package:app_painel_hortifruti/app/data/models/store.dart';

class OrderRequestModel {
  StoreModel store;
  PaymentMethodModel paymentMethod;
  List<CartProductModel> cartProducts;
  AddressModel address;
  num trocoPara;
  String? observation;

  OrderRequestModel({
    required this.store,
    required this.paymentMethod,
    required this.cartProducts,
    required this.address,
    required this.trocoPara,
    this.observation,
  });

  Map<String, dynamic> toJson() => {
        'estabelecimentoId': store.id,
        'meioPagamentoId': paymentMethod.id,
        'enderecoId': address.id,
        'produtos': cartProducts.map((e) => e.toJson()).toList(),
        'trocoPara': trocoPara,
        'observacao': observation,
      };
}
