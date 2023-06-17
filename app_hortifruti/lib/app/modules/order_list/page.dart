import 'package:app_hortifruti/app/modules/order_list/controller.dart';
import 'package:app_hortifruti/app/routes/routes.dart';
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
        child: controller.obx(
          (state) => ListView(
            children: [
              for (var o in state!)
                ListTile(
                  title: Text('# ${o.hashId.toString()}'),
                  subtitle: Text(o.store.name),
                  trailing: Chip(
                    label: Text(o.statusList.last.name),
                  ),
                  onTap: () => Get.toNamed(
                      Routes.order.replaceFirst(':hashId', o.hashId)),
                ),
            ],
          ),
          onEmpty: const Center(
            child: Text('Você não fez nenhum pedido ainda!'),
          ),
          onError: (error) => Center(
            child: ElevatedButton.icon(
              onPressed: () => Get.offAllNamed(Routes.login),
              label: const Text('Entrar com a minha conta'),
              icon: const Icon(Icons.login_rounded),
            ),
          ),
        ),
      ),
    );
  }
}
