import 'package:app_painel_hortifruti/app/data/models/category.dart';
import 'package:app_painel_hortifruti/app/data/providers/api.dart';

class ProductRepository {
  final Api _api;

  ProductRepository(this._api);

  Future<List<CategoryModel>> getCategories() => _api.getCategories();
}
