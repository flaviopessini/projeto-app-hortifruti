import 'package:app_painel_hortifruti/app/data/models/product.dart';
import 'package:app_painel_hortifruti/app/data/providers/api.dart';

class CategoryRepository {
  final Api _api;

  CategoryRepository(this._api);

  Future<List<ProductModel>> getProducts(int id) => _api.getProducts(id);
}
