import 'package:app_hortifruti/app/data/models/city.dart';
import 'package:app_hortifruti/app/data/providers/api.dart';

class UserProfileRepository {
  final Api _api;

  UserProfileRepository(this._api);

  Future<List<CityModel>> getCities() => _api.getCities();

  // Future<void> postAddress(UserProfileRequestModel addressRequest) =>
  //     _api.postAddress(addressRequest);
}
