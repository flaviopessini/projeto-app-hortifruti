import 'package:app_painel_hortifruti/app/modules/order_list/controller.dart';
import 'package:app_painel_hortifruti/app/modules/order_list/widgets/order_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderListPage extends GetView<OrderListController> {
  const OrderListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Get.theme.colorScheme.inversePrimary,
        title: const Text('Meus pedidos'),
      ),
      body: SafeArea(
        child: OrderListWidget(),
      ),
    );
  }
}
