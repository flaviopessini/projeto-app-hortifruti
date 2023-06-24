import 'package:app_painel_hortifruti/app/data/models/order.dart';
import 'package:app_painel_hortifruti/app/data/services/auth/service.dart';
import 'package:app_painel_hortifruti/app/modules/order_list/repository.dart';
import 'package:app_painel_hortifruti/app/widgets/order/order_controller.dart';
import 'package:get/get.dart';

class OrderListController extends GetxController
    with StateMixin<List<OrderModel>> {
  final OrderListRepository _repository;
  final _authService = Get.find<AuthService>();
  final orderSelected = RxnString();

  OrderListController(this._repository);

  @override
  void onInit() {
    ever(_authService.user, (_) => fetchOrders());

    fetchOrders();

    super.onInit();
  }

  void fetchOrders() {
    _repository.getOrders().then((data) {
      if (data.isEmpty) {
        change(null, status: RxStatus.empty());
      } else {
        change(data, status: RxStatus.success());
      }
    }, onError: (error) {
      change(null, status: RxStatus.error(error.toString()));
    });
  }

  void changeOrder(OrderModel order) {
    orderSelected.value = order.hashId;
    Get.find<OrderController>(tag: 'detail').hashId.value = orderSelected.value;
  }
}
