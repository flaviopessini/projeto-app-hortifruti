import 'package:app_hortifruti/app/data/models/order.dart';
import 'package:app_hortifruti/app/modules/order/repository.dart';
import 'package:get/get.dart';

class OrderController extends GetxController with StateMixin<OrderModel> {
  final OrderRepository _repository;

  OrderController(this._repository);

  @override
  void onInit() {
    final String hashId = Get.parameters['hashId']!;

    _repository.getOrder(hashId).then((data) {
      change(data, status: RxStatus.success());
    }, onError: (error) {
      change(null, status: RxStatus.error(error.toString()));
    });
    super.onInit();
  }
}
