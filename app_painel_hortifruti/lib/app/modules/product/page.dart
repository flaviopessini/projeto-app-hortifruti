import 'package:app_painel_hortifruti/app/modules/product/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductPage extends GetResponsiveView<ProductController> {
  ProductPage({super.key});

  @override
  Widget builder() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Get.theme.colorScheme.inversePrimary,
        title: const Text('Novo produto'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Column(
          children: [
            if (screen.isPhone) ...[
              _buildForm(),
              const SizedBox(height: 16.0),
              _buildPickAndShowImage(),
              _buildSubmit(),
            ] else ...[
              Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 800.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildForm(),
                            _buildSubmit(),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Flexible(
                        child: _buildPickAndShowImage(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Padding _buildSubmit() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton.icon(
        onPressed: () => controller.onAdd,
        icon: const Icon(Icons.check_rounded),
        label: const Text('Salvar'),
      ),
    );
  }

  Form _buildForm() {
    return Form(
      child: Column(
        children: [
          TextFormField(
            controller: controller.nameController,
            decoration: const InputDecoration(
              labelText: 'Nome',
            ),
            validator: (value) {
              if (value != null && value.trim().isEmpty) {
                return 'Informe o nome do produto';
              }
              return null;
            },
          ),
          TextFormField(
            controller: controller.descriptionController,
            decoration: const InputDecoration(
              labelText: 'Descrição',
            ),
            minLines: 1,
            maxLength: 3,
          ),
          Row(
            children: [
              Flexible(
                flex: 2,
                child: TextFormField(
                  controller: controller.priceController,
                  decoration: const InputDecoration(
                    labelText: 'Preço',
                  ),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              const SizedBox(width: 16.0),
              Flexible(
                flex: 1,
                child: DropdownButtonFormField(
                  decoration: const InputDecoration(
                    labelText: 'Unidade',
                  ),
                  items: ['UN', 'KG']
                      .map(
                        (unit) => DropdownMenuItem(
                          value: unit,
                          child: Text(unit),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    //
                  },
                ),
              )
            ],
          ),
          Obx(
            () => DropdownButtonFormField(
              value: controller.categoryId.value,
              items: controller.categoryList
                  .map(
                    (element) => DropdownMenuItem(
                      value: element.id,
                      child: Text(element.name),
                    ),
                  )
                  .toList(),
              onChanged: controller.changeCategory,
              decoration: const InputDecoration(
                labelText: 'Categoria',
              ),
              validator: (value) {
                if (value == null) {
                  return 'Selecione uma categoria';
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPickAndShowImage() {
    return Column(
      children: [
        // const Align(
        //   alignment: Alignment.centerLeft,
        //   child: Text('Imagem do produto'),
        // ),
        // const SizedBox(height: 16.0),
        Obx(
          () {
            if (controller.image.value != null) {
              return _buildProductImage(
                  Image.memory(controller.image.value!.bytes!));
            }

            return const SizedBox();
          },
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: OutlinedButton.icon(
            onPressed: controller.pickImage,
            icon: const Icon(Icons.image_rounded),
            label: const Text('Selecione uma imagem'),
          ),
        ),
      ],
    );
  }

  Widget _buildProductImage(Widget image) {
    return Align(
      child: Container(
        constraints: const BoxConstraints(maxHeight: 250.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: image,
        ),
      ),
    );
  }
}
