import 'package:app_painel_hortifruti/app/data/models/order.dart';
import 'package:app_painel_hortifruti/app/modules/order/repository.dart';
import 'package:get/get.dart';

class OrderController extends GetxController with StateMixin<OrderModel> {
  final OrderRepository _repository;
  final hashId = RxnString();

  OrderController(this._repository);

  @override
  void onInit() {
    String? id = Get.parameters['hashId'];

    ever(hashId, (String? hashId) => loadOrder());

    if (id != null) {
      hashId.value = id;
    }

    super.onInit();
  }

  Future<void> loadOrder() async {
    change(state, status: RxStatus.loading());

    await _repository.getOrder(hashId.value!).then((data) {
      change(data, status: RxStatus.success());
    }, onError: (error) {
      change(null, status: RxStatus.error(error.toString()));
    });
  }
}
