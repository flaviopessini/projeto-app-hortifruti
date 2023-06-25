import 'package:app_painel_hortifruti/app/data/models/order.dart';
import 'package:app_painel_hortifruti/app/data/providers/api.dart';

class OrderRepository {
  final Api _api;

  OrderRepository(this._api);

  Future<OrderModel> getOrder(String hashId) => _api.getOrder(hashId);

  Future<void> postOrderStatus(String id, int statusId) =>
      _api.postOrderStatus(id, statusId);
}
