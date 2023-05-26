import 'package:app_hortifruti/app/data/models/store.dart';
import 'package:app_hortifruti/app/data/providers/api.dart';

class HomeRepository {
  final Api _api;

  HomeRepository(this._api);

  Future<List<StoreModel>> getStores() async {
    return await _api.getStores();
  }
}