import 'package:app_painel_hortifruti/app/data/providers/api.dart';
import 'package:app_painel_hortifruti/app/widgets/order/order_controller.dart';
import 'package:app_painel_hortifruti/app/modules/order/repository.dart';
import 'package:get/get.dart';

class OrderBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderController>(
      () => OrderController(OrderRepository(Get.find<Api>())),
    );
  }
}
