import 'package:app_painel_hortifruti/app/data/models/order.dart';
import 'package:app_painel_hortifruti/app/data/models/order_product.dart';
import 'package:app_painel_hortifruti/app/widgets/order/order_controller.dart';
import 'package:app_painel_hortifruti/app/widgets/order_next_status/order_next_status_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OrderWidget extends StatelessWidget {
  final OrderModel order;
  final OrderController controller;

  OrderWidget(this.order, {String? tag, super.key})
      : controller = Get.find<OrderController>(tag: tag);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              //state!.store.name,
              'Texto',
              style: Get.textTheme.headlineMedium,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('#${order.hashId}'),
                Text(DateFormat("dd/MM/y 'às' HH:mm").format(order.createdAt)),
              ],
            ),
            const SizedBox(height: 16.0),
            Text(
              'Endereço de entrega',
              style: Get.textTheme.titleMedium,
            ),
            Text(
                '${order.address!.street}, ${order.address!.number} - ${order.address!.neighborhood}.'),
            const SizedBox(height: 16.0),
            Text(
              'Andamento do pedido',
              style: Get.textTheme.titleMedium,
            ),
            for (var s in order.statusList)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(s.name),
                  Text(DateFormat.Hm().format(s.createdAt)),
                ],
              ),
            OrderNextStatusWidget(
              order.statusList.last,
              controller.onSendStatus,
            ),
            const SizedBox(height: 16.0),
            Text(
              'Produtos',
              style: Get.textTheme.titleMedium,
            ),
            ListView(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: [
                for (var p in order.productList)
                  ListTile(
                    title: Text(
                      p.product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Get.theme.colorScheme.primary,
                      ),
                    ),
                    leading: _buildProductQuantity(p),
                    trailing: Text(
                      NumberFormat.simpleCurrency().format(p.total),
                      style: Get.textTheme.bodyMedium!.copyWith(
                        color: Get.theme.colorScheme.tertiary,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Entrega',
                  style: Get.textTheme.titleMedium,
                ),
                Text(
                  NumberFormat.simpleCurrency().format(order.deliveryCost),
                ),
              ],
            ),
            const Divider(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style: Get.textTheme.titleLarge,
                ),
                Text(
                  NumberFormat.simpleCurrency().format(order.value),
                  style: Get.textTheme.titleLarge,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildProductQuantity(OrderProductModel orderProduct) {
  return Text(
    NumberFormat.decimalPattern().format(orderProduct.quantity) +
        (orderProduct.product.unitOfMeasureIsByKg ? 'kg' : 'x'),
  );
}
