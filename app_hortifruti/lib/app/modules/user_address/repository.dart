import 'package:app_hortifruti/app/data/models/city.dart';
import 'package:app_hortifruti/app/data/models/user_address_request.dart';
import 'package:app_hortifruti/app/data/providers/api.dart';

class UserAddressRepository {
  final Api _api;

  UserAddressRepository(this._api);

  Future<List<CityModel>> getCities() => _api.getCities();

  Future<void> postAddress(UserAddressRequestModel addressRequest) =>
      _api.postAddress(addressRequest);

  Future<void> putAddress(UserAddressRequestModel addressRequest) =>
      _api.putAddress(addressRequest);
}
