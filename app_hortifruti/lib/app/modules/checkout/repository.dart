import 'package:app_hortifruti/app/data/models/address.dart';
import 'package:app_hortifruti/app/data/models/order_request.dart';
import 'package:app_hortifruti/app/data/providers/api.dart';

class CheckoutRepository {
  final Api _api;

  CheckoutRepository(this._api);

  Future<List<AddressModel>> getUserAddresses() => _api.getUserAddress();

  Future<void> postOrder(OrderRequestModel order) => _api.postOrder(order);
}
