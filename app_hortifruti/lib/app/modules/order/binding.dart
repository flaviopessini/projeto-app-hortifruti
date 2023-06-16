import 'package:app_hortifruti/app/data/providers/api.dart';
import 'package:app_hortifruti/app/modules/order/controller.dart';
import 'package:app_hortifruti/app/modules/order/repository.dart';
import 'package:get/get.dart';

class OrderBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderController>(
      () => OrderController(OrderRepository(Get.find<Api>())),
    );
  }
}
