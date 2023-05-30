import 'package:app_hortifruti/app/modules/cart/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CartPage extends GetView<CartController> {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Get.theme.colorScheme.inversePrimary,
        title: const Text('Carrinho'),
      ),
      body: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          final item = controller.products[index];
          return ListTile(
            title: Text(item.product.name),
            subtitle: Text(
                '${NumberFormat.simpleCurrency().format(item.total)} (${NumberFormat.simpleCurrency().format(item.product.price)})'),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemCount: controller.products.length,
      ),
    );
  }
}
