import 'package:app_painel_hortifruti/app/data/models/order_product.dart';
import 'package:app_painel_hortifruti/app/modules/order/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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
            child: Card(
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
                        Text('#${state!.hashId}'),
                        Text(DateFormat("dd/MM/y 'às' HH:mm")
                            .format(state.createdAt)),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      'Endereço de entrega',
                      style: Get.textTheme.titleMedium,
                    ),
                    Text(
                        '${state.address!.street}, ${state.address!.number} - ${state.address!.neighborhood}.'),
                    const SizedBox(height: 16.0),
                    Text(
                      'Andamento do pedido',
                      style: Get.textTheme.titleMedium,
                    ),
                    for (var s in state.statusList)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(s.name),
                          Text(DateFormat.Hm().format(s.createdAt)),
                        ],
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
                        for (var p in state.productList)
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
                          NumberFormat.simpleCurrency()
                              .format(state.deliveryCost),
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
                          NumberFormat.simpleCurrency().format(state.value),
                          style: Get.textTheme.titleLarge,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductQuantity(OrderProductModel orderProduct) {
    return Text(
      NumberFormat.decimalPattern().format(orderProduct.quantity) +
          (orderProduct.product.unitOfMeasureIsByKg ? 'kg' : 'x'),
    );
  }
}
