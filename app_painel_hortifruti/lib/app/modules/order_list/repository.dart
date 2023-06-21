import 'package:app_painel_hortifruti/app/data/models/order.dart';
import 'package:app_painel_hortifruti/app/data/providers/api.dart';

class OrderListRepository {
  final Api _api;

  OrderListRepository(this._api);

  Future<List<OrderModel>> getOrders() => _api.getOrders();
}
