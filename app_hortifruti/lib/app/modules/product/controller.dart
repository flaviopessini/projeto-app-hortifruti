import 'package:app_hortifruti/app/data/models/cart_product.dart';
import 'package:app_hortifruti/app/data/models/product.dart';
import 'package:app_hortifruti/app/data/models/store.dart';
import 'package:app_hortifruti/app/data/services/cart/service.dart';
import 'package:app_hortifruti/app/modules/product/widgets/quantity_weight_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  final product = Rxn<ProductModel>();
  final store = Rxn<StoreModel>();
  final observationController = TextEditingController();
  final _cartService = Get.find<CartService>();

  @override
  void onInit() {
    product.value = Get.arguments['product'];
    store.value = Get.arguments['store'];
    super.onInit();
  }

  void addToCart() {
    var quantity = Get.find<QuantityWeightController>().quantity;

    if (_cartService.isAnNewStore(store.value!)) {
      _cartService.clearCart();
    }

    if (_cartService.products.isEmpty) {
      _cartService.newCart(store.value!);
    }

    _cartService.addToCart(CartProductModel(
      product: product.value!,
      quantity: quantity,
      observation: observationController.text,
    ));

    ScaffoldMessenger.of(Get.overlayContext!).showSnackBar(
      SnackBar(
        content:
            Text('O item ${product.value!.name} foi adicionado ao carrinho'),
        backgroundColor: Get.theme.colorScheme.tertiary,
        showCloseIcon: true,
      ),
    );

    // Não funciona adequadamente com Get.back() abaixo, pois fecha a snackbar
    // para depois voltar a tela.
    //
    // Get.rawSnackbar(
    //   title: 'Item adicionado',
    //   message: 'O item ${product.value!.name} foi adicionado ao carrinho',
    //   backgroundColor: Get.theme.colorScheme.tertiary,
    //   onTap: (snack) => Get.isSnackbarOpen ? Get.closeCurrentSnackbar() : () {},
    // );

    Future.delayed(const Duration(milliseconds: 300), () => Get.back());
  }
}
