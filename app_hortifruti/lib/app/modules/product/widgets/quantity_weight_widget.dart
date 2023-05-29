import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class QuantityWeightController extends GetxController {
  bool isKg;
  num quantity = 1;

  QuantityWeightController({required this.isKg});

  void changeQuantity(num value) {
    if (value >= 1) {
      quantity = value;
      update();
    }
  }
}

class QuantityWeightWidget extends StatelessWidget {
  final bool isKg;

  const QuantityWeightWidget({super.key, this.isKg = false});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuantityWeightController>(
      init: QuantityWeightController(isKg: isKg),
      builder: (controller) => Column(
        children: [
          QuantityWidget(),
        ],
      ),
    );
  }
}

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
