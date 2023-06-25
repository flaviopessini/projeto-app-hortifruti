import 'package:app_painel_hortifruti/app/data/models/order.dart';
import 'package:app_painel_hortifruti/app/modules/order_list/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

typedef ItemSelectedCallback = void Function(OrderModel);

class OrderListWidget extends StatelessWidget {
  final controller = Get.find<OrderListController>();
  final ItemSelectedCallback onItemSelected;

  OrderListWidget(this.onItemSelected, {super.key});

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (state) => ListView(
        shrinkWrap: true,
        children: [
          for (var order in state!)
            Obx(() => ListTile(
                  title: Text('# ${order.hashId.toString()}'),
                  subtitle:
                      Text(DateFormat("dd/MM/y HH:mm").format(order.createdAt)),
                  trailing: Chip(
                    label: Text(order.statusList.last.name),
                    elevation: 5.0,
                  ),
                  onTap: () => onItemSelected(order),
                  selected: controller.orderSelected.value == order.hashId
                      ? true
                      : false,
                )),
        ],
      ),
      onEmpty: const Center(
        child: Text('Você não recebeu nenhum pedido ainda.'),
      ),
    );
  }
}
