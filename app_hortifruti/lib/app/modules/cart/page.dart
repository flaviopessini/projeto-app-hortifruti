import 'package:app_hortifruti/app/data/models/cart_product.dart';
import 'package:app_hortifruti/app/modules/cart/controller.dart';
import 'package:app_hortifruti/app/routes/routes.dart';
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
      body: Obx(
        () => controller.products.isEmpty
            ? const Center(
                child: Text('Seu carrinho está vazio!'),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: controller.observationController,
                        decoration: const InputDecoration(
                          labelText: 'Observação',
                        ),
                        maxLength: 100,
                      ),
                    ),
                    // ExpansionTile(
                    //   title: Text(controller.store!.name),
                    //   children: [
                    //     for (final item in controller.products) ...[
                    //       Text(item.product.name),
                    //     ]
                    //   ],
                    // )
                    if (controller.store != null)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          controller.store!.name,
                          style: Get.textTheme.titleLarge!.copyWith(
                            color: Get.theme.colorScheme.tertiary,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        final item = controller.products[index];
                        return ListTile(
                          title: Text(
                            item.product.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Get.theme.colorScheme.primary,
                            ),
                          ),
                          subtitle: Text(
                            '${NumberFormat.simpleCurrency().format(item.total)} (${NumberFormat.simpleCurrency().format(item.product.price)})',
                            style: Get.textTheme.bodyMedium!.copyWith(
                              color: Get.theme.colorScheme.tertiary,
                            ),
                          ),
                          leading: _buildProductQuantity(item),
                          trailing: IconButton(
                            onPressed: () => controller.removeProduct(item),
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.grey,
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(),
                      itemCount: controller.products.length,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton.icon(
                        onPressed: () => Get.toNamed(Routes.checkout),
                        icon: const Icon(Icons.shopping_cart_checkout_rounded),
                        label: const Text('Avançar'),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildProductQuantity(CartProductModel cartProduct) {
    return Text(
      NumberFormat.decimalPattern().format(cartProduct.quantity) +
          (cartProduct.product.unitOfMeasureIsByKg ? 'kg' : 'x'),
    );
  }
}
