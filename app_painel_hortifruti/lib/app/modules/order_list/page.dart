import 'package:app_painel_hortifruti/app/modules/order_list/controller.dart';
import 'package:app_painel_hortifruti/app/modules/order_list/widgets/order_details_widget.dart';
import 'package:app_painel_hortifruti/app/modules/order_list/widgets/order_list_widget.dart';
import 'package:app_painel_hortifruti/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderListPage extends GetResponsiveView<OrderListController> {
  OrderListPage({super.key});

  @override
  Widget desktop() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Get.theme.colorScheme.inversePrimary,
        title: const Text('Meus pedidos'),
      ),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 2,
              child: Container(
                constraints: const BoxConstraints(
                  maxWidth: 400.0,
                ),
                child: OrderListWidget(controller.changeOrder),
              ),
            ),
            Flexible(
              flex: 3,
              child: OrderDetailsWidget(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget phone() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Get.theme.colorScheme.inversePrimary,
        title: const Text('Meus pedidos'),
      ),
      body: SafeArea(
        child: OrderListWidget(
          (order) => Get.toNamed(
            Routes.order.replaceFirst(':hashId', order.hashId),
          ),
        ),
      ),
    );
  }
}
