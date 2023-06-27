import 'package:app_painel_hortifruti/app/data/providers/api.dart';

class DeleteProductImageRepository {
  final Api _api;

  DeleteProductImageRepository(this._api);

  Future<void> deleteProductImage(int productId) =>
      _api.deleteProductImage(productId);
}
