import 'package:app_painel_hortifruti/app/data/providers/api.dart';
import 'package:app_painel_hortifruti/app/modules/product/widgets/new_category/new_category_controller.dart';
import 'package:app_painel_hortifruti/app/modules/product/widgets/new_category/new_category_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewCategoryWidget extends StatelessWidget {
  final controller =
      Get.put(NewCategoryController(NewCategoryRepository(Get.find<Api>())));

  NewCategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Nova categoria'),
      scrollable: true,
      content: Form(
        key: controller.formKey,
        child: Column(
          children: [
            TextFormField(
              controller: controller.nameController,
              decoration: const InputDecoration(
                labelText: 'Nome',
              ),
              validator: (value) {
                if (value != null && value.trim().isEmpty) {
                  return 'Informe o nome da categoria';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: Get.back,
          child: const Text('Fechar'),
        ),
        Obx(
          () => TextButton(
            onPressed: controller.isLoading.isTrue ? null : controller.onSubmit,
            child: const Text('Adicionar'),
          ),
        ),
      ],
    );
  }
}
