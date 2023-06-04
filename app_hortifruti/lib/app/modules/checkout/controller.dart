import 'package:app_hortifruti/app/data/models/address.dart';
import 'package:app_hortifruti/app/data/models/payment_method.dart';
import 'package:app_hortifruti/app/data/models/shipping_by_city.dart';
import 'package:app_hortifruti/app/data/services/auth/service.dart';
import 'package:app_hortifruti/app/data/services/cart/service.dart';
import 'package:app_hortifruti/app/modules/checkout/repository.dart';
import 'package:app_hortifruti/app/routes/routes.dart';
import 'package:get/get.dart';

class CheckoutController extends GetxController {
  final CheckoutRepository _repository;
  final _cartService = Get.find<CartService>();
  final _authService = Get.find<AuthService>();

  CheckoutController(this._repository);

  bool get isLogged => _authService.isLogged;

  num get totalCart => _cartService.total;

  num get deliveyCost {
    if (getShippingByCity != null) {
      return getShippingByCity!.cost;
    } else {
      return 0;
    }
  }

  ShippingByCityModel? get getShippingByCity {
    var id = 1;
    return _cartService.store.value!.shippingByCity
        .firstWhereOrNull((element) => element.id == id);
  }

  num get totalOrder => totalCart + deliveyCost;

  List<PaymentMethodModel> get paymentMethods =>
      _cartService.store.value!.paymentMethods;
  final paymentMethod = Rxn<PaymentMethodModel>();

  final addresses = RxList<AddressModel>.empty();

  @override
  void onInit() {
    fetchAddresses();

    super.onInit();
  }

  void changePaymentMethod(PaymentMethodModel? newPaymentMethod) {
    paymentMethod.value = newPaymentMethod;
  }

  void goToLogin() {
    Get.toNamed(Routes.login, arguments: {"backToPrevious": true});
  }

  void fetchAddresses() {
    _repository.getUserAddresses().then((value) {
      addresses.addAll(value);
    });
  }

  void goToNewAddress() {
    Get.toNamed(Routes.userAddress);
  }
}
