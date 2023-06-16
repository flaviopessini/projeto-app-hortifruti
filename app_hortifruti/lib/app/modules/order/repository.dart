import 'package:app_hortifruti/app/data/models/order.dart';
import 'package:app_hortifruti/app/data/providers/api.dart';

class OrderRepository {
  final Api _api;

  OrderRepository(this._api);

  Future<OrderModel> getOrder(String hashId) => _api.getOrder(hashId);
}
