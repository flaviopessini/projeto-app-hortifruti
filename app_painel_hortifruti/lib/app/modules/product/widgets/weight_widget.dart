import 'package:app_painel_hortifruti/app/modules/product/widgets/quantity_weight_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class WeightWidget extends StatelessWidget {
  final controller = Get.find<QuantityWeightController>();

  WeightWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
                '${NumberFormat.decimalPattern().format(controller.minWeight)}kg'),
            Expanded(
              child: GestureDetector(
                onTapDown: (details) => controller.enableSlider(),
                child: Slider(
                  min: controller.minWeight,
                  max: controller.maxWeight,
                  divisions: 19,
                  label: controller.label,
                  value: controller.weight,
                  onChanged: (value) {
                    if (controller.sliderEnabled.isTrue) {
                      controller.changeWeight(value);
                    }
                  },
                  onChangeEnd: (value) =>
                      controller.sliderEnabled.value = false,
                ),
              ),
            ),
            Text(
                '${NumberFormat.decimalPattern().format(controller.maxWeight)}kg'),
          ],
        ),
        Text(
          'Toque e segure para deslizar',
          style: Get.textTheme.labelSmall,
        ),
      ],
    );
  }
}
