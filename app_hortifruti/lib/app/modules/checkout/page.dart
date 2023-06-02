import 'package:app_hortifruti/app/modules/checkout/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CheckoutPage extends GetView<CheckoutController> {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Get.theme.colorScheme.inversePrimary,
        title: const Text('Checkout'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Obx(
            () => Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Get.theme.colorScheme.inversePrimary,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  width: double.infinity,
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        'Resumo',
                        style: Get.textTheme.titleLarge,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Produtos',
                              style: Get.textTheme.titleMedium,
                            ),
                          ),
                          Text(
                            NumberFormat.simpleCurrency()
                                .format(controller.totalCart),
                            style: Get.textTheme.titleMedium,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Entrega',
                              style: Get.textTheme.titleMedium,
                            ),
                          ),
                          Text(
                            NumberFormat.simpleCurrency()
                                .format(controller.deliveyCost),
                            style: Get.textTheme.titleMedium,
                          ),
                        ],
                      ),
                      const Divider(),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Total',
                              style: Get.textTheme.titleLarge!.copyWith(
                                color: Get.theme.colorScheme.primary,
                              ),
                            ),
                          ),
                          Text(
                            NumberFormat.simpleCurrency()
                                .format(controller.totalOrder),
                            style: Get.textTheme.titleLarge!.copyWith(
                              color: Get.theme.colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                      // const SizedBox(height: 8.0),
                      // ElevatedButton.icon(
                      //   onPressed: () {},
                      //   icon: const Icon(Icons.check_rounded),
                      //   label: const Text('Finalizar pedido'),
                      // ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Get.theme.colorScheme.inversePrimary,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  width: double.infinity,
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        'Endereço',
                        style: Get.textTheme.titleLarge,
                      ),
                      if (controller.addresses.isEmpty)
                        OutlinedButton(
                          onPressed: controller.goToNewAddress,
                          child: const Text('Cadastrar um endereço'),
                        )
                      else
                        Row(
                          children: [
                            //
                          ],
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Get.theme.colorScheme.inversePrimary,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  width: double.infinity,
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        'Formas de pagamento',
                        style: Get.textTheme.titleLarge,
                      ),
                      for (final item in controller.paymentMethods)
                        RadioListTile(
                          title: Text(item.name),
                          value: item,
                          dense: true,
                          groupValue: controller.paymentMethod.value,
                          onChanged: controller.changePaymentMethod,
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                if (!controller.isLogged)
                  OutlinedButton.icon(
                    onPressed: controller.goToLogin,
                    icon: const Icon(Icons.login_rounded),
                    label: const Text('Entre para continuar'),
                  )
                else
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.check_rounded),
                    label: const Text('Finalizar pedido'),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
