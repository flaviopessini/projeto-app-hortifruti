import 'package:app_hortifruti/app/modules/user_profile/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserProfilePage extends GetView<UserProfileController> {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Get.theme.colorScheme.inversePrimary,
        title: const Text('Meu perfil'),
      ),
      body: SafeArea(
        child: controller.obx(
          (state) => SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: controller.streetController,
                      decoration: const InputDecoration(
                        labelText: 'Rua',
                      ),
                      maxLines: 1,
                      textInputAction: TextInputAction.next,
                      textCapitalization: TextCapitalization.sentences,
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return 'Informe a rua';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: controller.numberController,
                      decoration: const InputDecoration(
                        labelText: 'Número',
                      ),
                      maxLines: 1,
                      textInputAction: TextInputAction.next,
                      textCapitalization: TextCapitalization.sentences,
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return 'Informe o número';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: controller.neighborhoodController,
                      decoration: const InputDecoration(
                        labelText: 'Bairro',
                      ),
                      maxLines: 1,
                      textInputAction: TextInputAction.next,
                      textCapitalization: TextCapitalization.sentences,
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return 'Informe o bairro';
                        }
                        return null;
                      },
                    ),
                    DropdownButtonFormField(
                      decoration: const InputDecoration(
                        labelText: 'Cidade',
                      ),
                      value: controller.cityId.value,
                      items: state!
                          .map(
                            (e) => DropdownMenuItem<int>(
                              value: e.id,
                              child: Text(e.name),
                            ),
                          )
                          .toList(),
                      onChanged: controller.changeCity,
                      validator: (value) {
                        if (value == null) {
                          return 'Selecione uma cidade';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: controller.cepController,
                      decoration: const InputDecoration(
                        labelText: 'Cep',
                      ),
                      maxLines: 1,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                    ),
                    TextFormField(
                      controller: controller.referencePointController,
                      decoration: const InputDecoration(
                        labelText: 'Ponto de referência',
                      ),
                      maxLines: 2,
                      textCapitalization: TextCapitalization.sentences,
                      textInputAction: TextInputAction.next,
                    ),
                    TextFormField(
                      controller: controller.complementController,
                      decoration: const InputDecoration(
                        labelText: 'Complemento',
                      ),
                      maxLines: 2,
                      textCapitalization: TextCapitalization.sentences,
                      textInputAction: TextInputAction.done,
                    ),
                    const SizedBox(height: 32.0),
                    ElevatedButton.icon(
                      onPressed: controller.submit,
                      icon: const Icon(Icons.check_rounded),
                      label: const Text('Salvar'),
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
}
