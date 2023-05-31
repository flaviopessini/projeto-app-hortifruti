import 'package:app_hortifruti/app/data/providers/api.dart';
import 'package:app_hortifruti/app/modules/cart/repository.dart';
import 'package:app_hortifruti/app/modules/checkout/controller.dart';
import 'package:get/get.dart';

class CheckoutBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CheckoutController>(
        () => CheckoutController(CheckoutRepository(Get.find<Api>())));
  }
}
