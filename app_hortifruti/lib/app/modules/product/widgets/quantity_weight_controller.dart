import 'package:get/get.dart';
import 'package:intl/intl.dart';

class QuantityWeightController extends GetxController {
  bool isKg;
  num quantity = 1;
  late double minWeight;
  late double maxWeight;
  final sliderEnabled = false.obs;

  double get weight => quantity.toDouble();
  String get label {
    var unit = 'kg';
    var pattern = '0.00';
    var number = weight;
    if (number < 1) {
      number *= 1000;
      unit = 'g';
      pattern = '';
    } else if (number % number.toInt() == 0) {
      pattern = '';
    }
    return NumberFormat(pattern).format(number) + unit;
  }

  QuantityWeightController({required this.isKg});

  @override
  void onInit() {
    _updateMinAndMaxWeight();
    super.onInit();
  }

  void _updateMinAndMaxWeight() {
    minWeight = weight - 1 + 0.05;
    maxWeight = weight;

    if (minWeight < 0) {
      minWeight = 0.05;
      maxWeight = 1;
    }
  }

  void enableSlider() => sliderEnabled.value = true;

  void changeQuantity(num value) {
    quantity = value;
    _updateMinAndMaxWeight();
    update();
  }

  void changeWeight(double value) {
    quantity = value;
    update();
  }
}
