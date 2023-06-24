import 'package:app_painel_hortifruti/app/data/providers/api.dart';
import 'package:app_painel_hortifruti/app/modules/order/repository.dart';
import 'package:app_painel_hortifruti/app/modules/order_list/controller.dart';
import 'package:app_painel_hortifruti/app/widgets/order/order_controller.dart';
import 'package:app_painel_hortifruti/app/widgets/order/order_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderDetailsWidget extends StatelessWidget {
  final orderListController = Get.find<OrderListController>();
  final controller = Get.put(
    OrderController(OrderRepository(Get.find<Api>())),
    tag: 'detail',
    permanent: true,
  );

  OrderDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ObxValue(
      (orderSelected) {
        if (orderSelected.value == null) {
          return const Center(
            child: Text('Clique em um pedido ao lado para ver os detalhes.'),
          );
        } else {
          return controller.obx((state) => OrderWidget(state!, tag: 'detail'));
        }
      },
      orderListController.orderSelected,
    );
  }
}
