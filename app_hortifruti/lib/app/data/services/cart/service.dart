import 'package:app_hortifruti/app/data/models/cart_product.dart';
import 'package:app_hortifruti/app/data/models/store.dart';
import 'package:get/get.dart';

class CartService extends GetxService {
  List<CartProductModel> products = RxList<CartProductModel>.empty();

  final store = Rxn<StoreModel>();
  final observation = RxString('');

  bool get isNotEmpty => products.isNotEmpty;

  num get total => products.fold(
      0, (previousValue, element) => previousValue + element.total);

  void removeFromCart(CartProductModel cartProduct) {
    products.remove(cartProduct);
  }

  void addToCart(CartProductModel cartProduct) {
    products.add(cartProduct);
  }

  bool isAnNewStore(StoreModel newStore) {
    return store.value != null && store.value?.id != newStore.id;
  }

  void newCart(StoreModel newStore) {
    store.value = newStore;
  }

  void clearCart() {
    products.clear();
  }

  void finalizedCart() {
    clearCart();
    observation.value = '';
  }
}
