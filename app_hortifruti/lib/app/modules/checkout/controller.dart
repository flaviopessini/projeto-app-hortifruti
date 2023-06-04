import 'package:app_hortifruti/app/data/models/address.dart';
import 'package:app_hortifruti/app/data/models/payment_method.dart';
import 'package:app_hortifruti/app/data/models/shipping_by_city.dart';
import 'package:app_hortifruti/app/data/services/auth/service.dart';
import 'package:app_hortifruti/app/data/services/cart/service.dart';
import 'package:app_hortifruti/app/modules/checkout/repository.dart';
import 'package:app_hortifruti/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutController extends GetxController {
  final CheckoutRepository _repository;
  final _cartService = Get.find<CartService>();
  final _authService = Get.find<AuthService>();

  CheckoutController(this._repository);

  final isLoading = true.obs;

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
    if (selectedAddress.value == null) {
      return null;
    }
    return _cartService.store.value!.shippingByCity.firstWhereOrNull(
        (element) => element.id == selectedAddress.value!.city!.id);
  }

  num get totalOrder => totalCart + deliveyCost;

  List<PaymentMethodModel> get paymentMethods =>
      _cartService.store.value!.paymentMethods;
  final paymentMethod = Rxn<PaymentMethodModel>();

  final addresses = RxList<AddressModel>.empty();
  final selectedAddress = Rxn<AddressModel>();

  bool get isAllRight {
    return getShippingByCity != null &&
        selectedAddress.value != null &&
        paymentMethod.value != null;
  }

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
      if (addresses.isNotEmpty) {
        selectedAddress.value = addresses.first;
      }
    }, onError: (error) {
      //
    }).whenComplete(() => isLoading.value = false);
  }

  void goToNewAddress() {
    Get.toNamed(Routes.userAddress);
  }

  void showAddressList() {
    Get.dialog(
      SimpleDialog(
        title: const Text('Selecione um endereço'),
        children: [
          for (final addr in addresses)
            SimpleDialogOption(
              child: Text(
                '${addr.street}, ${addr.number} - ${addr.neighborhood}. ${addr.city!.name}',
              ),
              onPressed: () {
                selectedAddress.value = addr;
                Get.back();
              },
            ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: OutlinedButton(
              onPressed: goToNewAddress,
              child: const Text('Cadastrar um endereço'),
            ),
          ),
        ],
      ),
    );
  }
}
