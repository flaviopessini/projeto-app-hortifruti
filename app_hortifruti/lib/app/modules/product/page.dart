import 'package:app_hortifruti/app/modules/product/controller.dart';
import 'package:app_hortifruti/app/modules/product/widgets/quantity_weight_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:transparent_image/transparent_image.dart';

class ProductPage extends GetView<ProductController> {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Get.theme.colorScheme.inversePrimary,
        title: Text(controller.product.value!.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Column(
          children: [
            if (controller.product.value!.image.isNotEmpty) ...[
              Align(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: controller.product.value!.image,
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
            ],
            if (controller.product.value!.description != null)
              Text(
                controller.product.value!.description!,
              ),
            Text(
              '${NumberFormat.simpleCurrency().format(controller.product.value!.price)}${(controller.product.value!.unitOfMeasureIsByKg ? ' /kg' : '')}',
              style: Get.textTheme.titleLarge,
            ),
            TextField(
              controller: controller.observationController,
              decoration: const InputDecoration(
                labelText: 'Observação',
              ),
              maxLength: 100,
            ),
            const SizedBox(height: 8.0),
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Get.theme.colorScheme.inversePrimary),
                //color: Colors.grey[100],
                color: Get.theme.colorScheme.secondaryContainer,
              ),
              child: Column(
                children: [
                  const Text('Selecione a quantidade'),
                  const SizedBox(height: 8.0),
                  QuantityWeightWidget(
                      isKg: controller.product.value!.unitOfMeasureIsByKg),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton.icon(
                onPressed: controller.addToCart,
                icon: const Icon(Icons.add_shopping_cart_rounded),
                label: const Text('Adicionar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
