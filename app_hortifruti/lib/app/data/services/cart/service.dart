import 'package:app_hortifruti/app/data/models/cart_product.dart';
import 'package:app_hortifruti/app/data/models/store.dart';
import 'package:get/get.dart';

class CartService extends GetxService {
  List<CartProductModel> products = RxList<CartProductModel>.empty();

  final store = Rxn<StoreModel>();

  void addToCart(CartProductModel cartProduct) {
    products.add(cartProduct);
  }

  void newCart(StoreModel newStore) {
    store.value = newStore;
    products.clear();
  }
}
