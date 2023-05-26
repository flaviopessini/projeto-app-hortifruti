import 'package:app_hortifruti/app/data/models/store.dart';
import 'package:app_hortifruti/app/data/providers/api.dart';

class StoreRepository {
  final Api _api;

  StoreRepository(this._api);

  Future<StoreModel?> getStore(int id) {
    return _api.getStore(id);
  }
}
