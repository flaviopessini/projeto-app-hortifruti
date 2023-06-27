import 'package:app_painel_hortifruti/app/data/providers/api.dart';
import 'package:app_painel_hortifruti/app/modules/product/widgets/delete_product_image/delete_product_image_controller.dart';
import 'package:app_painel_hortifruti/app/modules/product/widgets/delete_product_image/delete_product_image_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeleteProductImageWidget extends StatelessWidget {
  final controller = Get.put(
    DeleteProductImageController(
      DeleteProductImageRepository(Get.find<Api>()),
    ),
  );
  DeleteProductImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Deseja excluir a imagem do produto'),
      actions: [
        TextButton(
          onPressed: Get.back,
          child: const Text('Cancelar'),
        ),
        Obx(
          () => TextButton(
            onPressed: controller.isLoading.isTrue ? null : controller.onSubmit,
            child: const Text('Sim'),
          ),
        ),
      ],
    );
  }
}
