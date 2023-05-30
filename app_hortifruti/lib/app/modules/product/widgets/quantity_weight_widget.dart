import 'package:app_hortifruti/app/modules/product/widgets/quantity_weight_controller.dart';
import 'package:app_hortifruti/app/modules/product/widgets/quantity_widget.dart';
import 'package:app_hortifruti/app/modules/product/widgets/weight_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
          if (isKg) WeightWidget(),
        ],
      ),
    );
  }
}
