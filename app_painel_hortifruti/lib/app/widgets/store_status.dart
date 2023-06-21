import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StoreStatus extends StatelessWidget {
  final bool isOnline;

  const StoreStatus(this.isOnline, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      isOnline ? 'Aberto' : 'Fechado',
      style: Get.textTheme.labelMedium!.copyWith(
        color: isOnline ? Colors.green.shade300 : Colors.red.shade300,
      ),
    );
  }
}
