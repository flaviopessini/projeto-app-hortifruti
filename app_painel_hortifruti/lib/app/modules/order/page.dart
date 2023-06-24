import 'package:app_painel_hortifruti/app/widgets/order/order_controller.dart';
import 'package:app_painel_hortifruti/app/widgets/order/order_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderPage extends GetView<OrderController> {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Get.theme.colorScheme.inversePrimary,
        title: const Text('Detalhes do pedido'),
      ),
      body: SafeArea(
        child: controller.obx(
          (state) => SingleChildScrollView(
            padding: const EdgeInsets.all(8.0),
            child: OrderWidget(state!),
          ),
        ),
      ),
    );
  }
}
