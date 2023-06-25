import 'package:app_painel_hortifruti/app/data/models/next_status.dart';
import 'package:app_painel_hortifruti/app/data/models/order_status.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

typedef OnChangeStatus = void Function(int statusId);

class OrderNextStatusWidget extends StatelessWidget {
  final OrderStatusModel currentStatus;
  final OnChangeStatus onChangeStatus;
  final nextStatusList = {
    1: [
      NextStatus(2, 'Confirmar'),
      NextStatus(5, 'Recusar', isOk: false),
    ],
    2: [
      NextStatus(3, 'Saiu para entrega'),
      NextStatus(5, 'Cancelar', isOk: false),
    ],
    3: [
      NextStatus(4, 'Entregue'),
      NextStatus(5, 'Cancelar', isOk: false),
    ],
  };

  OrderNextStatusWidget(this.currentStatus, this.onChangeStatus, {super.key});

  @override
  Widget build(BuildContext context) {
    var options = nextStatusList[currentStatus.id];

    if (options == null) {
      return const SizedBox();
    }

    return Row(
      children: [
        for (var nextStatus in options) ...[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
            child: OutlinedButton(
              onPressed: () => onChangeStatus(nextStatus.id),
              style: OutlinedButton.styleFrom(
                foregroundColor: nextStatus.isOk
                    ? Get.theme.colorScheme.tertiary
                    : Get.theme.colorScheme.error,
                side: BorderSide(
                  color: nextStatus.isOk
                      ? Get.theme.colorScheme.tertiary
                      : Get.theme.colorScheme.error,
                ),
              ),
              child: Text(nextStatus.text),
            ),
          ),
        ],
      ],
    );
  }
}
