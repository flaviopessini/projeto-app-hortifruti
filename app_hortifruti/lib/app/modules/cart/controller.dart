import 'package:app_hortifruti/app/data/models/cart_product.dart';
import 'package:app_hortifruti/app/data/models/store.dart';
import 'package:app_hortifruti/app/data/services/cart/service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final _cartService = Get.find<CartService>();
  final observationController = TextEditingController();

  List<CartProductModel> get products => _cartService.products;
  StoreModel? get store => _cartService.store.value;

  void removeProduct(CartProductModel cartProduct) {
    _cartService.removeFromCart(cartProduct);
  }
}
