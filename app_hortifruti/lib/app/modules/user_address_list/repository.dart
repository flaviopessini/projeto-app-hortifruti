import 'package:app_hortifruti/app/data/models/address.dart';
import 'package:app_hortifruti/app/data/providers/api.dart';

class UserAddressListRepository {
  final Api _api;

  UserAddressListRepository(this._api);

  Future<List<AddressModel>> getUserAddress() => _api.getUserAddress();

  Future<void> deleteAddress(int id) => _api.deleteAddress(id);
}
