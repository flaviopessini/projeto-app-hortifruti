import 'package:app_painel_hortifruti/app/modules/order_list/controller.dart';
import 'package:app_painel_hortifruti/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderListWidget extends StatelessWidget {
  final controller = Get.find<OrderListController>();

  OrderListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (state) => ListView(
        shrinkWrap: true,
        children: [
          for (var o in state!)
            ListTile(
              title: Text('# ${o.hashId.toString()}'),
              // subtitle: Text(o.store.name),
              trailing: Chip(
                label: Text(o.statusList.last.name),
              ),
              onTap: () =>
                  Get.toNamed(Routes.order.replaceFirst(':hashId', o.hashId)),
            ),
        ],
      ),
      onEmpty: const Center(
        child: Text('Você não recebeu nenhum pedido ainda.'),
      ),
    );
  }
}
