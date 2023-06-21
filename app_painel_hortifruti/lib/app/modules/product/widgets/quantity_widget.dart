import 'package:app_painel_hortifruti/app/modules/product/widgets/quantity_weight_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class QuantityWidget extends StatelessWidget {
  final controller = Get.find<QuantityWeightController>();

  QuantityWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton(
          onPressed: controller.quantity > 1
              ? () => controller.changeQuantity(controller.quantity - 1)
              : null,
          child: const Icon(Icons.remove),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '${NumberFormat.decimalPattern().format(controller.quantity)}${controller.isKg ? 'kg' : ''}',
            style: Get.textTheme.bodyLarge,
          ),
        ),
        ElevatedButton(
          onPressed: () => controller.changeQuantity(controller.quantity + 1),
          child: const Icon(Icons.add),
        ),
      ],
    );
  }
}
