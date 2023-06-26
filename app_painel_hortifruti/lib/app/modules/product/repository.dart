import 'package:app_painel_hortifruti/app/data/models/category.dart';
import 'package:app_painel_hortifruti/app/data/models/product.dart';
import 'package:app_painel_hortifruti/app/data/models/product_request.dart';
import 'package:app_painel_hortifruti/app/data/providers/api.dart';

class ProductRepository {
  final Api _api;

  ProductRepository(this._api);

  Future<List<CategoryModel>> getCategories() => _api.getCategories();

  Future<ProductModel> postProduct(ProductRequestModel product) =>
      _api.postProduct(product);

  Future<ProductModel> putProduct(ProductRequestModel product) =>
      _api.putProduct(product);
}
