import 'package:app_hortifruti/app/data/models/order.dart';
import 'package:app_hortifruti/app/modules/order_list/repository.dart';
import 'package:get/get.dart';

class OrderListControlle extends GetxController
    with StateMixin<List<OrderModel>> {
  final OrderListRepository _repository;

  OrderListControlle(this._repository);

  @override
  void onInit() {
    _repository.getOrders().then((data) {
      if (data.isEmpty) {
        change(null, status: RxStatus.empty());
      } else {
        change(data, status: RxStatus.success());
      }
    }, onError: (error) {
      change(null, status: RxStatus.error(error.toString()));
    });
    super.onInit();
  }
}
